import 'package:crs/models/user.model.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/routes/routes.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/utils/constants.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  final HiveService hiveService = Get.find();
  final NetworkService networkService = Get.find();

  RxBool owned = false.obs;
  Rxn<Vehicle> vehicle = Rxn();

  @override
  void onInit() {
    User user = hiveService.get(Constants.USER);
    vehicle.value = hiveService.get(Constants.VEHICLE);
    owned.value = user.id == vehicle.value!.user.id;

    super.onInit();
  }

  void editVehicle() async {
    dynamic args = {'vehicle': vehicle.value};
    var result = await Get.toNamed(Routes.VEHICLE, arguments: args);
    if (result != null) vehicle.value = result;
  }
}
