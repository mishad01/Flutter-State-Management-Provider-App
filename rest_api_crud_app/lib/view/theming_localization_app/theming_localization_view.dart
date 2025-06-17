import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/core/provider/locale_provider.dart';
import 'package:rest_api_crud_app/core/provider/theme_provider.dart';

class ThemeAndLocalizationView extends StatelessWidget {
  const ThemeAndLocalizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(localizations.switch_theme),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (_) => themeProvider.toggleTheme(),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(localizations.switch_language),
              trailing: Switch(
                value: localeProvider.locale.languageCode == 'bn',
                onChanged: (_) => localeProvider.toggleLocale(),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                localeProvider.locale.languageCode == 'bn'
                    ? 'আপনি বাংলা ভাষা বেছে নিয়েছেন।'
                    : 'You have selected English language.',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                localeProvider.locale.languageCode == 'bn'
                    ? 'থিম ও ভাষা পরিবর্তন এখানে কাজ করছে।'
                    : 'Theme and language toggle is working here.',
                style:
                    const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
