import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

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
}
