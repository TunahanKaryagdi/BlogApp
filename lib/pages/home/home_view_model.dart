import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/blog.dart';
import '../../models/user.dart';
import '../../utils/firebase_collection_enum.dart';

class HomeViewModel extends ChangeNotifier {
  List<Blog> blogList = [];
  bool isLoading = false;

  Future<void> getBlogs() async {
    final usersSnapshot = await FirebaseCollections.users.reference.get();
    final blogsSnapshot = await FirebaseCollections.blogs.reference.get();

    final List<User> users =
        usersSnapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();

    final List<Blog> blogs = blogsSnapshot.docs.map((doc) {
      final userId = doc.get('userId');
      final user =
          usersSnapshot.docs.firstWhere((element) => element.id == userId);

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
    return '${difference.inDays.toString()} days ago';
  }
}
