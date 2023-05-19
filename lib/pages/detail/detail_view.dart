import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../models/blog.dart';
import '../../utils/custom_navigator.dart';
import '../../widgets/custom_tag_view.dart';
import '../../widgets/custom_title.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key, required this.blog});
  final Blog blog;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final String tempData =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: context.paddingLow,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _stackImageAndBackButton(context),
            context.emptySizedHeightBoxLow,
            customPageTitle(context, widget.blog.title),
            context.emptySizedHeightBoxLow,
            _userCard(),
            context.emptySizedHeightBoxLow,
            Row(
              children:
                  widget.blog.tags.map((e) => CustomTagView(text: e)).toList(),
            ),
            context.emptySizedHeightBoxLow,
            _description(context, widget.blog.description),
          ]),
        ),
      ),
    );
  }

  Text _description(BuildContext context, String desc) {
    return Text(
      desc,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Stack _stackImageAndBackButton(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          widget.blog.photo,
          height: context.dynamicHeight(0.3),
          width: double.infinity,
        ),
        InkWell(
          onTap: () {
            CustomNavigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        )
      ],
    );
  }

  Card _userCard() {
    return Card(
      child: Padding(
        padding: context.paddingNormal,
        child: Row(
          children: [
            CircleAvatar(
              radius: context.dynamicWidth(0.08),
            ),
            context.emptySizedWidthBoxNormal,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTitle(context, widget.blog.user?.name ?? "unknown"),
                context.emptySizedHeightBoxLow,
                Text(
                  widget.blog.user?.email ?? "unknown",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
