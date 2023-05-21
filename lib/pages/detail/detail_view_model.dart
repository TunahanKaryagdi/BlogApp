import 'package:blog_app/models/active_user.dart';
import 'package:blog_app/services/firestore_service.dart';
import 'package:blog_app/utils/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/blog.dart';

class DetailViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> onClickedLikeButton(Blog blog, String userId) async {
    if (blog.like.contains(userId)) {
      unLikeBlog(blog, userId);
    }

    await likeBlog(blog, userId);
  }

  ActiveUser getActiveUser(BuildContext context) {
    return context.read<ActiveUser>();
  }

  Future<void> likeBlog(Blog blog, String userId) async {
    List<String> newArray = blog.like;
    newArray.add(userId);
    await _firestoreService.updateDocument(
        FirebaseCollections.blogs, blog.id!, {'like': newArray});
  }

  Future<void> unLikeBlog(Blog blog, String userId) async {
    List<String> newArray = blog.like;
    newArray.remove(userId);
    await _firestoreService.updateDocument(
        FirebaseCollections.blogs, blog.id!, {'like': newArray});
  }
}
