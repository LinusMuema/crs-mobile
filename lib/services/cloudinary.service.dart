import 'dart:typed_data';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:crs/utils/secrets.dart';
import 'package:get/get.dart';

class CloudinaryService extends GetxService {
  late Cloudinary cloud;

  String name = 'dnp5ccl7d';
  String apiKey = Secrets.CLOUDINARY_API;
  String apiSecret = Secrets.CLOUDINARY_SECRET;

  Future<CloudinaryService> init() async {
    cloud = Cloudinary(apiKey, apiSecret, name);
    return this;
  }

  uploadImage(Uint8List bytes, String path, String name) async {
    return cloud.uploadFile(folder: path, fileName: name, fileBytes: bytes);
  }

  deleteImage(String url) async {
    return cloud.deleteFile(url: url, invalidate: true);
  }
}
