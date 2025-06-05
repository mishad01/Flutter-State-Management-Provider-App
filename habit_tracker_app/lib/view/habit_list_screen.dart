import 'package:flutter/material.dart';
import 'package:habit_tracker_app/provider/habit_provider.dart';
import 'package:provider/provider.dart';

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({super.key});

  @override
  State<HabitListScreen> createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    final habit = habitProvider.habits;
    return Scaffold(
      appBar: buildAppBar(context),
      floatingActionButton: buildFloatingActionButton(context, habitProvider),
      body: Column(
        children: [
          Text("Daily Progress: habit completed"),
          SizedBox(height: 8),
          LinearProgressIndicator(value: 0.5),
          SizedBox(height: 8),
          Text(
              "Completion Percentage : ${habitProvider.competitionPercentage.toString()}%"),
          Expanded(
              child: ListView.builder(
            itemCount: habit.length,
            itemBuilder: (context, index) => ListTile(
                title: Text(habit[index].title),
                trailing: Checkbox(
                  value: habit[index].isCompleted,
                  onChanged: (value) {
                    habitProvider.toggleHabit(habit[index].id);
                  },
                )),
          ))
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Habit Tracker"),
      actions: [
        IconButton(
            onPressed: () {
              Provider.of<HabitProvider>(listen: false, context).resetHabits();
            },
            icon: Icon(Icons.refresh)),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton(
      BuildContext context, HabitProvider habitProvider) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            String newHabitTitle = "";
            return AlertDialog(
              title: Text("Add Habit"),
              content: TextField(
                onChanged: (value) => newHabitTitle = value,
                decoration: InputDecoration(hintText: "Habit Title"),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (newHabitTitle.isNotEmpty) {
                      habitProvider.addHabit(newHabitTitle);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add"),
                ),
              ],
            );
          },
        );
      },
      child: Icon(Icons.add),
    );
  }
}
