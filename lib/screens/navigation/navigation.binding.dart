import 'package:crs/screens/discover/discover.controller.dart';
import 'package:crs/screens/garage/garage.controller.dart';
import 'package:crs/screens/navigation/navigation.controller.dart';
import 'package:crs/screens/profile/profile.controller.dart';
import 'package:crs/screens/transactions/transactions.controller.dart';
import 'package:get/get.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());

    // The screens under navigation
    Get.lazyPut(() => GarageController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => DiscoverController());
    Get.lazyPut(() => TransactionsController());
  }
}
