import 'package:crs/components/snackbars.dart';
import 'package:crs/models/user.model.dart';
import 'package:crs/routes/routes.dart';
import 'package:crs/screens/auth/widgets/login.widget.dart';
import 'package:crs/screens/auth/widgets/signup.widget.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final HiveService hiveService = Get.find();
  final NetworkService networkService = Get.find();

  final GlobalKey<FormBuilderState> loginKey = GlobalKey();
  final GlobalKey<FormBuilderState> signupKey = GlobalKey();

  RxInt page = 0.obs;
  RxBool loading = false.obs;
  RxBool confirmHidden = true.obs;
  RxBool passwordHidden = true.obs;
  List<Widget> screens = [const Login(), const Signup()];

  void changePage(int index) => page.value = index;

  void login() async {
    if (loginKey.currentState!.validate()) {
      loginKey.currentState!.save();
      String endpoint = 'api/auth/login';
      dynamic data = loginKey.currentState!.value;

      loading.value = true;
      Response response = await networkService.post(endpoint, data);
      loading.value = false;

      if (response.isOk) {
        // save the web token
        String token = response.body['token'];
        hiveService.set(Constants.TOKEN, token);

        // save the user profile
        User user = User.fromJson(response.body['user']);
        hiveService.set(Constants.USER, user);

        // navigate to home
        Get.offAllNamed(Routes.NAV);
      } else {
        String message = response.body['message'];
        snackBar('Error', message);
      }
    }
  }

  void signup() async {
    if (signupKey.currentState!.validate()) {
      signupKey.currentState!.save();
      String endpoint = 'api/auth/login';
      dynamic data = signupKey.currentState!.value;

      if (data['password'] != data['confirm']) {
        snackBar('Signup', 'Passwords do not match');
        return;
      }

      loading.value = true;
      Response response = await networkService.post(endpoint, data);
      loading.value = false;

      if (response.isOk) {
        // save the web token
        String token = response.body['token'];
        hiveService.set(Constants.TOKEN, token);

        // save the user profile
        User user = User.fromJson(response.body['user']);
        hiveService.set(Constants.USER, user);

        // navigate to home
        Get.offAllNamed(Routes.NAV);
      } else {
        String message = response.body['message'];
        snackBar('Error', message);
      }
    }
  }
}
