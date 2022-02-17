import 'package:cached_network_image/cached_network_image.dart';
import 'package:crs/components/loaders.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/routes/routes.dart';
import 'package:crs/screens/garage/garage.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Garage extends GetView<GarageController> {
  const Garage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Padding(
          padding: regularHInsets,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceRegular,
                Text('My vehicles', style: heading1.copyWith(fontSize: 20)),
                verticalSpaceSmall,
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: controller.vehicles.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    var vehicle = controller.vehicles[i];
                    return card(vehicle);
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.VEHICLE),
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  Widget card(Vehicle vehicle) {
    const radius = BorderRadius.vertical(top: Radius.circular(15));
    const shape = RoundedRectangleBorder(borderRadius: regularRadius);
    var name = '${vehicle.make.capitalize} ${vehicle.model.toLowerCase()}';
    return Container(
      width: Get.width,
      margin: regularVInsets,
      child: Card(
        elevation: 5,
        shape: shape,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: radius,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: Get.height * .2,
                imageUrl: vehicle.images.first,
                placeholder: (c, i) => pulse(color: black),
              ),
            ),
            verticalSpaceTiny,
            Padding(
              padding: smallInsets,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: heading1),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
