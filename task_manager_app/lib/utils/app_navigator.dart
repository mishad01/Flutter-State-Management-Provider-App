import 'package:flutter/material.dart';

class AppNavigator {
  static Future<dynamic> pushTo(BuildContext context, Widget view) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => view,
      ),
    );
  }

  static Future<dynamic> pushReplacement(BuildContext context, Widget view) {
    return Navigator.pushReplacement(
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
