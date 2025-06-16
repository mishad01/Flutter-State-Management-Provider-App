import 'package:flutter/material.dart';
import 'package:rest_api_crud_app/view/main_layout/main_view.dart';

class RestApiCrudApp extends StatelessWidget {
  const RestApiCrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: MainView(),
    );
  }
}
