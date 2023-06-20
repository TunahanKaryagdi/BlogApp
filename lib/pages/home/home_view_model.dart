import 'package:blog_app/services/firestore/blog_service.dart';
import 'package:blog_app/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/blog.dart';
import '../../utils/custom_navigator.dart';

class HomeViewModel extends ChangeNotifier {
  final BlogService _blogService = BlogService();

  List<Blog> blogList = [];
  bool isLoading = false;

  Future<void> getBlogs() async {
    blogList = await _blogService.getAll();
    notifyListeners();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  String calculateDate(Timestamp date) {
    DateTime temp = date.toDate();
    Duration difference = DateTime.now().difference(temp);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return "${difference.inMinutes} minutes ago";
      }
      return "${difference.inHours} hours ago";
    }
    return '${difference.inDays.toString()} days ago';
  }

  void goToDetailPage(BuildContext context, Blog blog) {
    CustomNavigator.pushToWithArgument(context, Strings.detailRoute, blog);
  }
}
