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

  List<Vehicle> available = [];
  Rxn<Position> current = Rxn();
  Rxn<BitmapDescriptor> icon = Rxn();
  RxList<Vehicle> filtered = <Vehicle>[].obs;
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

  void getVehicles() async {
    String endpoint = 'api/vehicles/nearby';

    double currentLat = current.value!.latitude;
    double currentLng = current.value!.longitude;
    dynamic data = {'lat': currentLat, 'lng': currentLng};
    print("data is $data");

    Response response = await networkService.post(endpoint, data);
    if (response.isOk) {
      var items = response.body as List;
      print("items are $items");
      available = items.map((e) => Vehicle.fromJson(e)).toList();
      filtered.value = available;
    } else {
      print("error is ${response.bodyString}");
      String message = response.body['message'];
      snackBar('Error', message);
    }
  }

  @override
  void dispose() {
    windowController.dispose();
    super.dispose();
  }
}
