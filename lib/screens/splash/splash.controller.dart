import 'package:crs/routes/routes.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/utils/constants.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final HiveService hiveService = Get.find();

  var image = 'assets/images/icon.png';

  @override
  void onInit() {
    redirect();
    super.onInit();
  }

  void redirect() async {
    var token = hiveService.get(Constants.TOKEN);
    await 2.delay();

    var route = token == null ? Routes.AUTH : Routes.NAV;
    Get.toNamed(route);
  }
}
