import 'package:crs/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    borderRadius: 10,
    colorText: black,
    backgroundColor: white,
    snackPosition: SnackPosition.BOTTOM,
    boxShadows: [const BoxShadow(color: grey)],
  );
}
