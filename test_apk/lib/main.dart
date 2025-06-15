import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_apk/home_view.dart';
import 'package:test_apk/provider/delete_product_provider.dart';
import 'package:test_apk/provider/get_product_provider.dart';
import 'package:test_apk/provider/post_product_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => GetProductProvider()),
      ChangeNotifierProvider(create: (context) => PostProductProvider()),
      ChangeNotifierProvider(create: (context) => DeleteProductProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
