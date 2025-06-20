import 'package:flutter/material.dart';

TextField appTextField(TextEditingController controller, String label) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label, // uses theme's border
    ),
  );
}
