import 'package:crs/screens/auth/widgets/login.widget.dart';
import 'package:crs/screens/auth/widgets/signup.widget.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final HiveService hiveService = Get.find();
  final NetworkService networkService = Get.find();

  final GlobalKey<FormBuilderState> loginKey = GlobalKey();
  final GlobalKey<FormBuilderState> signupKey = GlobalKey();

  RxInt page = 0.obs;
  RxBool hidden = true.obs;
  RxBool loading = false.obs;
  List<Widget> screens = [const Login(), const Signup()];

  void changePage(int index) => page.value = index;

  void login() async {
    if (loginKey.currentState!.validate()) {
      String endpoint = 'api/auth/login';
      dynamic data = loginKey.currentState!.value;

      loading.value = true;
      Response response = await networkService.post(endpoint, data);
      loading.value = false;

      if (response.isOk) {
      } else {}
    }
  }

  void signup() async {
    // TODO: implement the logic
  }
}
