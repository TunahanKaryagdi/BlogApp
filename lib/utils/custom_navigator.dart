import 'package:flutter/material.dart';

class CustomNavigator {
  static void pushTo(BuildContext context, Widget toScreen) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => toScreen,
    ));
  }

  static void pushReplacementTo(BuildContext context, Widget toScreen) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => toScreen,
    ));
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
