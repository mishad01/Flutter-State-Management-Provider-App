import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app_provider_supabase/provider/meal_category_provider.dart';
import 'package:recipe_app_provider_supabase/view/home_screen/home_screen.dart';
import 'package:sizer/sizer.dart';

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://votpgcjthlybxhezvdwe.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZvdHBnY2p0aGx5YnhoZXp2ZHdlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk2MzA5MTcsImV4cCI6MjA1NTIwNjkxN30.DI6i1KbSbaR_hvuU1NBl1tdQlxFzTV8B5r3g5J0hqVM",
  );

  runApp(MyApp());
}
*/
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MealCategoryProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(home: HomeScreen());
      },
    );
  }
}
