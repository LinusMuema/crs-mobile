import 'package:crs/routes/pages.dart';
import 'package:crs/routes/routes.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/location.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  await initServices();
  runApp(const CrsApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => HiveService().init());
  await Get.putAsync(() => NetworkService().init());
  await Get.putAsync(() => LocationService().init());
}

class CrsApp extends StatelessWidget {
  const CrsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      theme: lightTheme(),
      getPages: CrsPages.pages,
      initialRoute: Routes.SPLASH,
    );
  }
}
