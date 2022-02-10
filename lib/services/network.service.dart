import 'package:crs/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import 'hive.service.dart';

class NetworkService extends GetConnect {
  late HiveService hiveService;

  Future<NetworkService> init() async {
    await setToken();
    return this;
  }

  Future<void> setToken() async {
    hiveService = Get.find();
    final token = hiveService.get(Constants.TOKEN);

    httpClient.baseUrl = Constants.BASE_URL;
    httpClient.addRequestModifier((Request request) {
      request.headers["Authorization"] = "Bearer $token";
      return request;
    });
  }
}
