import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/utils/app_bar_builder.dart';
import 'package:task_manager_app/utils/app_navigator.dart';
import 'package:task_manager_app/utils/base_scaffold.dart';
import 'package:task_manager_app/view/add_task_view.dart';
import 'package:task_manager_app/view_model/delete_task_view_model.dart';
import 'package:task_manager_app/view_model/get_task_view_model..dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _refreshTasks() async {
    final getTaskProvider =
        Provider.of<GetTaskViewModel>(context, listen: false);
    await getTaskProvider.fetchTasks();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await _refreshTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final getTaskProvider = Provider.of<GetTaskViewModel>(context);
    final deleteTaskProvider = Provider.of<DeleteTaskViewModel>(context);
    final tasks = getTaskProvider.tasks;

    return BaseScaffold(
      appBar: appBarBuilder(
        context,
        "Task Manager App",
        icon: Icons.add,
        onTap: () async {
          await AppNavigator.pushTo(context, const AddTaskView());
          await _refreshTasks();
        },
      ),
      widget: getTaskProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (tasks.isEmpty)
                  const Expanded(
                    child: Center(child: Text("No tasks available")),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return buildListTile(
                            task, getTaskProvider, context, deleteTaskProvider);
                      },
                    ),
                  ),
              ],
            ),
    );
  }

  Widget buildListTile(
      Map<String, dynamic> task,
      GetTaskViewModel getTaskProvider,
      BuildContext context,
      DeleteTaskViewModel deleteTaskProvider) {
    return ListTile(
      title: Text(task['title']),
      subtitle: Text(
        task['isCompleted'] == 1 ? 'Completed' : 'Pending',
        style: TextStyle(
          color: task['isCompleted'] == 1 ? Colors.green : Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          task['isCompleted'] == 1
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: task['isCompleted'] == 1 ? Colors.green : Colors.grey,
        ),
        onPressed: () async {
          await getTaskProvider.toggleTask(task['id']);
          if (getTaskProvider.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(getTaskProvider.error!)),
            );
          }
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (task['isCompleted'] == 1)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.done_all, color: Colors.green, size: 20),
            ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              final success = await deleteTaskProvider.deleteTask(task['id']);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Task deleted")),
                );
                await _refreshTasks();
              } else if (deleteTaskProvider.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(deleteTaskProvider.error!)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
