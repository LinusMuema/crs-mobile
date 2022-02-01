import 'package:crs/routes/pages.dart';
import 'package:crs/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const CrsApp());
}

class CrsApp extends StatelessWidget {
  const CrsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      getPages: CrsPages.pages,
      initialRoute: Routes.SPLASH,
    );
  }
}
