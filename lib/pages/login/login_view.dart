import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utils/string_constants.dart';
import '../../widgets/custom_button.dart';

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
            Text(
              StringConstants.helloText,
              style: Theme.of(context).textTheme.headlineLarge,
              
            ),
            context.emptySizedHeightBoxNormal,
            Text(StringConstants.email,
                style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              controller: email,
            ),
            context.emptySizedHeightBoxNormal,
            Text(StringConstants.password,
                style: Theme.of(context).textTheme.titleMedium),
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
