import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:heh_application/constant/firestore_constant.dart';
import 'package:heh_application/models/chat_model/chat_messages.dart';

abstract class ChatProviderBase {
  UploadTask upLoadImageFile(File image, String filename);
  Future<void> upLoadFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate);
  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit);
  void sendChatMessage(String groupChatId, String content, int type,
      String currentID, String peerID);
}

class ChatProvider extends ChatProviderBase {
  final _firebaseStorage = FirebaseStorage.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
    // TODO: implement getChatMessage
    return _firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  @override
  void sendChatMessage(String groupChatId, String content, int type,
      String currentID, String peerID) {
    DocumentReference documentReference = _firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    ChatMessages chatMessages = ChatMessages(
        idFrom: currentID,
        idTo: peerID,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);
    _firebaseFirestore.runTransaction((transaction) async {
      transaction.set(documentReference, chatMessages.toJson());
    });
  }

  @override
  Future<void> upLoadFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    // TODO: implement upLoadFirestoreData
    return _firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }

  @override
  UploadTask upLoadImageFile(File image, String filename) {
    // TODO: implement upLoadImageFile
    Reference reference = _firebaseStorage.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image as File);
    return uploadTask;
  }
}
