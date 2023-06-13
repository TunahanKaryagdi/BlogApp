import 'package:blog_app/utils/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user.dart';

class UserService {
  CollectionReference instance = FirebaseCollections.users.reference;

  Future<String> save(User user) async {
    DocumentReference docRef = instance.doc();
    await docRef.set(user.toMap());
    return docRef.id;
  }

  Future<List<User>> getAll() async {
    final snapshots = await instance.get();
    final List<User> userList =
        snapshots.docs.map((snapshot) => User.fromSnapshot(snapshot)).toList();

    return userList;
  }

  Future<User> getUserById(String id) async {
    final snapshot = await instance.doc(id).get();
    return User.fromSnapshot(snapshot);
  }

  Future<String> getUserIdByEmail(String email) async {
    final snapshot = await instance.get();
    final userSnapshot =
        snapshot.docs.firstWhere((element) => element['email'] == email);
    return userSnapshot.id;
  }

  Future<void> updateUser(String id, Map<String, dynamic> newField) async {
    await instance.doc(id).update(newField);
  }
}
