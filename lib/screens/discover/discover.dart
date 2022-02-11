import 'dart:async';

import 'package:crs/screens/discover/discover.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Discover extends GetView<DiscoverController> {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();

    CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height * .5,
            child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          DraggableScrollableSheet(
            minChildSize: .5,
            initialChildSize: .5,
            builder: (context, controller) {
              return SingleChildScrollView(
                controller: controller,
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
                      Text('Available vehicles', style: heading),
                      Container(height: Get.height)
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
