import 'package:crud_app_using_provider/data/network_caller.dart';
import 'package:crud_app_using_provider/data/network_response.dart';
import 'package:crud_app_using_provider/model/product_list_model.dart';
import 'package:crud_app_using_provider/model/product_model.dart';
import 'package:crud_app_using_provider/utils/urls.dart';
import 'package:flutter/foundation.dart';

class ProductListProvider with ChangeNotifier {
  bool apiInProgress = false;
  bool isSuccess = false;
  final List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  Future<bool> getProductList() async {
    apiInProgress = true;
    notifyListeners();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.getProducts);

    if (response.isSuccess) {
      _productList.clear();

      final productListModel = ProductListModel.fromJson(response.responseData);
      if (productListModel.data != null) {
        _productList.addAll(productListModel.data!);
      }
      isSuccess = true;
    } else {
      isSuccess = false;
    }

    apiInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
