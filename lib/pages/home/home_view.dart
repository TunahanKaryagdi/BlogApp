import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../widgets/custom_tag_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  Container _tagView() {
    return Container(
      alignment: Alignment.center,
      height: context.dynamicHeight(0.03),
      decoration: BoxDecoration(
          border: Border.all(color: context.appTheme.primaryColor),
          borderRadius: BorderRadius.circular(context.dynamicHeight(0.015))),
      child: Padding(
        padding: context.horizontalPaddingLow,
        child: const Text("Technologies"),
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
                    children: [CustomTagView()],
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
