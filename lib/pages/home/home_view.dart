import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../models/blog.dart';
import '../../utils/string_constants.dart';
import '../../widgets/custom_tag_view.dart';
import '../../widgets/custom_title.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customPageTitle(context, StringConstants.home),
      ),
      body: Padding(
        padding: context.paddingLow,
        child: StreamBuilder(
          stream: _viewModel.getBlogStreams(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final blogs = snapshot.data?.docs ?? [];
              return ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return _customCard(Blog.fromSnapshot(blogs[index]));
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Card _customCard(Blog blog) {
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
                    blog.title,
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
                        calculateDate(blog.date),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  context.emptySizedHeightBoxLow,
                  Row(
                    children: blog.tags
                        .map((e) => CustomTagView(text: e.toString()))
                        .toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String calculateDate(Timestamp date) {
    DateTime temp = date.toDate();
    Duration difference = temp.difference(DateTime.now());
    return '${difference.inDays.toString()} days ago';
  }
}
