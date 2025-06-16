import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/app.dart';
import 'package:rest_api_crud_app/view_model/add_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/delete_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/get_product_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetProductViewModel()),
        ChangeNotifierProvider(create: (context) => AddProductViewModel()),
        ChangeNotifierProvider(create: (context) => DeleteProductViewModel()),
      ],
      child: RestApiCrudApp(),
    ),
  );
}
