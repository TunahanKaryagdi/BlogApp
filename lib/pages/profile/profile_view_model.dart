import 'package:blog_app/models/active_user.dart';
import 'package:blog_app/pages/login/login_view.dart';
import 'package:blog_app/utils/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  TextEditingController email = TextEditingController();

  Future<void> logout(BuildContext context) async {
    await _authService.logout();
    if (context.mounted) {
      CustomNavigator.pushReplacementTo(context, const LoginView());
    }
  }

  void fetchData(BuildContext context) {
    email.text = context.read<ActiveUser>().email ?? 'bulunamadı';
    notifyListeners();
  }
}
