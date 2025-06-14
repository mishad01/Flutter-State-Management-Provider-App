import 'package:flutter/foundation.dart';
import 'package:searching_apk/data/product_data.dart';
import 'package:searching_apk/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  String _searchItem = "";
  String _selectedCategory = "All";

  String get searchItem => _searchItem;
  String get selectCategory => _selectedCategory;

  List<Product> get allProduct => ProductData.allProduct;

  List<Product> getSearchedProduct() {
    return ProductData.allProduct.where(
      (product) {
        final matchCategory =
            _selectedCategory == "All" || product.category == _selectedCategory;
        final matchSearch =
            product.name.toLowerCase().contains(searchItem.toLowerCase());

        return matchCategory && matchSearch;
      },
    ).toList();
  }

  List<String> get categories =>
      ['All', ...ProductData.allProduct.map((e) => e.category).toSet()];

  void updateSearchItem(String value) {
    _searchItem = value;
    notifyListeners();
  }

  void updateSelectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }
}
