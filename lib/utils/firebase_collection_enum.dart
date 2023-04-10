import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

enum FirebaseCollections {
  users,
  blogs;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
