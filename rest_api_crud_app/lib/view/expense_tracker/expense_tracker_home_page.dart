import 'package:flutter/material.dart';
import 'package:rest_api_crud_app/utils/custom_app_bar.dart';

class ExpenseTrackerHomePage extends StatefulWidget {
  const ExpenseTrackerHomePage({super.key});

  @override
  State<ExpenseTrackerHomePage> createState() => _ExpenseTrackerHomePageState();
}

class _ExpenseTrackerHomePageState extends State<ExpenseTrackerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Expense Tracker App"),
    );
  }
}
