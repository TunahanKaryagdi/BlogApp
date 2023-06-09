import 'package:blog_app/models/active_user.dart';
import 'package:blog_app/services/local/user_manager.dart';
import 'package:blog_app/services/firestore/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../models/user.dart' as UserModel;
import '../../services/auth/auth_service.dart';
import '../../utils/strings.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  String? textFieldValidator(String? value) {
    if (value.isNullOrEmpty) {
      return Strings.typeSth;
    }
    return null;
  }

  Future<bool> signUp(BuildContext context) async {
    changeLoading();
    User? user = await _authService.signup(email.text, password.text);
    if (user == null) {
      //error message
      changeLoading();
      return false;
    } else {
      UserModel.User newUser =
          UserModel.User(name.text, surname.text, email.text, 0, 0, "");

      String docId = await _userService.save(newUser);

      UserManager.setUserData(
          generateNewActiveUser(docId, name.text, surname.text, email.text));

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
