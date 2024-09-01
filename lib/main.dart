// ignore: unused_import
import 'package:auto_animated/auto_animated.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'application.dart';
import 'locator.dart';

const optionsForListView = LiveOptions(
  showItemInterval: Duration(milliseconds: 200),
  showItemDuration: Duration(milliseconds: 100),
  visibleFraction: 0.0001,
  reAnimateOnVisibility: false,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  setup();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("en")],
      path: 'assets/translations',
      saveLocale: true,
      startLocale: const Locale('en'),
      child: const Application(),
    ),
  );
}
