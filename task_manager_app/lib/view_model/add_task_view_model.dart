import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:task_manager_app/core/db/database_helper.dart';

class AddTaskViewModel with ChangeNotifier {
  final DataBaseHelper _dbHelper = DataBaseHelper.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<bool> addTask(String title) async {
    if (title.isEmpty) {
      _error = "Task title cannot be empty";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic> task = {
        'title': title,
        'isCompleted': 0,
      };

      await _dbHelper.insertTask(task);
      await Future.delayed(const Duration(seconds: 2));

      _error = null;
      return true;
    } catch (e) {
      _error = 'Failed to add task: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
