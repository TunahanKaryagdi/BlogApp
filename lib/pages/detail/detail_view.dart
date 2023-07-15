import 'package:blog_app/pages/detail/detail_view_model.dart';
import 'package:blog_app/utils/image_enum.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../models/blog.dart';
import '../../utils/custom_navigator.dart';
import '../../widgets/custom_tag_view.dart';
import '../../widgets/custom_texts.dart';

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
        widget.blog.photo.isEmpty
            ? Image.asset(
                ImageEnum.blog.imagePath,
                height: context.dynamicHeight(0.3),
                width: double.infinity,
              )
            : Image.network(
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
            _likeButtonAndCount(context)
          ],
        )
      ],
    );
  }

  Row _likeButtonAndCount(BuildContext context) {
    return Row(
      children: [
        Text(_viewModel.activeBlog?.like.length.toString() ?? '0'),
        context.emptySizedWidthBoxLow,
        InkWell(
          onTap: () async {
            await _viewModel.onClickedLikeButton(
                _viewModel.activeBlog!, _viewModel.getActiveUser()?.id ?? '');
          },
          child: _viewModel.isLiked(
                  context.watch<DetailViewModel>().activeBlog!,
                  _viewModel.getActiveUser()?.id ?? '')
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
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
            widget.blog.user.photo.isEmpty
                ? CircleAvatar(
                    radius: context.dynamicWidth(0.08),
                    backgroundImage: widget.blog.user.photo.isEmpty
                        ? Image.asset(ImageEnum.user.imagePath).image
                        : Image.network(widget.blog.user.photo).image,
                  )
                : circleAvatar(context, widget.blog.user.photo),
            context.emptySizedWidthBoxNormal,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTitle(context, widget.blog.user.name),
                context.emptySizedHeightBoxLow,
                Text(
                  widget.blog.user.email,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget circleAvatar(BuildContext context, String url) {
    return CircleAvatar(
        radius: context.dynamicWidth(0.1),
        backgroundImage:
            url.isEmpty ? Image.asset(ImageEnum.blog.imagePath).image : null,
        child: url.isNotEmpty
            ? Image.network(url,
                loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return CircleAvatar(
                    radius: context.dynamicWidth(0.1),
                    backgroundImage: Image.network(url).image,
                  );
                }
                return const CircularProgressIndicator();
              })
            : null);
  }
}
