import 'package:blog_app/utils/string_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String? textFieldValidator(String? value) {
    if (value.isNullOrEmpty) {
      return StringConstants.typeSth;
    }
    return null;
  }

  Future<void> login() async {
    User? user = await _authService.login(email.text, password.text);
    if (user != null) {
      //Successful update active user
      print("başarili ${user.email}");
    } else {
      //unsuccessful show message
      print("başarisiz");
    }
  }
}
