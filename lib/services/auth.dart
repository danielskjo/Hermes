import 'package:firebase_auth/firebase_auth.dart';

import './database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with email and password
  Future register(
    String username,
    String email,
    String university,
    String address,
    String password,
    String imageUrl,
    String role,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService().createUserData(
        user.uid,
        username,
        email,
        university,
        address,
        password,
        imageUrl,
        role,
      );
      return user;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (err) {
      print(err.toString());
    }
  }

  // Sign out
  Future logout() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Delete user
  Future deleteUser() {
    User user = FirebaseAuth.instance.currentUser;
    DatabaseService().deleteUserData(user.uid);
    return user.delete();
  }

  // Update email
  void changeEmail(String email) async {
    User user = _auth.currentUser;

    user.updateEmail(email).then((_) {
      print('Successfully changed email');
    }).catchError((error) {
      print('Email cannot be changed');
    });
  }

  // Update Password
  void changePassword(String password) async {
    User user = _auth.currentUser;

    user.updatePassword(password).then((_) {
      print('Successfully changed password');
    }).catchError((error) {
      print('Password cannot be changed');
    });
  }
}
