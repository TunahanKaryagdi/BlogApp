import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onClick;
  String text;

  CustomButton({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.dynamicHeight(0.07),
      child: ElevatedButton(
        child: Text(text),
        onPressed: onClick,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ))),
      ),
    );
  }
}
