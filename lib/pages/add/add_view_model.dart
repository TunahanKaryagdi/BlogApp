import 'package:blog_app/services/auth_service.dart';
import 'package:blog_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/blog.dart';
import '../../utils/firebase_collection_enum.dart';

class AddViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService<Blog>();
  TextEditingController titleText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();
  List<String> tags = [];
  bool isLoading = false;

  void checkAndUpdate(bool isSelected, String text) {
    if (isSelected) {
      tags.add(text);
    } else {
      tags.remove(text);
    }
  }

  Future<void> saveBlogToFirebase() async {
    changeLoading();
    Blog newBlog = Blog(titleText.text, descriptionText.text, tags,
        Timestamp.fromDate(DateTime.now()));
    //await FirebaseCollections.blogs.reference.doc().set(newBlog.toMap());
    await _firestoreService.saveToFirebase(newBlog, FirebaseCollections.blogs);
    changeLoading();
    clear();
  }

  void clear() {
    tags.clear();
    titleText.text = "";
    descriptionText.text = "";
    notifyListeners();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
