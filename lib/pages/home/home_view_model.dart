import 'package:blog_app/services/firestore/blog_service.dart';
import 'package:blog_app/utils/strings.dart';
import 'package:flutter/material.dart';

import '../../models/blog.dart';
import '../../utils/custom_navigator.dart';

class HomeViewModel extends ChangeNotifier {
  final BlogService _blogService = BlogService();

  List<Blog> blogList = [];
  bool isLoading = false;

  Future<void> getBlogs() async {
    changeLoading();
    blogList = await _blogService.getAll();
    changeLoading();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void goToDetailPage(BuildContext context, Blog blog) {
    CustomNavigator.pushToWithArgument(context, Strings.detailRoute, blog);
  }
}
