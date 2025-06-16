import 'package:flutter/material.dart';
import 'package:rest_api_crud_app/utils/navigation_utils.dart';

AppBar customAppBar(
  BuildContext context,
  String? title, {
  IconData? icon,
  Widget? view,
}) {
  return AppBar(
    backgroundColor: Colors.blueGrey,
    iconTheme: IconThemeData(color: Colors.white),
    title: Text(
      title ?? "",
      style: TextStyle(color: Colors.white),
    ),
    actions: [
      if (icon != null)
        IconButton(
          onPressed: () {
            NavigationUtils.pushTo(context, view!);
          },
          icon: Icon(icon),
        ),
    ],
  );
}
