import 'package:blog_app/pages/favorite/favorite_view_model.dart';
import 'package:blog_app/widgets/custom_blog_card.dart';
import 'package:blog_app/widgets/custom_circular_bar.dart';
import 'package:blog_app/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../models/blog.dart';
import '../../utils/strings.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late final FavoriteViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = FavoriteViewModel();
    _viewModel.getFavoriteBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(
              title: customPageTitle(context, Strings.favorite),
            ),
            body: context.watch<FavoriteViewModel>().isLoading
                ? customCircularBar(context)
                : context.watch<FavoriteViewModel>().favoriteBlogs.isEmpty
                    ? emptyContent()
                    : Padding(
                        padding: context.paddingLow,
                        child: ListView.builder(
                          itemCount: context
                              .watch<FavoriteViewModel>()
                              .favoriteBlogs
                              .length,
                          itemBuilder: (context, index) {
                            Blog blog = context
                                .watch<FavoriteViewModel>()
                                .favoriteBlogs[index];
                            return CustomBlogCard(
                              blog: blog,
                              onClick: () {
                                _viewModel.goToDetailPage(context, blog);
                              },
                            );
                          },
                        ),
                      ));
      },
    );
  }

  Center emptyContent() {
    return Center(
      child: customPageTitle(context, "Liste Boş"),
    );
  }
}
