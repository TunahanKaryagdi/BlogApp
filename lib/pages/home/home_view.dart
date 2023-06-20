import 'package:blog_app/widgets/custom_blog_card.dart';
import 'package:blog_app/widgets/custom_circular_bar.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../models/blog.dart';
import '../../utils/strings.dart';
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
    _viewModel.getBlogs();
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
                      Blog blog =
                          context.watch<HomeViewModel>().blogList[index];
                      return CustomBlogCard(
                          blog: blog,
                          onClick: () {
                            _viewModel.goToDetailPage(context, blog);
                          });
                    },
                  ),
                ),
        );
      },
    );
  }
}
