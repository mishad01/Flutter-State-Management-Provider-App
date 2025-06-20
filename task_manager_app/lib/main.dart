import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/core/provider/theme_provider.dart';
import 'package:task_manager_app/view_model/add_task_view_model.dart';
import 'package:task_manager_app/view_model/delete_task_view_model.dart';
import 'package:task_manager_app/view_model/get_task_view_model..dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => GetTaskViewModel()),
      ChangeNotifierProvider(create: (context) => AddTaskViewModel()),
      ChangeNotifierProvider(create: (context) => DeleteTaskViewModel()),
    ],
    child: const TaskManagerApp(),
  ));
}
