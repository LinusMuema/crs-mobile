import 'package:crs/models/user.model.dart';
import 'package:crs/utils/constants.dart';
import 'package:get/get.dart';
import 'package:crs/services/hive.service.dart';

class ProfileController extends GetxController {
  final HiveService hiveService = Get.find();

  User getUser() {
    return hiveService.get(Constants.USER);
  }
}
