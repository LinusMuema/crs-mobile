import 'dart:typed_data';

import 'package:crs/components/snackbars.dart';
import 'package:crs/services/camera.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class VehicleController extends GetxController {
  final CameraService cameraService = Get.find();

  final GlobalKey<FormBuilderState> formKey = GlobalKey();

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

  void pickImage() async {
    var image = await cameraService.getImage();
    if (image == null) {
      snackBar('Image', 'Image upload cancelled');
      return;
    }

    images.add(image);
  }
}
