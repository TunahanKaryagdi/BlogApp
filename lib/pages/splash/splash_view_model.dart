import 'package:blog_app/pages/login/login_view.dart';
import 'package:blog_app/pages/main/main_view.dart';
import 'package:blog_app/services/user_manager.dart';
import 'package:blog_app/utils/custom_navigator.dart';
import 'package:flutter/widgets.dart';

class SplashViewModel extends ChangeNotifier {
  Future<void> controlIsLogin(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    var user = UserManager.getUserData();
    if (user == null) {
      CustomNavigator.pushReplacementTo(context, LoginView());
    } else {
      CustomNavigator.pushReplacementTo(context, MainView());
    }
  }
}
