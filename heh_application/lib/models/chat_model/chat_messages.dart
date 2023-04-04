import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heh_application/constant/firestore_constant.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;
  ChatMessages(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    return ChatMessages(
        idFrom: documentSnapshot.get(FirestoreConstants.idFrom),
        idTo: documentSnapshot.get(FirestoreConstants.idTo),
        timestamp: documentSnapshot.get(FirestoreConstants.timestamp),
        content: documentSnapshot.get(FirestoreConstants.content),
        type: documentSnapshot.get(FirestoreConstants.type)
    );
  }
}
