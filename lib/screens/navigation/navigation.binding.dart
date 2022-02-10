import 'package:crs/screens/navigation/navigation.controller.dart';
import 'package:get/get.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => NavigationController());
}
