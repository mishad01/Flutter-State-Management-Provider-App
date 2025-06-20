import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/utils/app_bar_builder.dart';
import 'package:task_manager_app/utils/app_text_field.dart';
import 'package:task_manager_app/utils/base_scaffold.dart';
import 'package:task_manager_app/view_model/add_task_view_model.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController addTaskController = TextEditingController();

  Future<void> _handleAddTask() async {
    final addTaskProvider =
        Provider.of<AddTaskViewModel>(context, listen: false);
    final success = await addTaskProvider.addTask(addTaskController.text);

    if (success) {
      addTaskController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task added successfully!")),
      );
      Navigator.pop(context);
    } else if (addTaskProvider.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(addTaskProvider.error!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final addTaskProvider = Provider.of<AddTaskViewModel>(context);

    return BaseScaffold(
      appBar: appBarBuilder(context, "Task Manager App"),
      addTaskController: addTaskController,
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          appTextField(
            addTaskController,
            "Enter Task Title",
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: addTaskProvider.isLoading ? null : _handleAddTask,
            child: addTaskProvider.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Save Task"),
          ),
          if (addTaskProvider.error != null) ...[
            const SizedBox(height: 10),
            Text(
              addTaskProvider.error!,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }
}
