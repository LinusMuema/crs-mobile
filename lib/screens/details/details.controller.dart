import 'package:crs/components/snackbars.dart';
import 'package:crs/models/request.model.dart';
import 'package:crs/models/user.model.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/routes/routes.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  final HiveService hiveService = Get.find();
  final NetworkService networkService = Get.find();

  final GlobalKey<FormBuilderState> formKey = GlobalKey();

  RxBool owned = false.obs;
  RxBool loading = false.obs;
  Rxn<Vehicle> vehicle = Rxn();
  Rxn<Request> request = Rxn();
  RxList<Request> requests = <Request>[].obs;

  @override
  void onInit() {
    User user = hiveService.get(Constants.USER);
    request.value = hiveService.get(Constants.REQUEST);
    vehicle.value = hiveService.get(Constants.VEHICLE);
    owned.value = user.id == vehicle.value!.user.id;
    if (owned.value) getRequests();

    super.onInit();
  }

  bool canUnlist() {
    var options = ['rejected', 'returned'];
    return requests.every((e) => options.contains(e.status));
  }

  bool canList() {
    var options = ['accepted', 'collected'];
    return requests.every((e) => !options.contains(e.status));
  }

  void editVehicle() async {
    dynamic args = {'vehicle': vehicle.value};
    var result = await Get.toNamed(Routes.VEHICLE, arguments: args);
    if (result != null) vehicle.value = result;
  }

  Future<void> getRequests() async {
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

  void requestVehicle() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      dynamic values = formKey.currentState!.value;
      Map<String, dynamic> data = Map.from(values);
      data['vehicle'] = vehicle.value!.id;

      loading.toggle();
      String endpoint = 'api/vehicles/request/';
      Response response = await networkService.post(endpoint, data);
      if (response.isOk) {
        request.value = Request.fromJson(response.body);
        hiveService.set(Constants.REQUEST, request.value);

        Get.back();
        snackBar('Success', 'Your request has been sent to the owner');
      } else {
        String message = response.body['message'];
        snackBar('Error', message);
      }
    }
  }

  void listVehicle() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      dynamic values = formKey.currentState!.value;
      Map<String, dynamic> data = Map.from(values);
      data['id'] = vehicle.value!.id;
      data['available'] = true;

      loading.toggle();
      String endpoint = 'api/vehicles/';
      Response response = await networkService.put(endpoint, data);
      if (response.isOk) {
        vehicle.value = Vehicle.fromJson(response.body);

        Get.back();
        snackBar('Success', 'Your vehicle is now visible to clients near you');
      } else {
        String message = response.body['message'];
        snackBar('Error', message);
      }
      loading.toggle();
    }
  }

  void unlistVehicle() async {
    loading.toggle();
    String endpoint = 'api/vehicles/';
    dynamic data = {'id': vehicle.value!.id, 'available': false};
    Response response = await networkService.put(endpoint, data);
    if (response.isOk) {
      vehicle.value = Vehicle.fromJson(response.body);

      Get.back();
      snackBar('Success', 'Your vehicle has been unlisted');
    } else {
      String message = response.body['message'];
      snackBar('Error', message);
    }
    loading.toggle();
  }

  void acceptRequest(Request request) async {
    dynamic data = {
      'available': false,
      'status': 'accepted',
      'request': request.id,
    };
    await updateRequest(data);
  }

  void declineRequest(Request request) async {
    dynamic data = {
      'available': true,
      'status': 'rejected',
      'request': request.id,
    };
    await updateRequest(data);
  }

  void endSession(Request request) async {}

  Future<void> updateRequest(dynamic data) async {
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
