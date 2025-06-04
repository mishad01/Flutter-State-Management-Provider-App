import 'package:flutter/material.dart';
import 'package:flutter_state_management_provider/home_screen.dart';
import 'package:flutter_state_management_provider/number_list_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NumberListProvider())
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
