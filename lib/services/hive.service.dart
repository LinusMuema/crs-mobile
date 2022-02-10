import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService extends GetxService {
  late Box box;

  Future<HiveService> init() async {
    // TODO: register adapters

    // Initialise hive and open box
    await Hive.initFlutter();
    box = await Hive.openBox('crs_box');
    return this;
  }

  dynamic get(String key) => box.get(key);
  void set(String key, dynamic value) => box.put(key, value);
}
