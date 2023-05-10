import 'dart:io';

import 'package:blog_app/pages/login/login_view.dart';
import 'package:blog_app/pages/profile/profile_view_model.dart';
import 'package:blog_app/utils/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../utils/string_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_title.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel();
    _viewModel.fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customPageTitle(context, StringConstants.profile),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              bool isLogout = await _viewModel.logout(context);
              if (isLogout && context.mounted) {
                CustomNavigator.pushReplacementTo(context, const LoginView());
              }
            },
          )
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: _viewModel,
        builder: (context, child) => Padding(
          padding: context.paddingLow,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            context.watch<ProfileViewModel>().isProfilePhotoLoading
                ? const CircularProgressIndicator()
                : InkWell(
                    onTap: () async {
                      await _viewModel.pickImage();
                    },
                    child: CircleAvatar(
                      backgroundImage:
                          context.watch<ProfileViewModel>().profileImage != null
                              ? Image.file(File(_viewModel.profileImage!.path))
                                  .image
                              : null,
                      radius: context.dynamicWidth(0.15),
                    ),
                  ),
            context.emptySizedHeightBoxNormal,
            customTitle(context, StringConstants.name),
            TextFormField(
              controller: _viewModel.name,
              decoration: _inputDecoration(context),
            ),
            context.emptySizedHeightBoxLow,
            customTitle(context, StringConstants.surname),
            TextFormField(
              controller: _viewModel.surname,
              decoration: _inputDecoration(context),
            ),
            context.emptySizedHeightBoxLow,
            customTitle(context, StringConstants.email),
            TextFormField(
              controller: _viewModel.email,
              decoration: _inputDecoration(context),
            ),
            context.emptySizedHeightBoxNormal,
            CustomButton(
              widget: const Text(StringConstants.save),
              onClick: () {},
            )
          ]),
        ),
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
