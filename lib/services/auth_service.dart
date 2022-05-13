import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/notifiers/notifiers.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static String getCurrentUser() {
    return _auth.currentUser!.uid;
  }

  static String getCurrentUsername() {
    if (_auth.currentUser!.displayName == null) {
      return 'Friend';
    }
    return _auth.currentUser!.displayName!;
  }

  // AppUser from Firebase user
  static AppUser? _appUserFromFirebaseUser(User? user) {
    return (user != null) ? AppUser(uid: user.uid, households: []) : null;
  }

  // Decoupling firebase service and main app by setting custom errors for auth service
  static CustomError _customErrorFromFirebaseAuthException(FirebaseAuthException error) {
    return CustomError(code: error.code, message: error.message!);
  }

  // Decoupling firebase service and main app by setting custom errors for auth service
  static CustomError _customErrorFromFirebaseException(FirebaseException error) {
    return CustomError(code: error.code, message: error.message!);
  }

  // Auth user stream
  Stream<AppUser?> get appUserStream {
    return _auth.authStateChanges().map((User? user) => _appUserFromFirebaseUser(user));
  }

  // Sign In
  static Future signInWithEmailPassword(UserNotifier userNotifier, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        AppUser appUser = await UserDatabaseService.getUser(userID: user.uid);
        userNotifier.setCurrentUser = appUser;
      }

      return _appUserFromFirebaseUser(user);
    } on FirebaseAuthException catch (error) {
      return _customErrorFromFirebaseAuthException(error);
    }
  }

  // Register
  static Future registerWithEmailPassword(UserNotifier userNotifier, AppUser appUser, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      AppUser newAppUser = appUser.copy(uid: user!.uid);

      await updateDisplayName(userNotifier, user, newAppUser.firstName);

      // Add user document to database
      await UserDatabaseService.createUserRecord(newAppUser);

      userNotifier.setCurrentUser = _appUserFromFirebaseUser(user)!;
      return _appUserFromFirebaseUser(user);
    } on FirebaseAuthException catch (error) {
      return _customErrorFromFirebaseAuthException(error);
    } on FirebaseException catch (error) {
      return _customErrorFromFirebaseException(error);
    }
  }

  static Future updateDisplayName(UserNotifier userNotifier, User user, String displayName) async {
    // Update user display name
    await user.updateDisplayName(displayName);
    await user.reload();
  }

  // Forgot password
  static Future forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (error) {
      return _customErrorFromFirebaseAuthException(error);
    }
  }

  // Sign Out
  static Future signOut() async {
    try {
      await _auth.signOut();
      return null;
    } on FirebaseAuthException catch (error) {
      return _customErrorFromFirebaseAuthException(error);
    }
  }
}
