import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  VoidCallback onClick;
  Widget widget;

  CustomButton({super.key, required this.widget, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.dynamicHeight(0.07),
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ))),
        child: widget,
      ),
    );
  }
}
