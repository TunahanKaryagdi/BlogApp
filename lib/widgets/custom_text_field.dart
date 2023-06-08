import 'package:flutter/material.dart';

TextFormField customTextField(String hint, TextEditingController controller,
    IconData leading, String? Function(String? value) validator) {
  return TextFormField(
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
        prefixIcon: Icon(leading)),
  );
}
