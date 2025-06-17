import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/add_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/delete_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/get_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/update_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/search_app/search_product_view_model.dart';

// In view_model/rest_api_crud/product_operations_view_models.dart
final providerViewModels = [
  ChangeNotifierProvider(create: (context) => GetProductViewModel()),
  ChangeNotifierProvider(create: (context) => AddProductViewModel()),
  ChangeNotifierProvider(create: (context) => DeleteProductViewModel()),
  ChangeNotifierProvider(create: (context) => UpdateProductViewModel()),
  ChangeNotifierProvider(create: (_) => SearchProductViewModel()),
];
