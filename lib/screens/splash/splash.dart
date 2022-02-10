import 'package:crs/screens/splash/splash.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends GetView<SplashController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          controller.image,
          width: Get.width * .2,
        ),
      ),
    );
  }
}
