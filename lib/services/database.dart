import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // User Collection
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // Create document in user collection for new user
  Future<void> createUserData(
    String uid,
    String username,
    String email,
    String university,
    String address,
    String password,
    String imageUrl,
    String role,
    List requests,
  ) async {
    return await users.doc(uid).set({
      "username": username,
      "email": email,
      "university": university,
      "address": address,
      "password": password,
      "imageUrl": imageUrl,
      "role": role,
      "requests": requests,
    });
  }

  // Update document in user collection for existing user
  // Set to replace all the document data
  // Update to update a document
  Future updateUser(
    String uid,
    String username,
    String email,
    String university,
    String address,
    String password,
    String imageUrl,
    List requests,
  ) async {
    return await users
        .doc(uid)
        .update({
          "username": username,
          "email": email,
          "university": university,
          "address": address,
          "password": password,
          "imageUrl": imageUrl,
          "requests": requests,
        })
        .then((_) => print('User updated'))
        .catchError((err) => print('Failed: $err'));
  }

  // Get current user's data
  getUserData(String uid) async {
    try {
      return await users.doc(uid).get();
    } catch (err) {
      print(err.toString());
    }
  }

  // Delete user data
  Future<void> deleteUserData(String uid) {
    return users
        .doc(uid)
        .delete()
        .then((value) => print('User deleted'))
        .catchError((err) => print('Failed to delete user'));
  }
}
