import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Sign in with email and password

  // Register with email and pasowrd

  // Sign out
}
