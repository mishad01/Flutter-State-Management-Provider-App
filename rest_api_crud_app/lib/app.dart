import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/core/provider/locale_provider.dart';
import 'package:rest_api_crud_app/core/provider/theme_provider.dart';
import 'package:rest_api_crud_app/core/theme/app_theme.dart';
import 'package:rest_api_crud_app/view/main_layout/main_view.dart';

class RestApiCrudApp extends StatelessWidget {
  const RestApiCrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: localeProvider.locale,
      supportedLocales: const [Locale('en'), Locale('bn')],
      localizationsDelegates: [
        AppLocalizations.delegate, // Remove const here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MainView(),
    );
  }
}
