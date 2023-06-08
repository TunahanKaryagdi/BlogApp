import 'dart:io';

import 'package:blog_app/pages/profile/profile_view_model.dart';
import 'package:blog_app/utils/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../utils/string_constants.dart';
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
    _viewModel.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customPageTitle(context, StringConstants.profile),
        actions: [_logoutButton(context)],
      ),
      body: ChangeNotifierProvider.value(
        value: _viewModel,
        builder: (context, child) => context.watch<ProfileViewModel>().isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              )
            : Padding(
                padding: context.paddingLow,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _avatarAndFollower(
                          context,
                          _viewModel.activeUser?.follow ?? 0,
                          _viewModel.activeUser?.follower ?? 0),
                      context.emptySizedHeightBoxNormal,
                      _keyAndValue(StringConstants.name,
                          _viewModel.activeUser?.name ?? ''),
                      _divider(),
                      _keyAndValue(StringConstants.surname,
                          _viewModel.activeUser?.surname ?? ''),
                      _divider(),
                      _keyAndValue(StringConstants.email,
                          _viewModel.activeUser?.email ?? ''),
                    ]),
              ),
      ),
    );
  }

  IconButton _logoutButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.logout,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () async {
        bool isLogout = await _viewModel.logout();
        if (isLogout && context.mounted) {
          CustomNavigator.pushReplacementTo(
              context, StringConstants.loginRoute);
        }
      },
    );
  }

  Row _avatarAndFollower(BuildContext context, int follow, int follower) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        context.watch<ProfileViewModel>().isProfilePhotoLoading
            ? _circularProgressBar()
            : _circularAvatar(context),
        Expanded(child: _followAndFollower(context, follow, follower))
      ],
    );
  }

  CircularProgressIndicator _circularProgressBar() {
    return const CircularProgressIndicator(
      color: Colors.brown,
    );
  }

  InkWell _circularAvatar(BuildContext context) {
    return InkWell(
      onTap: () async {
        //await _viewModel.pickImage(context);
      },
      child: CircleAvatar(
        backgroundImage: _circularAvatarBackground(context),
        radius: context.dynamicWidth(0.15),
      ),
    );
  }

  Row _followAndFollower(BuildContext context, int follow, int follower) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            customTitle(context, follow.toString()),
            customTitle(context, StringConstants.follow)
          ],
        ),
        context.emptySizedWidthBoxNormal,
        Column(
          children: [
            customTitle(context, follower.toString()),
            customTitle(context, StringConstants.follower)
          ],
        )
      ],
    );
  }

  Row _keyAndValue(String key, String value) {
    return Row(
      children: [
        Expanded(flex: 2, child: customTitle(context, "$key:")),
        Expanded(flex: 5, child: customTitle(context, value))
      ],
    );
  }

  Divider _divider() {
    return Divider(
      color: Theme.of(context).primaryColor,
      thickness: 1,
    );
  }

  ImageProvider? _circularAvatarBackground(BuildContext context) {
    XFile? pickedFile = context.watch<ProfileViewModel>().profileImage;
    String? photoUrl = context.watch<ProfileViewModel>().imageUrL;
    if (pickedFile == null) {
      if (photoUrl != null) {
        return Image.network(photoUrl).image;
      }
      return null;
    }
    return Image.file(File(pickedFile.path)).image;
  }
}
