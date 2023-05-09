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
  TextEditingController email = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? profileImage;
  final StorageService _storageService = StorageService();
  bool isProfilePhotoLoading = false;

  Future<void> logout(BuildContext context) async {
    await _authService.logout();

    if (context.mounted) {
      context.read<ActiveUser>().logUser(null, null, null, null);
      CustomNavigator.pushReplacementTo(context, const LoginView());
    }
  }

  void fetchData(BuildContext context) {
    email.text = context.read<ActiveUser>().email ?? 'bulunamadi';
    notifyListeners();
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
