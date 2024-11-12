import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'perfection/app/app_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    startLocale: const Locale('en'),
    fallbackLocale: const Locale('ar'),
    child: const MyApp(),
  ),);
}
