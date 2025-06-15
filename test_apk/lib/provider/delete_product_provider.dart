import 'package:flutter/cupertino.dart';
import 'package:test_apk/data/network_caller.dart';
import 'package:test_apk/data/network_response.dart';
import 'package:test_apk/utils/urls.dart';

class DeleteProductProvider with ChangeNotifier {
  bool inProgress = false;
  bool isSuccess = false;
  String deletingId = ''; // Track which ID is being deleted

  Future<bool> deleteProduct(String id) async {
    inProgress = true;
    deletingId = id; // Mark current deleting ID
    notifyListeners();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteProduct(id));
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    inProgress = false;
    deletingId = '';
    notifyListeners();
    return isSuccess;
  }
}
