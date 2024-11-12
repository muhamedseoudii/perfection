
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../presentation/manager/resources/routes_manager.dart';
import '../presentation/manager/resources/theme_manager.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfection',
      theme: getApplicationTheme(),
      onGenerateRoute: RoutesGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
