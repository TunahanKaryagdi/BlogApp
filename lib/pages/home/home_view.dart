import 'package:blog_app/utils/image_enum.dart';
import 'package:blog_app/widgets/custom_circular_bar.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../models/blog.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_tag_view.dart';
import '../../widgets/custom_texts.dart';
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
    init();
  }

  void init() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: customPageTitle(context, Strings.home),
          ),
          body: context.watch<HomeViewModel>().isLoading
              ? customCircularBar(context)
              : Padding(
                  padding: context.paddingLow,
                  child: ListView.builder(
                    itemCount: context.watch<HomeViewModel>().blogList.length,
                    itemBuilder: (context, index) {
                      return _customCard(
                          context.watch<HomeViewModel>().blogList[index],
                          context);
                    },
                  ),
                ),
        );
      },
    );
  }

  InkWell _customCard(Blog blog, BuildContext context) {
    return InkWell(
      onTap: () {
        _viewModel.goToDetailPage(context, blog);
      },
      child: Card(
        child: Padding(
          padding: context.paddingNormal,
          child: Row(
            children: [
              CircleAvatar(
                radius: context.dynamicWidth(0.1),
                backgroundImage: blog.photo.isEmpty
                    ? Image.asset(ImageEnum.blog.imagePath).image
                    : Image.network(blog.photo).image,
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
                          blog.user.name,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        context.emptySizedWidthBoxLow,
                        Text(
                          _viewModel.calculateDate(blog.date),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    context.emptySizedHeightBoxLow,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: blog.tags
                            .map((e) => CustomTagView(text: e))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
