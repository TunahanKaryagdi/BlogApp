import 'package:blog_app/models/user.dart';
import 'package:blog_app/services/firestore/blog_service.dart';
import 'package:blog_app/services/storage/storage_service.dart';
import 'package:blog_app/services/local/user_manager.dart';
import 'package:blog_app/utils/storage_folder_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/blog.dart';

class AddViewModel extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  final BlogService _blogService = BlogService();

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

  Future<bool> saveBlog(String title, String desc) async {
    changeLoading();
    Blog newBlog = await generateBlog(title, desc);
    await _blogService.save(newBlog, UserManager.getUserData()!.id);
    clear();
    return true;
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

  Future<Blog> generateBlog(String title, String desc) async {
    String? photoUrl;
    if (pickedImage != null) {
      photoUrl = await savePhoto();
    }

    return Blog(null, title, desc, tags, [], Timestamp.fromDate(DateTime.now()),
        photoUrl ?? "", User.fromActiveUser(UserManager.getUserData()!));
  }

  void clear() {
    tags.clear();
    pickedImage = null;
    changeLoading();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
