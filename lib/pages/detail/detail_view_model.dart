import 'package:blog_app/models/active_user.dart';
import 'package:blog_app/services/firestore_service.dart';
import 'package:blog_app/services/user_manager.dart';
import 'package:blog_app/utils/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/blog.dart';

class DetailViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
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
    await _firestoreService.updateDocument(
        FirebaseCollections.blogs, blog.id!, {'like': newArray});

    await getUpdatedBlog(blog.id!);
  }

  Future<void> unLikeBlog(Blog blog, String userId) async {
    List<String> newArray = blog.like;
    newArray.remove(userId);

    await _firestoreService.updateDocument(
        FirebaseCollections.blogs, blog.id!, {'like': newArray});

    await getUpdatedBlog(blog.id!);
  }

  Future<void> getUpdatedBlog(String blogId) async {
    DocumentSnapshot snapshot = await _firestoreService.getDocumentById(
        FirebaseCollections.blogs, blogId);

    activeBlog = Blog.fromSnapshot(snapshot);
    notifyListeners();
  }
}
