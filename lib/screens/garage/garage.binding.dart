import 'package:crs/screens/garage/garage.controller.dart';
import 'package:get/get.dart';

class GarageBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => GarageController());
}
