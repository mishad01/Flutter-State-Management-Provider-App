import 'package:flutter/cupertino.dart';
import 'package:test_apk/data/network_caller.dart';
import 'package:test_apk/data/network_response.dart';
import 'package:test_apk/model/product_model.dart';
import 'package:test_apk/utils/urls.dart';

class PostProductProvider with ChangeNotifier {
  bool inProgress = false;
  bool isSuccess = false;
  Future<bool> postRequest(ProductModel product) async {
    inProgress = true;
    notifyListeners();

    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createProduct,
      product.toJson(),
    );
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    inProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
