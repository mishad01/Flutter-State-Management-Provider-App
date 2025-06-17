import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  void toggleLocale() {
    if (_locale.languageCode == 'en') {
      _locale = const Locale('bn');
    } else {
      _locale = const Locale('en');
    }
    notifyListeners();
  }
}
/*
flutter:
  uses-material-design: true
  generate: true

l10n:
  arb-dir: lib/l10n
  template-arb-file: app_en.arb

  flutter gen-l10n

  */
