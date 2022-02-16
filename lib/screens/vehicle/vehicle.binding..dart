import 'package:crs/screens/vehicle/vehicle.controller.dart';
import 'package:get/get.dart';

class VehicleBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => VehicleController());
}
