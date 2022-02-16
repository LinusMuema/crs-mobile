import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraService extends GetxService {
  late ImagePicker picker;

  Future<CameraService> init() async {
    picker = ImagePicker();
    return this;
  }

  Future<Uint8List?>? getImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    return image?.readAsBytes();
  }
}
