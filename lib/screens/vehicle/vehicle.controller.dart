import 'dart:async';

import 'package:crs/components/snackbars.dart';
import 'package:crs/models/user.model.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/screens/garage/garage.controller.dart';
import 'package:crs/services/camera.service.dart';
import 'package:crs/services/cloudinary.service.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:short_uuids/short_uuids.dart';

class VehicleController extends GetxController {
  final HiveService hiveService = Get.find();
  final CameraService cameraService = Get.find();
  final NetworkService networkService = Get.find();
  final CloudinaryService cloudinaryService = Get.find();

  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  final TextEditingController textController = TextEditingController();

  Rxn<User> user = Rxn();
  RxBool loading = false.obs;
  Rxn<Vehicle> vehicle = Rxn();
  RxList<String> urls = <String>[].obs;
  RxList<bool> uploading = <bool>[].obs;

  List<String> makes = [
    'Toyota',
    'Jeep',
    'Bmw',
    'Audi',
    'Mazda',
    'Ford',
    'Honda',
    'Nissan',
    'Hyundai',
    'Kia'
  ];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() {
    user.value = hiveService.get(Constants.USER);

    var args = Get.arguments;
    if (args != null) {
      vehicle.value = Get.arguments['vehicle'];
      textController.text = vehicle.value!.make;

      urls.addAll(vehicle.value!.images);
      uploading.addAll(vehicle.value!.images.map((e) => false).toList());
    }
  }

  void pickImage() async {
    if (urls.length == 3) {
      snackBar('Limit', 'You cannot upload more than three images');
      return;
    }

    var image = await cameraService.getImage();
    if (image == null) {
      snackBar('Image', 'Image upload cancelled');
      return;
    }

    const short = ShortUuid();
    var name = short.generate();
    var path = '/crs/vehicles/${user.value!.email}';

    urls.add('');
    uploading.add(true);

    var index = uploading.length - 1;
    var response = await cloudinaryService.uploadImage(image, path, name);

    uploading[index] = false;
    urls[index] = response.secureUrl!;
  }

  void removeImage(int index) async {
    Get.back();

    uploading[index] = true;

    await cloudinaryService.deleteImage(urls[index]);
    urls.removeAt(index);
    uploading.removeAt(index);
  }

  Future<List<String>> getSuggestions(String pattern) async => makes
      .where((e) => e.toLowerCase().contains(pattern.toLowerCase()))
      .toList();

  void setSuggestion(String suggestion) => textController.text = suggestion;

  void submit() async {
    if (formKey.currentState!.validate()) {
      if (urls.isEmpty) {
        snackBar('Images', 'Upload at least one image of your result');
        return;
      }

      formKey.currentState!.save();

      dynamic formData = formKey.currentState!.value;
      Map<String, dynamic> data = Map.from(formData);
      data['images'] = urls;
      data['make'] = textController.text.toLowerCase();
      if (vehicle.value != null) data['id'] = vehicle.value!.id;

      loading.value = true;
      String endpoint = 'api/vehicles';
      Response response = vehicle.value != null
          ? await networkService.put(endpoint, data)
          : await networkService.post(endpoint, data);

      if (response.isOk) {
        var result = Vehicle.fromJson(response.body);

        // update the garage
        GarageController controller = Get.find();
        if (vehicle.value == null) controller.addVehicle(result);

        Get.back(result: result);
      } else {
        String message = response.body['message'];
        snackBar('Error', message);
      }
      loading.value = false;
    }
  }
}
