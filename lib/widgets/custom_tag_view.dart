import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTagView extends StatefulWidget {
  const CustomTagView({
    super.key,
    required String text,
  });

  @override
  State<CustomTagView> createState() => _CustomTagViewState();
}

class _CustomTagViewState extends State<CustomTagView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingLow,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
      child: Text(
        "Tag",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .merge(TextStyle(color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
