import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/app_route.dart';

Future main() async {
  //from fluter version v.1.12.3 higher
  WidgetsFlutterBinding.ensureInitialized();
  await translation.init("vi");
  // await Routes.navigateDefaultPage();
  runApp(
    MyApp(),
  );
}
