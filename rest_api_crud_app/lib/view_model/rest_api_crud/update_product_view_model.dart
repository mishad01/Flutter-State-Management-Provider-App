import 'package:flutter/cupertino.dart';
import 'package:rest_api_crud_app/data/network_caller.dart';
import 'package:rest_api_crud_app/data/network_response.dart';
import 'package:rest_api_crud_app/model/rest_api_crud/product_model.dart';
import 'package:rest_api_crud_app/utils/urls.dart';

class UpdateProductViewModel with ChangeNotifier {
  NetworkCaller _networkCaller = NetworkCaller();
  UpdateProductViewModel(this._networkCaller);
  bool _inProgress = false;
  bool _isSuccess = false;

  bool get inProgress => _inProgress;
  bool get isSuccess => _isSuccess;

  Future<bool> updateProduct(String id, ProductModel product) async {
    _inProgress = true;
    notifyListeners();
    NetworkResponse response = await _networkCaller.postRequest(
        Urls.updateProduct(id), product.toJson());
    if (response.isSuccess) {
      _isSuccess = true;
    } else {
      _isSuccess = false;
    }
    _inProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
