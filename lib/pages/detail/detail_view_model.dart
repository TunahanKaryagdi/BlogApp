import 'package:blog_app/models/active_user.dart';
import 'package:blog_app/services/blog_service.dart';
import 'package:blog_app/services/user_manager.dart';
import 'package:flutter/material.dart';

import '../../models/blog.dart';

class DetailViewModel extends ChangeNotifier {
  final BlogService _blogService = BlogService();
  Blog? activeBlog;

  bool isLiked(Blog blog, String userId) {
    if (blog.like.contains(userId)) {
      return true;
    }
    return false;
  }

  Future<void> onClickedLikeButton(Blog blog, String userId) async {
    if (isLiked(blog, userId)) {
      await unLikeBlog(blog, userId);
    } else {
      await likeBlog(blog, userId);
    }
  }

  ActiveUser? getActiveUser() {
    return UserManager.getUserData();
  }

  Future<void> likeBlog(Blog blog, String userId) async {
    List<String> newArray = blog.like;
    newArray.add(userId);
    if (blog.id != null) {
      await _blogService.updateBlog(blog.id!, {'like': newArray});
      await getUpdatedBlog(blog.id!);
    }
  }

  Future<void> unLikeBlog(Blog blog, String userId) async {
    List<String> newArray = blog.like;
    newArray.remove(userId);
    if (blog.id != null) {
      await _blogService.updateBlog(blog.id!, {'like': newArray});
      await getUpdatedBlog(blog.id!);
    }
  }

  Future<void> getUpdatedBlog(String blogId) async {
    activeBlog = await _blogService.getBlogById(blogId);
    notifyListeners();
  }
}
