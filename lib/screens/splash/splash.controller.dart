import 'package:crs/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var image = 'assets/images/icon.png';

  @override
  void onInit() {
    redirect();
    super.onInit();
  }

  void redirect() async {
    await 2.delay();
    Get.toNamed(Routes.AUTH);
  }
}
