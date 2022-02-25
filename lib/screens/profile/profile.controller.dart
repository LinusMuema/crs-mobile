import 'package:crs/components/snackbars.dart';
import 'package:crs/models/user.model.dart';
import 'package:crs/routes/routes.dart';
import 'package:crs/services/hive.service.dart';
import 'package:crs/services/network.service.dart';
import 'package:crs/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final HiveService hiveService = Get.find();
  final NetworkService networkService = Get.find();

  final GlobalKey<FormBuilderState> formKey = GlobalKey();

  Rxn<User> user = Rxn();
  RxBool loading = false.obs;

  @override
  void onInit() {
    hiveService.box.watch(key: Constants.USER).listen((data) {
      user.value = data.value;
    });
    super.onInit();
  }

  void logout() {
    hiveService.set(Constants.TOKEN, null);
    hiveService.set(Constants.REQUEST, null);
    Get.offAllNamed(Routes.AUTH);
  }

  void updateProfile() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      dynamic data = formKey.currentState!.value;

      loading.toggle();
      String endpoint = 'api/users';
      Response response = await networkService.put(endpoint, data);

      if (response.isOk) {
        User update = User.fromJson(response.body);
        hiveService.set(Constants.USER, update);
      } else {
        String message = response.body['message'];
        snackBar('Error', message);
      }

      loading.toggle();
    }
  }
}
