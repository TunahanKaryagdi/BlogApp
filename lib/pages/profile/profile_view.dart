import 'package:blog_app/pages/profile/profile_view_model.dart';
import 'package:blog_app/utils/custom_navigator.dart';
import 'package:blog_app/utils/image_enum.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../utils/strings.dart';
import '../../widgets/custom_texts.dart';

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
        title: customPageTitle(context, Strings.profile),
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
                      _keyAndValue(
                          Strings.name, _viewModel.activeUser?.name ?? ''),
                      _divider(),
                      _keyAndValue(Strings.surname,
                          _viewModel.activeUser?.surname ?? ''),
                      _divider(),
                      _keyAndValue(
                          Strings.email, _viewModel.activeUser?.email ?? ''),
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
          CustomNavigator.pushReplacementTo(context, Strings.loginRoute);
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
    String? url = context.watch<ProfileViewModel>().activeUser?.photo;
    return InkWell(
      onTap: () async {
        await _viewModel.pickImage(context);
      },
      child: url != null && url.isNotEmpty
          ? circleAvatar(context, url)
          : CircleAvatar(
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
            customTitle(context, Strings.follow)
          ],
        ),
        context.emptySizedWidthBoxNormal,
        Column(
          children: [
            customTitle(context, follower.toString()),
            customTitle(context, Strings.follower)
          ],
        )
      ],
    );
  }

  Row _keyAndValue(String key, String value) {
    return Row(
      children: [
        Expanded(flex: 2, child: customNormalText(context, "$key:")),
        Expanded(flex: 6, child: customNormalText(context, value))
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
    String? photoUrl = context.watch<ProfileViewModel>().activeUser?.photo;

    if (photoUrl != null) {
      return Image.network(photoUrl).image;
    } else {
      return Image.asset(ImageEnum.user.imagePath).image;
    }
  }

  Widget circleAvatar(BuildContext context, String url) {
    return CircleAvatar(
        radius: context.dynamicWidth(0.15),
        backgroundImage:
            url.isEmpty ? Image.asset(ImageEnum.blog.imagePath).image : null,
        child: url.isNotEmpty
            ? Image.network(url,
                loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return CircleAvatar(
                    radius: context.dynamicWidth(0.15),
                    backgroundImage: Image.network(url).image,
                  );
                }
                return const CircularProgressIndicator();
              })
            : null);
  }
}
