import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_care/auth/models/user_model.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // AppUser from Firebase user
  static AppUser? _appUserFromFirebaseUser(User? user) {
    return (user != null) ? AppUser(id: user.uid) : null;
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

  // Forgot password

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
