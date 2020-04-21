import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/app_route.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/services/onesingal-service.dart';
import 'package:ts24care/src/app/widgets/restart_widget.dart';

Future main() async {
  //from fluter version v.1.12.3 higher
  WidgetsFlutterBinding.ensureInitialized();
  await OneSignalService.setup(oneSignal_appId,
      successCallBack: handlerPushNotification.init);
  await translation.init("vi");
  await Routes.navigateDefaultPage();
  runApp(
    RestartWidget(
      child: MyApp(),
    ),
  );
}
