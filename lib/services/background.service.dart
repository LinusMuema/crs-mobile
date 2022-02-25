import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:crs/models/location.model.dart' as model;
import 'package:crs/models/user.model.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/utils/constants.dart';
import 'package:get/get.dart';

class BackgroundService extends GetxService {
  final HiveService hiveService = Get.find();
  final NetworkService networkService = Get.find();

  final StreamController<Location> location = StreamController();

  Future<BackgroundService> init() async {
    BackgroundLocation.startLocationService();
    BackgroundLocation.getLocationUpdates(updateLocation);
    return this;
  }

  void updateLocation(Location data) async {
    location.sink.add(data);

    User user = hiveService.get(Constants.USER);

    double lat = data.latitude ?? 0.0;
    double lng = data.longitude ?? 0.0;
    user.location = model.Location(coordinates: [lng, lat]);

    // update local user
    hiveService.set(Constants.USER, user);

    // push to server
    String endpoint = 'api/users/';
    await networkService.put(endpoint, user);

    // TODO: check if there's a request ongoing and update it's location too
  }
}
