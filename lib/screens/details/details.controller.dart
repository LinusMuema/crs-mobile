import 'package:crs/models/vehicle.model.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/utils/constants.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  final HiveService hiveService = Get.find();
  final NetworkService networkService = Get.find();

  Rxn<Vehicle> vehicle = Rxn();

  @override
  void onInit() {
    vehicle.value = hiveService.get(Constants.VEHICLE);
    super.onInit();
  }
}
