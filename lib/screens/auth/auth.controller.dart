import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final HiveService hiveService = Get.find();
  final NetworkService networkService = Get.find();

  RxInt page = 0.obs;

  void changePage(int index) => page.value = index;

  void login() async {
    // TODO: implement the logic
  }

  void signup() async {
    // TODO: implement the logic
  }
}
