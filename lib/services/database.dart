import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // User Collection
  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  // ChatRoom Collection
  final CollectionReference chatRoom =
  FirebaseFirestore.instance.collection('chat_room');

  // Create document in user collection for new user
  Future<void> createUserData(String uid,
      String username,
      String email,
      String university,
      String address,
      String password,
      String imageUrl,
      String role,) async {
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

  // Update document in user collection for existing user
  // Set to replace all the document data
  // Update to update a document
  Future updateUser(String uid,
      String username,
      String email,
      String university,
      String address,
      String password,
      String imageUrl,) async {
    return await users
        .doc(uid)
        .update({
      "username": username,
      "email": email,
      "university": university,
      "address": address,
      "password": password,
      "imageUrl": imageUrl,
    });
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

  Future<QuerySnapshot> getUserByUsername(String username) async {
    return await users
        .where('username', isEqualTo: username,)
        .limit(1)
        .get()
        .catchError((err) => print('Failed to get user by username'));
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    return await users
        .where('email', isEqualTo: email)
        .limit(1)
        .get()
        .catchError((err) => print('Failed to get user by email'));
  }

  Future<void> createChatRoom(Map chatRoomData, String chatRoomId) async {

    final snapshot = await chatRoom
        .doc(chatRoomId)
        .get();

    if(!snapshot.exists) {
      return await chatRoom
          .doc(chatRoomId)
          .set(chatRoomData);

    } else {
      print("Chat room already exists \n");
    }
  }

  Future<Stream<QuerySnapshot>> getConversationMessages(String chatRoomId) async {
    return chatRoom
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time-stamp', descending: true)
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, Map chatMessageData) async {
    chatRoom
        .doc(chatRoomId)
        .collection('chats')
        .add(chatMessageData)
        .catchError((err) => print('Failed to send a message'));
  }

}
