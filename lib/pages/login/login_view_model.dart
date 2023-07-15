import 'package:blog_app/services/local/user_manager.dart';
import 'package:blog_app/services/firestore/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/active_user.dart';
import '../../services/auth/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  bool isLoading = false;

  Future<bool> login(String email, String password) async {
    changeLoading();
    User? user = await _authService.login(email, password);
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
