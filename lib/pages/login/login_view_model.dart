import 'package:blog_app/services/local/user_manager.dart';
import 'package:blog_app/services/firestore/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../models/active_user.dart';
import '../../services/auth/auth_service.dart';
import '../../utils/strings.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  String? textFieldValidator(String? value) {
    if (value.isNullOrEmpty) {
      return Strings.typeSth;
    }
    return null;
  }

  Future<bool> login(BuildContext context) async {
    changeLoading();
    User? user = await _authService.login(email.text, password.text);
    if (user != null) {
      final String id = await _userService.getUserIdByEmail(user.email!);

      final userModel = await _userService.getUserById(id);

      ActiveUser activeUser = ActiveUser(
          id,
          userModel.name,
          userModel.surname,
          userModel.email,
          userModel.follow,
          userModel.follower,
          userModel.photo);

      await UserManager.setUserData(activeUser);

      changeLoading();

      return true;
    } else {
      changeLoading();
      return false;
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
