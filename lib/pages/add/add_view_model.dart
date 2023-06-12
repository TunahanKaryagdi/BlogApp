import 'package:blog_app/models/user.dart';
import 'package:blog_app/services/blog_service.dart';
import 'package:blog_app/services/storage_service.dart';
import 'package:blog_app/services/user_manager.dart';
import 'package:blog_app/utils/storage_folder_enum.dart';
import 'package:blog_app/utils/string_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/blog.dart';

class AddViewModel extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  final BlogService _blogService = BlogService();

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

  Future<void> saveBlog() async {
    changeLoading();
    Blog newBlog = await generateBlog();
    await _blogService.save(newBlog, UserManager.getUserData()!.id);
    changeLoading();
    clear();
  }

  Future<String> savePhoto() async {
    String url = await _storageService.uploadImage(pickedImage!,
        StorageFolders.blogImages, "${DateTime.now().microsecondsSinceEpoch}");
    return url;
  }

  Future<void> pickImageFromCamera() async {
    pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  Future<Blog> generateBlog() async {
    String? photoUrl;
    if (pickedImage != null) {
      photoUrl = await savePhoto();
    }

    return Blog(
        null,
        titleText.text,
        descriptionText.text,
        tags,
        [],
        Timestamp.fromDate(DateTime.now()),
        photoUrl ?? StringConstants.defaultImage,
        User.fromActiveUser(UserManager.getUserData()!));
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
