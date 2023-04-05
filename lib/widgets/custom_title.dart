import 'package:flutter/material.dart';

Text customPageTitle(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context)
        .textTheme
        .headlineMedium!
        .merge(TextStyle(color: Theme.of(context).primaryColor)),
  );
}

Text customTitle(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleLarge,
  );
}
