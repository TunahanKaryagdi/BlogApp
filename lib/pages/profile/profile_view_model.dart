import 'package:blog_app/models/active_user.dart';
import 'package:blog_app/pages/login/login_view.dart';
import 'package:blog_app/services/storage_service.dart';
import 'package:blog_app/utils/custom_navigator.dart';
import 'package:blog_app/utils/storage_folder_enum.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();

  bool isProfilePhotoLoading = false;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? profileImage;

  Future<bool> logout(BuildContext context) async {
    await _authService.logout();

    if (context.mounted) {
      setActiveUser(context);
      return true;
    }
    return false;
  }

  void fetchData(BuildContext context) {
    ActiveUser activeUser = context.read<ActiveUser>();
    email.text = activeUser.email ?? "";
    name.text = activeUser.name ?? "";
    surname.text = activeUser.surname ?? "";
    notifyListeners();
  }

  void setActiveUser(BuildContext context) {
    context.read<ActiveUser>().setActiveUser(null, null, null, null);
  }

  Future<void> pickImage() async {
    profileImage = await _imagePicker.pickImage(source: ImageSource.camera);
    if (profileImage != null) {
      changeLoading();
      String url = await _storageService.uploadImage(
          profileImage!, StorageFolders.userImages);
      changeLoading();
      notifyListeners();
    } else {}
  }

  void changeLoading() {
    isProfilePhotoLoading = !isProfilePhotoLoading;
    notifyListeners();
  }
}
