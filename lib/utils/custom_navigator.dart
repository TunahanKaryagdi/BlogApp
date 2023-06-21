import 'package:flutter/material.dart';

class CustomNavigator {
  static void pushTo(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  static void pushToWithArgument(
      BuildContext context, String route, dynamic argument) {
    Navigator.of(context).pushNamed(route, arguments: argument);
  }

  static void pushReplacementToWithArgument(
      BuildContext context, String route, dynamic argument) {
    Navigator.of(context).pushReplacementNamed(route, arguments: argument);
  }

  static void pushReplacementTo(BuildContext context, String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  static void pushAndRemoveUntil(BuildContext context, String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
