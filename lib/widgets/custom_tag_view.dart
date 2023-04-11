import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTagView extends StatelessWidget {
  const CustomTagView({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingLow,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .merge(TextStyle(color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
