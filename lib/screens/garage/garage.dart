import 'package:crs/routes/routes.dart';
import 'package:crs/screens/garage/garage.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Garage extends GetView<GarageController> {
  const Garage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.VEHICLE),
        child: const Icon(Icons.add),
      ),
    );
  }
}
