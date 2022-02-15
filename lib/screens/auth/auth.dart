import 'package:crs/screens/auth/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Auth extends GetView<AuthController> {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.page.value,
          children: controller.screens,
        ),
      );
    });
  }
}
