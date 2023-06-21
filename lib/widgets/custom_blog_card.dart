import 'package:blog_app/models/blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../utils/image_enum.dart';
import 'custom_tag_view.dart';

class CustomBlogCard extends StatelessWidget {
  const CustomBlogCard({super.key, required this.blog, required this.onClick});

  final Blog blog;
  final VoidCallback onClick;

  String calculateDate(Timestamp date) {
    DateTime temp = date.toDate();
    Duration difference = DateTime.now().difference(temp);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return "${difference.inMinutes} minutes ago";
      }
      return "${difference.inHours} hours ago";
    }
    return '${difference.inDays.toString()} days ago';
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        child: Padding(
          padding: context.paddingNormal,
          child: Row(
            children: [
              circleAvatar(context, blog.photo),
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
                          calculateDate(blog.date),
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
