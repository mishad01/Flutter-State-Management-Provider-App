import 'package:flutter/cupertino.dart';
import 'package:rest_api_crud_app/model/search_item_app/search_product_model.dart';

class SearchProductViewModel with ChangeNotifier {
  String _searchItem = "";
  String _selectedCategory = "All";
  String get searchItem => _searchItem;
  String get selectedCategory => _selectedCategory;

  final List<SearchProductModel> _allProducts = [
    SearchProductModel(
        id: '1', name: 'iPhone 15', category: 'Electronics', price: 999),
    SearchProductModel(
        id: '2', name: 'Samsung TV', category: 'Electronics', price: 699),
    SearchProductModel(
        id: '3', name: 'Nike Shoes', category: 'Fashion', price: 120),
    SearchProductModel(
        id: '4', name: 'T-shirt', category: 'Fashion', price: 25),
    SearchProductModel(
        id: '5', name: 'Cooking Pan', category: 'Home', price: 30),
  ];
  List<SearchProductModel> get allProducts => _allProducts;

  List<SearchProductModel> getSearchedProduct() {
    return _allProducts.where((element) {
      final matchSearch =
          element.name.toLowerCase().contains(_searchItem.toLowerCase());
      final matchCategory =
          _selectedCategory == "All" || element.category == _selectedCategory;

      return matchSearch && matchCategory;
    }).toList();
  }

  List<String> get allCategory =>
      ['All', ...allProducts.map((e) => e.category).toSet()];

  void updatedSearchItem(String item) {
    _searchItem = item;
    notifyListeners();
  }

  void updateCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
