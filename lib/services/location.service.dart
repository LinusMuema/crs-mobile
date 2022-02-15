import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxService {
  final LocationAccuracy accuracy = LocationAccuracy.high;

  Future<LocationService> init() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return this;
  }

  Future<Position> getCurrentLocation() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: accuracy);
  }

  Stream<Position> getLocationUpdates() {
    var settings = LocationSettings(accuracy: accuracy, distanceFilter: 50);
    return Geolocator.getPositionStream(locationSettings: settings);
  }
}
