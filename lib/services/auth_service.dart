import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/services/services.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static String getCurrentUser() {
    return _auth.currentUser!.uid;
  }

  // AppUser from Firebase user
  static AppUser? _appUserFromFirebaseUser(User? user) {
    return (user != null) ? AppUser(uid: user.uid) : null;
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
  static Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _appUserFromFirebaseUser(user);
    } on FirebaseAuthException catch (error) {
      return _customErrorFromFirebaseAuthException(error);
    }
  }

  // Register
  static Future registerWithEmailPassword(AppUser appUser, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      AppUser newAppUser = appUser.copy(uid: user!.uid);

      // Add user document to database
      await UserDatabaseService.createUserRecord(newAppUser);

      return _appUserFromFirebaseUser(user);
    } on FirebaseAuthException catch (error) {
      return _customErrorFromFirebaseAuthException(error);
    } on FirebaseException catch (error) {
      return _customErrorFromFirebaseException(error);
    }
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
