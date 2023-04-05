import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utils/string_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_title.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customPageTitle(context, StringConstants.profile),
      ),
      body: Padding(
        padding: context.paddingLow,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
            radius: context.dynamicWidth(0.15),
          ),
          context.emptySizedHeightBoxNormal,
          customTitle(context, StringConstants.name),
          TextFormField(
            decoration: _inputDecoration(context),
          ),
          context.emptySizedHeightBoxLow,
          customTitle(context, StringConstants.email),
          TextFormField(
            decoration: _inputDecoration(context),
          ),
          context.emptySizedHeightBoxNormal,
          CustomButton(
            text: StringConstants.save,
            onClick: () {},
          )
        ]),
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2)));
  }
}
