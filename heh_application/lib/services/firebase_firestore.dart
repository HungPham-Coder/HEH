import 'package:flutter/cupertino.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/chat_model/user_chat.dart';

abstract class FirebaseFirestoreBase {
  Stream<List<SignUpUser>> getAllUser();
  Future<UserChat?>? getPhysioUser({required String physioID});
}

class FirebaseFirestores extends FirebaseFirestoreBase {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firestoreService = FirestoreService.instance;
  @override
  Stream<List<SignUpUser>> getAllUser() => _firestoreService.collectionStream(
        path: 'user',
        builder: (data, documentId) => SignUpUser.fromMap(data, documentId),
      );

  @override
  Future<UserChat?>? getPhysioUser({required String physioID}) async {
    // TODO: implement getChatUser
    // final test = _firestoreService.documentStream(
    //    'user/physiotherapist', (data, documentID) => UserChat.fromMap(data!, documentID),
    // );
    // test.listen((event) {
    //   if (event == null) {
    //     print("null");
    //   }
    //   print(event.nickname);});
    // return test;
    final docSnapshot = await _firebaseFirestore.collection('user').doc(physioID).get();
    if (docSnapshot.exists){
      return UserChat.fromMap(docSnapshot.data(), docSnapshot.id);
    }
  }
}
