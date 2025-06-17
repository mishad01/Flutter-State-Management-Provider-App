import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/app.dart';
import 'package:rest_api_crud_app/core/provider/locale_provider.dart';
import 'package:rest_api_crud_app/core/provider/providers_view_models.dart';
import 'package:rest_api_crud_app/core/provider/theme_provider.dart';
import 'package:rest_api_crud_app/view_model/bottom_nav/main_bottom_nav_view_model.dart';
import 'package:rest_api_crud_app/view_model/search_app/search_product_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Core Providers (App-wide functionality)
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),

        // Feature Providers (Grouped by feature)
        ...providerViewModels,
        ChangeNotifierProvider(create: (_) => MainBottomNavViewModel()),
        ChangeNotifierProvider(create: (_) => SearchProductViewModel()),
      ],
      child: const RestApiCrudApp(),
    ),
  );
}
