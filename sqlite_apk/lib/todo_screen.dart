import 'package:flutter/material.dart';
import 'package:sqlite_apk/data/databaseHelper.dart';
import 'package:sqlite_apk/utils/task.dart';
import 'package:sqlite_apk/utils/validator.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _taskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Task> _task = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTask();
  }

  Future<void> _loadTask() async {
    final tasks = await DataBaseHelper.instance.getTask();
    setState(() {
      _task = tasks.map((task) => Task.fromMap(task)).toList();
    });
  }

  Future<void> _addTask(Task task) async {
    await DataBaseHelper.instance.insertTask(task.toMap());
    _loadTask();
  }

  Future<void> _toggleTask(Task task) async {
    await DataBaseHelper.instance
        .updateTask(task.id!, task.isCompleted == 1 ? 0 : 1);
    _loadTask();
  }

  Future<void> _deleteTask(Task task) async {
    await DataBaseHelper.instance.deleteTask(task.id!);
    _loadTask();
  }

  void saveItem() {
    if (_formKey.currentState!.validate()) {
      final task = Task(title: _taskController.text, isCompleted: 0);
      _addTask(task);
      _taskController.clear();
      print("Task Added");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SQLITE ToDo App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _taskController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Enter Task",
                      ),
                      validator: (value) {
                        return Validator.isEmptyOrNull(
                            value, "Task cannot be empty");
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        saveItem();
                      },
                      icon: Icon(Icons.add)),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _task.length,
                  itemBuilder: (context, index) {
                    final task = _task[index];
                    return ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted == 1
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () => _toggleTask(task),
                            icon: Icon(
                              task.isCompleted == 1
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _deleteTask(task),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
