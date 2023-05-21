import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/firebase_collection_enum.dart';

class FirestoreService<T extends Model> {
  Future<String> saveToFirebase(T model, FirebaseCollections instance) async {
    DocumentReference docRef = instance.reference.doc();
    await docRef.set(model.toMap());
    return docRef.id;
  }

  Future<QuerySnapshot> getDocumentsFromFirebase(
      FirebaseCollections instance) async {
    final snapshots = await instance.reference.get();
    return snapshots;
  }

  Future<DocumentSnapshot> getDocumentById(
      FirebaseCollections instance, String docId) async {
    return await instance.reference.doc(docId).get();
  }

  Future<void> updateDocument(
    FirebaseCollections instance,
    String docId,
    Map<String, dynamic> newData,
  ) async {
    await instance.reference.doc(docId).update(newData);
  }
}

abstract class Model {
  Map<String, dynamic> toMap();
}
