import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utils/string_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_title.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.horizontalPaddingNormal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customPageTitle(context, StringConstants.signup),
            context.emptySizedHeightBoxNormal,
            customTitle(context, StringConstants.name),
            TextFormField(),
            context.emptySizedHeightBoxNormal,
            customTitle(context, StringConstants.surname),
            TextFormField(),
            context.emptySizedHeightBoxNormal,
            customTitle(context, StringConstants.email),
            TextFormField(),
            context.emptySizedHeightBoxNormal,
            customTitle(context, StringConstants.password),
            TextFormField(),
            context.emptySizedHeightBoxNormal,
            CustomButton(
              text: StringConstants.save,
              onClick: () {},
            )
          ],
        ),
      ),
    );
  }
}
