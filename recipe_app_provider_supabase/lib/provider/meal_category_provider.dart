import 'package:flutter/material.dart';
import 'package:recipe_app_provider_supabase/core/service/network_caller.dart';
import 'package:recipe_app_provider_supabase/core/service/network_response.dart';
import 'package:recipe_app_provider_supabase/core/utils/urls.dart';
import 'package:recipe_app_provider_supabase/model/category_list_model.dart';
import 'package:recipe_app_provider_supabase/model/category_model.dart';

class MealCategoryProvider with ChangeNotifier {
  bool inProgress = false;
  bool isSuccess = true;
  final List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;

  Future<bool> getCategory() async {
    inProgress = true;
    notifyListeners();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.mealCategory);

    if (response.isSuccess) {
      _categoryList.clear();

      final categoryListModel = CategoryListModel.fromJson(response.body);
      if (categoryListModel.categories != null) {
        _categoryList.addAll(categoryListModel.categories!);
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
