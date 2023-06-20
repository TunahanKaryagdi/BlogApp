import 'package:blog_app/services/firestore/blog_service.dart';
import 'package:blog_app/services/local/user_manager.dart';
import 'package:flutter/material.dart';

import '../../models/blog.dart';
import '../../utils/custom_navigator.dart';
import '../../utils/strings.dart';

class FavoriteViewModel extends ChangeNotifier {
  final BlogService _blogService = BlogService();

  List<Blog> favoriteBlogs = [];
  bool isLoading = false;

  void getFavoriteBlogs() async {
    changeLoading();
    List<Blog> blogs = await _blogService.getAll();

    favoriteBlogs = blogs
        .where(
            (blog) => blog.like.contains(UserManager.getUserData()?.id ?? ''))
        .toList();

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
