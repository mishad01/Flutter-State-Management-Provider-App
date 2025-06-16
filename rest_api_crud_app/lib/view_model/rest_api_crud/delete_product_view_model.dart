import 'package:flutter/cupertino.dart';
import 'package:rest_api_crud_app/data/network_caller.dart';
import 'package:rest_api_crud_app/data/network_response.dart';
import 'package:rest_api_crud_app/utils/urls.dart';

class DeleteProductViewModel with ChangeNotifier {
  bool _inProgress = false;
  bool _isSuccess = false;
  String _deletingId = "";

  bool get inProgress => _inProgress;
  bool get isSuccess => _isSuccess;
  String get deletingId => _deletingId;

  Future<bool> deleteProduct(String id) async {
    _inProgress = true;
    _deletingId = id;
    notifyListeners();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteProduct(id));
    if (response.isSuccess) {
      _isSuccess = true;
    } else {
      _isSuccess = false;
    }
    _inProgress = false;
    _deletingId = "";
    notifyListeners();
    return _isSuccess;
  }
}
