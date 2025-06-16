import 'package:flutter/material.dart';

TextField customTextField(TextEditingController controller, String title) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      label: Text(title),
    ),
  );
}
