import 'package:crs/components/snackbars.dart';
import 'package:crs/models/request.model.dart';
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
  RxList<Request> requests = <Request>[].obs;

  @override
  void onInit() {
    User user = hiveService.get(Constants.USER);
    vehicle.value = hiveService.get(Constants.VEHICLE);
    owned.value = user.id == vehicle.value!.user.id;
    if (owned.value) getRequests();

    super.onInit();
  }

  void editVehicle() async {
    dynamic args = {'vehicle': vehicle.value};
    var result = await Get.toNamed(Routes.VEHICLE, arguments: args);
    if (result != null) vehicle.value = result;
  }

  void getRequests() async {
    String endpoint = 'api/vehicles/history';
    dynamic data = {'id': vehicle.value!.id};

    Response response = await networkService.post(endpoint, data);
    if (response.isOk) {
      var items = response.body as List;
      requests.value = items.reversed.map((e) => Request.fromJson(e)).toList();
    } else {
      String message = response.body['message'];
      snackBar('Error', message);
    }
  }
}
