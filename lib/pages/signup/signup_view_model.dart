import 'package:blog_app/models/active_user.dart';
import 'package:blog_app/services/local/user_manager.dart';
import 'package:blog_app/services/firestore/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart' as UserModel;
import '../../services/auth/auth_service.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  bool isLoading = false;

  Future<bool> signUp(
      String name, String surname, String email, String password) async {
    changeLoading();
    User? user = await _authService.signup(email, password);
    if (user == null) {
      //error message
      changeLoading();
      return false;
    } else {
      UserModel.User newUser = UserModel.User(name, surname, email, 0, 0, "");

      String docId = await _userService.save(newUser);

      UserManager.setUserData(
          generateNewActiveUser(docId, name, surname, email));

      changeLoading();

      return true;
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  ActiveUser generateNewActiveUser(
      String id, String name, String surname, String email) {
    return ActiveUser(id, name, surname, email, 0, 0, '');
  }
}
