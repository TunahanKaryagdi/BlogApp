import 'package:blog_app/services/local/user_manager.dart';
import 'package:blog_app/utils/custom_navigator.dart';
import 'package:blog_app/utils/strings.dart';
import 'package:flutter/widgets.dart';

class SplashViewModel extends ChangeNotifier {
  Future<void> controlIsLogin(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    var user = UserManager.getUserData();
    if (user == null) {
      CustomNavigator.pushReplacementTo(context, Strings.loginRoute);
    } else {
      CustomNavigator.pushAndRemoveUntil(context, Strings.mainRoute);
    }
  }
}
