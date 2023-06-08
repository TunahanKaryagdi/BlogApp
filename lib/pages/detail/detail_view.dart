import 'package:blog_app/pages/detail/detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

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
  late final DetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = DetailViewModel();
    _viewModel.activeBlog = widget.blog;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider.value(
          value: _viewModel,
          builder: (context, child) => _body(context),
        ),
      ),
    );
  }

  Padding _body(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                CustomNavigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
            InkWell(
              onTap: () async {
                await _viewModel.onClickedLikeButton(_viewModel.activeBlog!,
                    _viewModel.getActiveUser()?.id ?? '');
              },
              child: _viewModel.isLiked(
                      context.watch<DetailViewModel>().activeBlog!,
                      _viewModel.getActiveUser()?.id ?? '')
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
            )
          ],
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
