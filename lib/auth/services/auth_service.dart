import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_care/auth/models/user_model.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // AppUser from Firebase user
  static AppUser? _appUserFromFirebaseUser(User? user) {
    return (user != null) ? AppUser(id: user.uid) : null;
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
      return error;
    }
  }

  // Register
  static Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _appUserFromFirebaseUser(user);
    } on FirebaseAuthException catch (error) {
      return error;
    }
  }

  // Forgot password
  static Future forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (error) {
      return error;
    }
  }

  // Sign Out
  static Future signOut() async {
    try {
      await _auth.signOut();
      return null;
    } on FirebaseAuthException catch (error) {
      return error;
    }
  }
}
