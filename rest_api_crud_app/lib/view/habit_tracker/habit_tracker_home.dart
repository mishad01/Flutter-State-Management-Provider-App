import 'package:flutter/material.dart';
import 'package:rest_api_crud_app/utils/custom_app_bar.dart';

class HabitTrackerHome extends StatefulWidget {
  const HabitTrackerHome({super.key});

  @override
  State<HabitTrackerHome> createState() => _HabitTrackerHomeState();
}

class _HabitTrackerHomeState extends State<HabitTrackerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Habit Tracker App"),
    );
  }
}
