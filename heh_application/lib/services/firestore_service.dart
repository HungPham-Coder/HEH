import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final _firebaseFirestore = FirebaseFirestore.instance;
  // final _cloudStorage = FirebaseStorage.instance;
  FirestoreService._();
  //singleton
  static final instance = FirestoreService._();
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    // int Function (T lhs, T rhs)? sort,
  }) {
    Query<Map<String, dynamic>> query = _firebaseFirestore.collection(path);
    final snapshots = query.snapshots();
    return snapshots.map((event) {
      //event is snapshot of that collection
      //event.docs is get every document in that collection
      final result = event.docs
          .map((e) => builder(e.data(), e.id))
          .where((element) => element != null)
          .toList();
      return result;
    });
  }

  Stream<T> documentStream<T>(
      String path, T builder(Map<String, dynamic>? data, String documentID))
  {
    print(path);
    final reference = _firebaseFirestore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(),snapshot.id));
  }
}
