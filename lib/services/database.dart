import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(
  final String username,
  final String email,
  final String password,
  final String university,
  final String address,
  final String imageUrl,
  final bool student,
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
    'student': student,
  });

  return;
}
