import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../widgets/custom_tag_view.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

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
            _title(context),
            context.emptySizedHeightBoxLow,
            _userCard(),
            context.emptySizedHeightBoxLow,
            Row(
              children: [CustomTagView(), CustomTagView()],
            ),
            context.emptySizedHeightBoxLow,
            _description(context),
          ]),
        ),
      ),
    );
  }

  Text _description(BuildContext context) {
    return Text(
      tempData,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Text _title(BuildContext context) {
    return Text(
      'title',
      style: Theme.of(context).textTheme.headlineMedium!.merge(TextStyle(
          fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
    );
  }

  Stack _stackImageAndBackButton(BuildContext context) {
    return Stack(
      children: [
        Icon(Icons.arrow_back),
        Image.network(
          'https://avatars.githubusercontent.com/u/92988984?s=400&v=4',
          height: context.dynamicHeight(0.3),
          width: double.infinity,
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
                Text(
                  'name surname',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .merge(const TextStyle(fontWeight: FontWeight.bold)),
                ),
                context.emptySizedHeightBoxLow,
                Text(
                  'email',
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
