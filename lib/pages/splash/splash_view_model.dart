import 'package:blog_app/services/user_manager.dart';
import 'package:blog_app/utils/custom_navigator.dart';
import 'package:blog_app/utils/string_constants.dart';
import 'package:flutter/widgets.dart';

class SplashViewModel extends ChangeNotifier {
  Future<void> controlIsLogin(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    var user = UserManager.getUserData();
    if (user == null) {
      CustomNavigator.pushReplacementTo(context, StringConstants.loginRoute);
    } else {
      CustomNavigator.pushAndRemoveUntil(context, StringConstants.mainRoute);
    }
  }
}
