import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:csulb_dsc_2021/services/helper/helperFunctions.dart';

class DatabaseService {
  // User Collection
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  // Chat Room Collection
  final CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('chat-rooms');

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
      "userNameSearch": HelperFunctions().setSearchParam(username),
    });
  }

  // Check if username is unique
  Future<bool> checkUsername(String username) async {
    final result = await users.where('username', isEqualTo: username).get();
    return result.docs.isEmpty;
  }

  // Check if email is used
  Future<bool> checkEmail(String email) async {
    final result = await users.where('email', isEqualTo: email).get();
    return result.docs.isEmpty;
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
      "userNameSearch": HelperFunctions().setSearchParam(username),
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

  /// Returns a stream of users that closely match the given username
  Future<Stream<QuerySnapshot>> getUserByUsername(String username) async {
    return users
        .where(
          'userNameSearch',
          arrayContains: username,
        )
        .snapshots();
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    return await users
        .where('email', isEqualTo: email)
        .limit(1)
        .get()
        .catchError((err) => print('Failed to get user by email'));
  }

  Future<void> createChatRoom({Map chatRoomData, String chatRoomId}) async {
    final snapshot = await chatRooms.doc(chatRoomId).get();

    /// Setup the chat room in the database
    /// if it hasn't been created
    if (!snapshot.exists) {
      await chatRooms.doc(chatRoomId).set(chatRoomData);
    } else {
      print("Chat room already exists \n");
    }
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    print('getting chat rooms for user: ' + Constants.myUserName);
    return chatRooms
        .orderBy("lastMessageTimeStamp", descending: true)
        .where(
          'users',
          arrayContains: Constants.myUserName,
        )
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getConversationMessages(
      String chatRoomId) async {
    return chatRooms
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('time-stamp', descending: true)
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, Map chatMessageData) async {
    await chatRooms
        .doc(chatRoomId)
        .collection('messages')
        .add(chatMessageData)
        .catchError((err) => print('Failed to send a message'));
  }

  Future<void> updateLastMessageSent(
      {String chatRoomId, Map lastMessageInfoMap}) async {
    await chatRooms.doc(chatRoomId).update(lastMessageInfoMap);
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
    return await requests.doc(rid).update({
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
