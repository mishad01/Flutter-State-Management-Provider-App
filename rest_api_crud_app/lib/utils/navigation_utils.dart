import 'package:flutter/material.dart';

class NavigationUtils {
  static void pushTo(BuildContext context, Widget view) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => view,
      ),
    );
  }

  static void pushReplacement(BuildContext context, Widget view) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => view,
      ),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
