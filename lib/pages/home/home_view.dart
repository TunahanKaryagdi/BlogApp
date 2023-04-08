import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utils/string_constants.dart';
import '../../utils/tag_texts_enum.dart';
import '../../widgets/custom_tag_view.dart';
import '../../widgets/custom_title.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customPageTitle(context, StringConstants.home),
      ),
      body: Padding(
        padding: context.paddingLow,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _customCard();
          },
          itemCount: 5,
        ),
      ),
    );
  }

  Card _customCard() {
    return Card(
      child: Padding(
        padding: context.paddingNormal,
        child: Row(
          children: [
            CircleAvatar(
              radius: context.dynamicWidth(0.1),
            ),
            context.emptySizedWidthBoxNormal,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Başlık',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  context.emptySizedHeightBoxLow,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'İsim',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      context.emptySizedWidthBoxLow,
                      Text(
                        'Tarih',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  context.emptySizedHeightBoxLow,
                  Row(
                    children: [CustomTagView(text: TagTexts.Economy.name)],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
