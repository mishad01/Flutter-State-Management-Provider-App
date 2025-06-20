import 'package:flutter/foundation.dart';
import 'package:task_manager_app/core/db/database_helper.dart';

class GetTaskViewModel with ChangeNotifier {
  final DataBaseHelper _dbHelper = DataBaseHelper.instance;

  List<Map<String, dynamic>> _tasks = [];
  List<Map<String, dynamic>> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedTasks = await _dbHelper.getTask();
      _tasks = List<Map<String, dynamic>>.from(fetchedTasks);
      _error = null;
    } catch (e) {
      _error = "Failed to fetch tasks: $e";
      _tasks = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleTask(int id) async {
    final index = _tasks.indexWhere((task) => task['id'] == id);
    if (index == -1) return;

    // Create a new mutable copy of the task
    final newTask = Map<String, dynamic>.from(_tasks[index]);
    final newValue = newTask['isCompleted'] == 1 ? 0 : 1;
    newTask['isCompleted'] = newValue;

    // Create a new list with the updated task
    final newTasks = List<Map<String, dynamic>>.from(_tasks);
    newTasks[index] = newTask;

    // Optimistically update the UI
    _tasks = newTasks;
    notifyListeners();

    try {
      // Update in database
      await _dbHelper.updateTask(id, newValue);
    } catch (e) {
      // Revert if update fails
      _tasks = List<Map<String, dynamic>>.from(_tasks);
      _tasks[index]['isCompleted'] = newValue == 1 ? 0 : 1;
      notifyListeners();

      _error = "Failed to update task: $e";
      notifyListeners();
    }
  }
}
