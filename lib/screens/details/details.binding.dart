import 'package:crs/screens/details/details.controller.dart';
import 'package:get/get.dart';

class DetailsBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => DetailsController());
}
