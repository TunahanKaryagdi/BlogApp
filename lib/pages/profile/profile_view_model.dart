import 'package:blog_app/models/active_user.dart';
import 'package:blog_app/services/storage_service.dart';
import 'package:blog_app/services/user_manager.dart';
import 'package:blog_app/services/user_service.dart';
import 'package:blog_app/utils/storage_folder_enum.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();
  final UserService _userService = UserService();

  final ImagePicker _imagePicker = ImagePicker();
  String? imageUrL;
  XFile? profileImage;

  bool isProfilePhotoLoading = false;
  bool isLoading = false;

  ActiveUser? activeUser;

  Future<bool> logout() async {
    await _authService.logout();

    await UserManager.deleteUserData();

    activeUser = UserManager.getUserData();

    if (activeUser == null) {
      return true;
    }
    return false;
  }

  Future<void> fetchData() async {
    changeLoading();
    activeUser = UserManager.getUserData();
    changeLoading();
  }

  Future<void> pickImage(BuildContext context) async {
    profileImage = await _imagePicker.pickImage(source: ImageSource.camera);
    if (profileImage != null) {
      changePhotoLoading();
      String url = await _storageService.uploadImage(profileImage!,
          StorageFolders.userImages, activeUser?.email ?? "no email");

      updatePhotoUrl(UserManager.getUserData()!, url);

      changePhotoLoading();
      notifyListeners();
    } else {}
  }

  Future<void> updatePhotoUrl(
    ActiveUser activeUser,
    String url,
  ) async {
    await _userService.updateUser(activeUser.id, {'photo': url});
  }

  void changePhotoLoading() {
    isProfilePhotoLoading = !isProfilePhotoLoading;
    notifyListeners();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
