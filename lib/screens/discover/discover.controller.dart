import 'package:background_location/background_location.dart';
import 'package:crs/components/snackbars.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/routes/routes.dart';
import 'package:crs/services/background.service.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/utils/constants.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoverController extends GetxController {
  final HiveService hiveService = Get.find();
  final NetworkService networkService = Get.find();
  final BackgroundService backgroundService = Get.find();

  CustomInfoWindowController windowController = CustomInfoWindowController();

  List<Vehicle> available = [];
  Rxn<Location> current = Rxn();
  Rxn<BitmapDescriptor> icon = Rxn();
  RxList<Vehicle> filtered = <Vehicle>[].obs;
  Rxn<GoogleMapController> mapController = Rxn();

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  void viewDetails(Vehicle vehicle) {
    hiveService.set(Constants.VEHICLE, vehicle);
    Get.toNamed(Routes.DETAILS);
  }

  void getLocation() async {
    icon.value = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/car-icon.png',
    );
    current.value = await backgroundService.location.stream.first;
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

    double currentLat = current.value!.latitude!;
    double currentLng = current.value!.longitude!;
    dynamic data = {'lat': currentLat, 'lng': currentLng};

    Response response = await networkService.post(endpoint, data);
    if (response.isOk) {
      var items = response.body as List;
      available = items.map((e) => Vehicle.fromJson(e)).toList();
      filtered.value = available;
    } else {
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
