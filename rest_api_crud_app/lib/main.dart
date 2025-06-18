import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/app.dart';
import 'package:rest_api_crud_app/core/provider/locale_provider.dart';
import 'package:rest_api_crud_app/core/provider/theme_provider.dart';
import 'package:rest_api_crud_app/data/network_caller.dart';
import 'package:rest_api_crud_app/view_model/bottom_nav/main_bottom_nav_view_model.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/add_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/delete_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/get_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/update_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/search_app/search_product_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NetworkCaller>(create: (context) => NetworkCaller()),

        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),

        // Inject feature ViewModels AFTER NetworkCaller exists:
        ChangeNotifierProvider(
          create: (context) =>
              GetProductViewModel(context.read<NetworkCaller>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              AddProductViewModel(context.read<NetworkCaller>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DeleteProductViewModel(context.read<NetworkCaller>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              UpdateProductViewModel(context.read<NetworkCaller>()),
        ),

        ChangeNotifierProvider(create: (_) => MainBottomNavViewModel()),
        ChangeNotifierProvider(create: (_) => SearchProductViewModel()),
      ],
      child: const RestApiCrudApp(),
    ),
  );
}
