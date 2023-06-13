import 'package:blog_app/services/firestore/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/blog.dart';
import '../../models/user.dart';
import '../../utils/firebase_collection_enum.dart';

class BlogService {
  CollectionReference instance = FirebaseCollections.blogs.reference;
  final UserService _userService = UserService();

  Future<void> save(Blog blog, String userId) async {
    try {
      await instance.add(blog.toMap(userId));
    } catch (e) {
      print('bir hatayla karşılaşıldı');
    }
  }

  Future<List<Blog>> getAll() async {
    final List<Blog> blogList = [];
    final snapshots = await instance.get();

    for (var element in snapshots.docs) {
      blogList.add(Blog.fromSnapshot(
          element, await _userService.getUserById(element['userId'])));
    }

    return blogList;
  }

  Future<Blog> getBlogById(String id) async {
    final snapshot = await instance.doc(id).get();
    final User user = await _userService.getUserById(snapshot['userId']);
    return Blog.fromSnapshot(snapshot, user);
  }

  Future<void> updateBlog(String id, Map<String, dynamic> newField) async {
    await instance.doc(id).update(newField);
  }
}
