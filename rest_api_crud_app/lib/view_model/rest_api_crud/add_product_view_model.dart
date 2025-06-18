import 'package:flutter/material.dart';
import 'package:rest_api_crud_app/data/network_caller.dart';
import 'package:rest_api_crud_app/data/network_response.dart';
import 'package:rest_api_crud_app/model/rest_api_crud/product_model.dart';
import 'package:rest_api_crud_app/utils/urls.dart';

class AddProductViewModel with ChangeNotifier {
  NetworkCaller _networkCaller = NetworkCaller();
  AddProductViewModel(this._networkCaller);
  bool _inProgress = false;
  bool _isSuccess = false;

  bool get inProgress => _inProgress;
  bool get isSuccess => _isSuccess;

  Future<bool> addProduct(ProductModel product) async {
    _inProgress = true;
    notifyListeners();
    NetworkResponse response = await _networkCaller.postRequest(
      Urls.createProduct,
      product.toJson(),
    );

    if (response.isSuccess) {
      _isSuccess = true;
    } else {
      _isSuccess = false;
    }
    return isSuccess;
  }
}
