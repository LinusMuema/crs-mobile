import 'package:crs/routes/routes.dart';
import 'package:crs/services/hive.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final HiveService hiveService = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    final String? token = hiveService.get('token');
    print(token);
    return (token == null) ? null : const RouteSettings(name: Routes.NAV);
  }
}
