import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(
  String username,
  String email,
  String password,
  String university,
  String address,
  String imageUrl,
  String role,
  List requests,
) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid.toString();

  users.add({
    'uid': uid,
    'username': username,
    'email': email,
    'password': password,
    'university': university,
    'address': address,
    'imageUrl': imageUrl,
    'role': role,
    'requests': requests,
  });

  return;
}
