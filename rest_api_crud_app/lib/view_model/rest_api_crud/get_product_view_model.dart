import 'package:flutter/cupertino.dart';
import 'package:rest_api_crud_app/data/network_caller.dart';
import 'package:rest_api_crud_app/data/network_response.dart';
import 'package:rest_api_crud_app/model/rest_api_crud/product_list_model.dart';
import 'package:rest_api_crud_app/model/rest_api_crud/product_model.dart';
import 'package:rest_api_crud_app/utils/urls.dart';

class GetProductViewModel with ChangeNotifier {
  NetworkCaller _networkCaller = NetworkCaller();
  GetProductViewModel(this._networkCaller);
  bool inProgress = false;
  bool isSuccess = false;
  bool _hasFetchedOnce = false; // ✅ Prevents repeated fetching

  final List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  Future<bool> getProduct() async {
    if (_hasFetchedOnce) return isSuccess;
    inProgress = true;
    notifyListeners();
    NetworkResponse response = await _networkCaller.getRequest(Urls.getProduct);
    if (response.isSuccess) {
      _productList.clear();
      final productListModel = ProductListModel.fromJson(response.body);
      if (productListModel.data != null) {
        _productList.addAll(productListModel.data!);
      }
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    inProgress = false;
    notifyListeners();
    return isSuccess;
  }

  Future<bool> getProductOnce() async {
    inProgress = true;
    notifyListeners();
    NetworkResponse response = await _networkCaller.getRequest(Urls.getProduct);
    if (response.isSuccess) {
      _productList.clear();
      final productListModel = ProductListModel.fromJson(response.body);
      if (productListModel.data != null) {
        _productList.addAll(productListModel.data!);
      }
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    inProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
