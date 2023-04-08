import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utils/string_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_title.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.horizontalPaddingNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customPageTitle(context, StringConstants.helloText),
            context.emptySizedHeightBoxNormal,
            customTitle(context, StringConstants.email),
            TextFormField(
              controller: email,
            ),
            context.emptySizedHeightBoxNormal,
            customTitle(context, StringConstants.password),
            TextFormField(
              controller: password,
            ),
            context.emptySizedHeightBoxNormal,
            CustomButton(
              text: StringConstants.login,
              onClick: () {},
            ),
            context.emptySizedHeightBoxNormal,
            CustomButton(
              text: StringConstants.signup,
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
