import 'dart:async';
import 'dart:typed_data';

import 'package:crs/components/snackbars.dart';
import 'package:crs/services/camera.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class VehicleController extends GetxController {
  final CameraService cameraService = Get.find();

  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  final TextEditingController textController = TextEditingController();

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
    if (images.length == 3) {
      snackBar('Limit', 'You cannot upload more than three images');
      return;
    }

    var image = await cameraService.getImage();
    if (image == null) {
      snackBar('Image', 'Image upload cancelled');
      return;
    }

    images.add(image);
  }

  Future<List<String>> getSuggestions(String pattern) async => makes
      .where((e) => e.toLowerCase().contains(pattern.toLowerCase()))
      .toList();

  void setSuggestion(String suggestion) {
    textController.text = suggestion;
    formKey.currentState!.fields['make']!.didChange(suggestion);
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      // TODO: implement the upload function
    }
  }
}
