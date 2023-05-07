import '../main/main_view.dart';
import '../../utils/custom_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../services/auth_service.dart';
import '../../utils/string_constants.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  String? textFieldValidator(String? value) {
    if (value.isNullOrEmpty) {
      return StringConstants.typeSth;
    }
    return null;
  }

  Future<void> login(BuildContext context) async {
    changeLoading();
    User? user = await _authService.login(email.text, password.text);
    if (user != null) {
      //Successful update active user
      print("başarili ${user.email}");
      if (context.mounted) {
        CustomNavigator.pushReplacementTo(context, MainView());
      }
    } else {
      //unsuccessful show message
      print("başarisiz");
    }
    changeLoading();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
