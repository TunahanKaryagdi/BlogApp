import 'package:blog_app/models/active_user.dart';
import 'package:blog_app/models/user.dart';
import 'package:blog_app/services/firestore_service.dart';
import 'package:blog_app/services/storage_service.dart';
import 'package:blog_app/utils/firebase_collection_enum.dart';
import 'package:blog_app/utils/storage_folder_enum.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();
  final FirestoreService _firestoreService = FirestoreService<User>();

  String? imageUrL;

  bool isProfilePhotoLoading = false;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? profileImage;
  ActiveUser activeUser = ActiveUser();

  Future<bool> logout(BuildContext context) async {
    await _authService.logout();

    if (context.mounted) {
      setActiveUserNull(context);
      return true;
    }
    return false;
  }

  void fetchData(BuildContext context) {
    activeUser = getActiveUser(context);
    imageUrL = activeUser.photoUrl;
    notifyListeners();
  }

  Future<void> pickImage(BuildContext context) async {
    profileImage = await _imagePicker.pickImage(source: ImageSource.camera);
    if (profileImage != null) {
      changeLoading();
      String url = await _storageService.uploadImage(profileImage!,
          StorageFolders.userImages, activeUser.email ?? "no email");

      if (context.mounted) {
        await updatePhotoUrl(getActiveUser(context), url);
      }

      changeLoading();
      notifyListeners();
    } else {}
  }

  void setActiveUserNull(BuildContext context) {
    context
        .read<ActiveUser>()
        .setActiveUser(null, null, null, null, null, null, null);
  }

  ActiveUser getActiveUser(BuildContext context) {
    return context.read<ActiveUser>();
  }

  Future<void> updatePhotoUrl(
    ActiveUser activeUser,
    String url,
  ) async {
    await _firestoreService.updateDocument(
      FirebaseCollections.users,
      activeUser.id ?? '',
      {'photo': url},
    );
  }

  void changeLoading() {
    isProfilePhotoLoading = !isProfilePhotoLoading;
    notifyListeners();
  }
}
