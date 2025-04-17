import 'package:flutter/material.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:flutter_space_x/services/navigation/navigation_service.dart';

import 'i18n/i18n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.localizations.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          labelMedium: TextStyle(color: Colors.grey.shade400),
        ),
      ),
      routerConfig: locator<NavigationService>().config,
    );
  }
}
