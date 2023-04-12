import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  users,
  blogs;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
