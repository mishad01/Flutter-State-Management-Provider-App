import 'package:flutter/cupertino.dart';
import 'package:rest_api_crud_app/data/network_caller.dart';
import 'package:rest_api_crud_app/data/network_response.dart';
import 'package:rest_api_crud_app/model/product_list_model.dart';
import 'package:rest_api_crud_app/model/product_model.dart';
import 'package:rest_api_crud_app/utils/urls.dart';

class GetProductViewModel with ChangeNotifier {
  bool inProgress = false;
  bool isSuccess = false;

  final List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  Future<bool> getProduct() async {
    inProgress = true;
    notifyListeners();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.getProduct);
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
