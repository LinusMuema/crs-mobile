import 'dart:async';
import 'dart:typed_data';

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
  RxList<String> urls = <String>[].obs;
  RxList<bool> uploading = <bool>[].obs;
  RxList<Uint8List> images = <Uint8List>[].obs;

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
    user.value = hiveService.get(Constants.USER);
    super.onInit();
  }

  void pickImage() async {
    if (images.length == 3) {
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

    images.add(image);
    uploading.add(true);

    var response = await cloudinaryService.uploadImage(image, path, name);

    urls.add(response.secureUrl!);
    uploading[uploading.length - 1] = false;
  }

  void removeImage(int index) async {
    Get.back();

    images.removeAt(index);
    uploading.removeAt(index);

    await cloudinaryService.deleteImage(urls[index]);
    urls.removeAt(index);
  }

  Future<List<String>> getSuggestions(String pattern) async => makes
      .where((e) => e.toLowerCase().contains(pattern.toLowerCase()))
      .toList();

  void setSuggestion(String suggestion) => textController.text = suggestion;

  void submit() async {
    if (formKey.currentState!.validate()) {
      if (urls.isEmpty) {
        snackBar('Images', 'Upload at least one image of your vehicle');
        return;
      }

      formKey.currentState!.save();

      dynamic formData = formKey.currentState!.value;
      Map<String, dynamic> data = Map.from(formData);
      data['images'] = urls;
      data['make'] = textController.text.toLowerCase();

      loading.value = true;
      String endpoint = 'api/vehicles';
      Response response = await networkService.post(endpoint, data);
      if (response.isOk) {
        var vehicle = Vehicle.fromJson(response.body);
        GarageController controller = Get.find();
        controller.addVehicle(vehicle);

        Get.back();
        snackBar('Success', 'Your vehicle has been successfully registered');
      } else {
        String message = response.body['message'];
        snackBar('Error', message);
      }
      loading.value = false;
    }
  }
}
