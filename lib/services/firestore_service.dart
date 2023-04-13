import '../utils/firebase_collection_enum.dart';

class FirestoreService<T extends Model> {
  Future<void> saveToFirebase(T model, FirebaseCollections instance) async {
    await instance.reference.doc().set(model.toMap());
  }
}

abstract class Model {
  Map<String, dynamic> toMap();
}
