import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../models/active_user.dart';
import '../../services/auth_service.dart';
import '../../utils/custom_navigator.dart';
import '../../utils/string_constants.dart';
import '../main/main_view.dart';

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
      if (context.mounted) {
        context
            .read<ActiveUser>()
            .logUser(user.uid, 'name', 'surname', user.email ?? 'no email');
        CustomNavigator.pushReplacementTo(context, const MainView());
      }
    } else {
      //error
      if (context.mounted) {
        // CustomNavigator.pushReplacementTo(context, const SignupView());
      }
    }
    changeLoading();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
