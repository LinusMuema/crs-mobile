import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget verticalSpaceTiny = SizedBox(height: Get.height * .01);
Widget verticalSpaceSmall = SizedBox(height: Get.height * .025);
Widget verticalSpaceRegular = SizedBox(height: Get.height * .05);
Widget verticalSpaceLarge = SizedBox(height: Get.height * .075);
Widget verticalSpaceMassive = SizedBox(height: Get.height * .1);

Widget horizontalSpaceTiny = SizedBox(width: Get.width * .01);
Widget horizontalSpaceSmall = SizedBox(width: Get.width * .025);
Widget horizontalSpaceRegular = SizedBox(width: Get.width * .05);
Widget horizontalSpaceLarge = SizedBox(width: Get.width * .075);
Widget horizontalSpaceMassive = SizedBox(width: Get.width * .1);

const BorderRadius tinyRadius = BorderRadius.all(Radius.circular(5));
const BorderRadius smallRadius = BorderRadius.all(Radius.circular(10));
const BorderRadius regularRadius = BorderRadius.all(Radius.circular(15));
const BorderRadius mediumRadius = BorderRadius.all(Radius.circular(20));
const BorderRadius fullRadius = BorderRadius.all(Radius.circular(50));

OutlineInputBorder getInputBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: fullRadius,
    borderSide: BorderSide(color: color),
  );
}

//Padding
const smallInsets = EdgeInsets.all(5);
const smallVInsets = EdgeInsets.symmetric(vertical: 5);
const smallHInsets = EdgeInsets.symmetric(horizontal: 5);

const regularInsets = EdgeInsets.all(10);
const regularVInsets = EdgeInsets.symmetric(vertical: 10);
const regularHInsets = EdgeInsets.symmetric(horizontal: 10);

const mediumInsets = EdgeInsets.all(15);
const mediumVInsets = EdgeInsets.symmetric(vertical: 15);
const mediumHInsets = EdgeInsets.symmetric(horizontal: 15);

const largeInsets = EdgeInsets.all(20);
const largeVInsets = EdgeInsets.symmetric(vertical: 20);
const largeHInsets = EdgeInsets.symmetric(horizontal: 20);
