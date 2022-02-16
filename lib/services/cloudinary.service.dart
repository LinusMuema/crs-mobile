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

  Future<CloudinaryResponse> uploadImage(bytes, path, name) async {
    return cloud.uploadFile(folder: path, fileName: name, fileBytes: bytes);
  }

  Future<CloudinaryResponse> deleteImage(String url) async {
    return cloud.deleteFile(url: url, invalidate: true);
  }
}
