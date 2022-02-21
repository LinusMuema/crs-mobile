import 'dart:math';

import 'package:crs/components/snackbars.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/services/location.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoverController extends GetxController {
  final NetworkService networkService = Get.find();
  final LocationService locationService = Get.find();

  CustomInfoWindowController windowController = CustomInfoWindowController();

  Rxn<Position> current = Rxn();
  Rxn<BitmapDescriptor> icon = Rxn();
  RxList<Vehicle> available = <Vehicle>[].obs;
  Rxn<GoogleMapController> mapController = Rxn();

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  void getLocation() async {
    icon.value = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/car-icon.png',
    );
    current.value = await locationService.getCurrentLocation();
    getVehicles();
  }

  void mapCreated(GoogleMapController controller) {
    mapController.value = controller;
    mapController.value!.setMapStyle(
      '[{"featureType": "poi","stylers": [{"visibility": "off"}]}]',
    );
    windowController.googleMapController = controller;
  }

  LatLng getRandom() {
    final random = Random();
    double currentLat = current.value!.latitude;
    double currentLng = current.value!.longitude;

    double nextDouble(min, max) => min + random.nextDouble() * (max - min);

    double lat = nextDouble((currentLat - .01), (currentLat + .01));
    double lng = nextDouble((currentLng - .01), (currentLng + .01));
    return LatLng(lat, lng);
  }

  @override
  void dispose() {
    windowController.dispose();
    super.dispose();
  }

  void getVehicles() async {
    String endpoint = 'api/vehicles/nearby';

    double currentLat = current.value!.latitude;
    double currentLng = current.value!.longitude;
    dynamic data = {'lat': currentLat, 'lng': currentLng};

    Response response = await networkService.post(endpoint, data);
    if (response.isOk) {
      print(response.body);
    } else {
      String message = response.body['message'];
      snackBar('Error', message);
    }
  }
}
