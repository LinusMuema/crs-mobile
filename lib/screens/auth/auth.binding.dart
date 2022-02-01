import 'package:crs/screens/auth/auth.controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => AuthController());
}
