import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // User Collection
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // [ALL] Create document in user collection for new user
  Future<void> createUserData(
    String uid,
    String username,
    String email,
    String university,
    String address,
    String password,
    String imageUrl,
    String role,
  ) async {
    return await users.doc(uid).set({
      "username": username,
      "email": email,
      "university": university,
      "address": address,
      "password": password,
      "imageUrl": imageUrl,
      "role": role,
    });
  }

  // [ALL] Get current user's data
  getUserData(String uid) async {
    try {
      return await users.doc(uid).get();
    } catch (err) {
      print(err.toString());
    }
  }

  // [ALL] Update document in user collection for existing user
  Future updateUser(
    String uid,
    String username,
    String email,
    String university,
    String address,
    String password,
    String imageUrl,
  ) async {
    return await users.doc(uid).update({
      "username": username,
      "email": email,
      "university": university,
      "address": address,
      "password": password,
      "imageUrl": imageUrl,
    });
  }

  // [ALL] Delete user data
  Future<void> deleteUserData(String uid) {
    return users
        .doc(uid)
        .delete()
        .then((value) => print('User deleted'))
        .catchError((err) => print('Failed to delete user'));
  }



  // Requests collection
  final CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  // [STUDENT] Create document in request collection for new request
  Future<void> createRequestData(
    String rid,
    String uid,
    String username,
    String imageUrl,
    String title,
    String desc,
    DateTime date,
  ) async {
    return await requests.doc(rid).set({
      'uid': uid,
      'username': username,
      'imageUrl': imageUrl,
      'title': title,
      'desc': desc,
      'date': date,
    });
  }

  // [STUDENT] Get all of the current user's requests
  getUsersRequestsData(String uid) async {
    try {
      return await requests.where('uid', isEqualTo: uid).get();
    } catch (err) {
      print(err.toString());
    }
  }

  // [ALL USERS] Get a single request
  getRequestData(String rid) async {
    try {
      return await requests.doc(rid).get();
    } catch (err) {
      print(err.toString());
    }
  }

  // [DONOR] Get all requests
  getRequestsData() async {
    try {
      return await requests.orderBy('date', descending: true).get();
    } catch (err) {
      print(err.toString());
    }
  }

  // [STUDENT] Update document in request collection for existing request
  Future<void> updateRequestData(
    String rid,
    String title,
    String desc,
    DateTime date,
  ) async {
    return await requests.doc(rid).set({
      'title': title,
      'desc': desc,
      'date': date,
    });
  }

  // [STUDENT] Delete request
  Future<void> deleteRequestData(String rid) {
    return requests
        .doc(rid)
        .delete()
        .then((value) => print('Request deleted'))
        .catchError((err) => print('Failed to delete request'));
  }
}
