import 'package:blog_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../models/blog.dart';
import '../../models/user.dart';
import '../../utils/custom_navigator.dart';
import '../../utils/firebase_collection_enum.dart';
import '../detail/detail_view.dart';

class HomeViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Blog> blogList = [];
  bool isLoading = false;

  Future<void> getBlogs() async {
    final usersSnapshot = await _firestoreService
        .getDocumentFromFirebase(FirebaseCollections.users);

    final blogsSnapshot = await _firestoreService
        .getDocumentFromFirebase(FirebaseCollections.blogs);
    final List<Blog> blogs = blogsSnapshot.docs.map((doc) {
      final userId = doc.get('userId');

      final user = usersSnapshot.docs
          .firstWhereOrNull((element) => element.id == userId);

      if (user == null) {
        return Blog.fromSnapshot(doc);
      }
      return Blog.fromSnapshot(doc, user: User.fromSnapshot(user));
    }).toList();

    blogList = blogs;
    notifyListeners();
  }

  Future<void> start() async {
    changeLoading();
    await getBlogs();
    changeLoading();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  String calculateDate(Timestamp date) {
    DateTime temp = date.toDate();
    Duration difference = DateTime.now().difference(temp);
    if (difference.inDays == 0) {
      return "${difference.inMinutes} minutes ago";
    }
    return '${difference.inDays.toString()} days ago';
  }

  void goToDetailPage(BuildContext context, Blog blog) {
    CustomNavigator.pushTo(context, DetailView(blog: blog));
  }
}
