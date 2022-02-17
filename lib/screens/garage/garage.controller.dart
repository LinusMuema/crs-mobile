import 'package:crs/components/snackbars.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/services/network.service.dart';
import 'package:get/get.dart';

class GarageController extends GetxController {
  final NetworkService networkService = Get.find();

  RxBool loading = false.obs;
  RxList<Vehicle> vehicles = <Vehicle>[].obs;

  @override
  void onInit() {
    getVehicles();
    super.onInit();
  }

  void getVehicles() async {
    loading.value = true;
    String endpoint = 'api/vehicles';
    Response response = await networkService.get(endpoint);

    if (response.isOk) {
      var items = response.body as List;
      vehicles.value = items.map((e) => Vehicle.fromJson(e)).toList();
    } else {
      String message = response.body['message'];
      snackBar('Error', message);
    }
    loading.value = false;
  }

  void addVehicle(Vehicle item) => vehicles.add(item);
}
