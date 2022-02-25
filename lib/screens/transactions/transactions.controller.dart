import 'package:crs/components/snackbars.dart';
import 'package:crs/models/request.model.dart';
import 'package:crs/services/network.service.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  final NetworkService networkService = Get.find();

  RxBool loading = false.obs;
  RxList<Request> requests = <Request>[].obs;

  @override
  void onInit() {
    getRequests();
    super.onInit();
  }

  Future<void> getRequests() async {
    String endpoint = 'api/users/requests';
    Response response = await networkService.get(endpoint);

    if (response.isOk) {
      var items = response.body as List;
      requests.value = items.reversed.map((e) => Request.fromJson(e)).toList();
    } else {
      String message = response.body['message'];
      snackBar('Error', message);
    }
  }

  void collectVehicle(Request request) async {
    dynamic data = {
      'status': 'collected',
      'request': request.id,
      'start': DateTime.now().toString(),
    };

    loading.toggle();
    String endpoint = 'api/vehicles/request';
    Response response = await networkService.put(endpoint, data);
    if (response.isOk) {
      await getRequests();
    } else {
      String message = response.body['message'];
      snackBar('Error', message);
    }
    loading.toggle();
  }
}
