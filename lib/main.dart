import 'package:crs/routes/pages.dart';
import 'package:crs/routes/routes.dart';
import 'package:crs/services/background.service.dart';
import 'package:crs/services/camera.service.dart';
import 'package:crs/services/cloudinary.service.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/location.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';

void main() async {
  await initServices();
  runApp(const CrsApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => HiveService().init());
  await Get.putAsync(() => CameraService().init());
  await Get.putAsync(() => NetworkService().init());
  await Get.putAsync(() => LocationService().init());
  await Get.putAsync(() => BackgroundService().init());
  await Get.putAsync(() => CloudinaryService().init());
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
      localizationsDelegates: const [FormBuilderLocalizations.delegate],
    );
  }
}
