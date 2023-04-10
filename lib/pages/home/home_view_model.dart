import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/firebase_collection_enum.dart';

class HomeViewModel {
  Stream<QuerySnapshot> getBlogStreams() {
    return FirebaseCollections.blogs.reference.snapshots();
  }
}
