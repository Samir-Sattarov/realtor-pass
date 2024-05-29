// ignore: unused_import
import 'package:auto_animated/auto_animated.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  // final box = await Hive.openBox("storage");

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
