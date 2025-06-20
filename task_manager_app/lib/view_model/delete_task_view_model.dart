import 'package:flutter/foundation.dart';
import 'package:task_manager_app/core/db/database_helper.dart';

class DeleteTaskViewModel with ChangeNotifier {
  final DataBaseHelper _dbHelper = DataBaseHelper.instance;

  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;

  String? _error;
  String? get error => _error;

  Future<bool> deleteTask(int id) async {
    _isDeleting = true;
    notifyListeners();

    try {
      int result = await _dbHelper.deleteTask(id);
      _error = null;
      return result > 0;
    } catch (e) {
      _error = "Failed to delete task: $e";
      return false;
    } finally {
      _isDeleting = false;
      notifyListeners();
    }
  }
}
