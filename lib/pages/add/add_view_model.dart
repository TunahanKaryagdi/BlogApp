import 'package:blog_app/services/firestore_service.dart';
import 'package:blog_app/services/storage_service.dart';
import 'package:blog_app/utils/storage_folder_enum.dart';
import 'package:blog_app/utils/string_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/blog.dart';
import '../../utils/firebase_collection_enum.dart';

class AddViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService<Blog>();
  final StorageService _storageService = StorageService();
  TextEditingController titleText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();
  List<String> tags = [];
  bool isLoading = false;

  XFile? pickedImage;
  final ImagePicker _imagePicker = ImagePicker();

  void checkAndUpdate(bool isSelected, String text) {
    if (isSelected) {
      tags.add(text);
    } else {
      tags.remove(text);
    }
  }

  Future<void> saveBlogToFirebase() async {
    changeLoading();
    String? photoUrl;
    if (pickedImage != null) {
      photoUrl = await _storageService.uploadImage(
          pickedImage!,
          StorageFolders.blogImages,
          "${DateTime.now().microsecondsSinceEpoch}");
    }

    Blog newBlog = Blog(
        null,
        titleText.text,
        descriptionText.text,
        tags,
        [],
        Timestamp.fromDate(DateTime.now()),
        photoUrl ?? StringConstants.defaultImage);
    await _firestoreService.saveToFirebase(newBlog, FirebaseCollections.blogs);
    changeLoading();
    clear();
  }

  Future<void> pickImageFromCamera() async {
    pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void clear() {
    tags.clear();
    titleText.text = "";
    descriptionText.text = "";
    pickedImage = null;
    notifyListeners();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
