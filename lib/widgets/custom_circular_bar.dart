import 'package:flutter/material.dart';

Center customCircularBar(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      color: Theme.of(context).primaryColor,
    ),
  );
}
