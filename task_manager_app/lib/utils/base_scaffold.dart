import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final TextEditingController? addTaskController;
  final Widget widget;
  final PreferredSizeWidget? appBar;

  const BaseScaffold({
    super.key,
    this.appBar,
    this.addTaskController,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget,
      ),
    );
  }
}
