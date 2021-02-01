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
  Future updateUser(
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
    return await users.doc(uid).update({
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

  Future getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await users.doc(uid).get();
      String username = snapshot.get('username');
      String email = snapshot.get('email');
      String university = snapshot.get('university');
      String address = snapshot.get('address');
      String password = snapshot.get('password');
      return [username, email, university, address, password];
    } catch (err) {
      print(err.toString());
    }
  }
}
