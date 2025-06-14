import 'package:searching_apk/model/product_model.dart';

class ProductData {
  static final List<Product> _allProduct = [
    Product(id: '1', name: 'iPhone 15', category: 'Electronics', price: 999),
    Product(id: '2', name: 'Samsung TV', category: 'Electronics', price: 699),
    Product(id: '3', name: 'Nike Shoes', category: 'Fashion', price: 120),
    Product(id: '4', name: 'T-shirt', category: 'Fashion', price: 25),
    Product(id: '5', name: 'Cooking Pan', category: 'Home', price: 30),
  ];
  static List<Product> get allProduct => _allProduct;
}
