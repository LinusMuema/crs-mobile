import 'package:cached_network_image/cached_network_image.dart';
import 'package:crs/components/loaders.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/screens/discover/discover.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Discover extends GetView<DiscoverController> {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var markers = <Marker>{};
      var target = const LatLng(0.0, 0.0);
      var position = CameraPosition(target: target, zoom: 14);

      var current = controller.current.value;
      var windowController = controller.windowController;
      if (current != null) {
        var mapController = controller.mapController.value!;

        target = LatLng(current.latitude, current.longitude);
        position = CameraPosition(target: target, zoom: 16);
        mapController.animateCamera(CameraUpdate.newCameraPosition(position));

        markers.addAll(
          controller.filtered.map((e) {
            var lat = e.user.location.coordinates.last;
            var lng = e.user.location.coordinates.first;
            var position = LatLng(lat, lng);
            return Marker(
              position: position,
              icon: controller.icon.value!,
              markerId: MarkerId(e.toString()),
              onTap: () {
                windowController.addInfoWindow!(window(e), position);
              },
            );
          }),
        );
      }

      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: Get.height * .7,
              child: Stack(
                children: [
                  GoogleMap(
                    markers: markers,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: position,
                    onMapCreated: controller.mapCreated,
                    onTap: (p) => windowController.hideInfoWindow!(),
                    onCameraMove: (p) => windowController.onCameraMove!(),
                  ),
                  CustomInfoWindow(
                    width: Get.width * .6,
                    height: Get.width * .55,
                    controller: windowController,
                  ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              minChildSize: .4,
              initialChildSize: .4,
              builder: (context, ctrl) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: ctrl,
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        verticalSpaceSmall,
                        Container(
                          height: 5,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: fullRadius,
                            color: black.withOpacity(.5),
                          ),
                        ),
                        verticalSpaceTiny,
                        Text('Available vehicles', style: heading1),
                        verticalSpaceSmall,
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.filtered.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var vehicle = controller.filtered[index];
                            return card(vehicle);
                          },
                        ),
                        verticalSpaceMassive,
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  Widget window(Vehicle vehicle) {
    var name = '${vehicle.model} ${vehicle.make}'.capitalize;
    const radius = BorderRadius.vertical(top: Radius.circular(15));
    const shape = RoundedRectangleBorder(borderRadius: regularRadius);

    return Card(
      elevation: 10,
      shape: shape,
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            ClipRRect(
              borderRadius: radius,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: Get.width * .6,
                height: Get.width * .3,
                imageUrl: vehicle.images.first,
                placeholder: (c, i) => pulse(color: black),
              ),
            ),
            verticalSpaceTiny,
            Padding(
              padding: regularHInsets,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name!, style: heading1),
                      Text('Ksh. ${vehicle.rate}/hr', style: heading4)
                    ],
                  ),
                  verticalSpaceTiny,
                  Text('Available from:', style: body1),
                  Text('8:00 am to 7:00 pm', style: body1),
                  verticalSpaceTiny,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget card(Vehicle vehicle) {
    return Card(
      child: Row(
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            width: Get.width * .3,
            height: Get.width * .3,
            imageUrl: vehicle.images.first,
            placeholder: (c, i) => pulse(color: black),
          ),
        ],
      ),
    );
  }
}
