import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/firebase_collection_enum.dart';

class FirestoreService<T extends Model> {
  Future<void> saveToFirebase(T model, FirebaseCollections instance) async {
    await instance.reference.doc().set(model.toMap());
  }

  Future<QuerySnapshot> getDocumentFromFirebase(
      FirebaseCollections instance) async {
    final snapshots = await instance.reference.get();
    return snapshots;
  }
}

abstract class Model {
  Map<String, dynamic> toMap();
}
