import 'dart:typed_data';

import 'package:crs/screens/vehicle/vehicle.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class Vehicle extends GetView<VehicleController> {
  const Vehicle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border = getInputBorder(radius: smallRadius);

    return Obx(() {
      var images = [upload()];
      for (var e in controller.images) {
        images.add(image(e));
      }

      return Scaffold(
        body: FormBuilder(
          key: controller.formKey,
          child: SafeArea(
            child: Padding(
              padding: regularInsets,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceRegular,
                  Text(
                    'Add a vehicle',
                    style: heading1.copyWith(fontSize: 20),
                  ),
                  verticalSpaceSmall,
                  Row(
                    children: images,
                  ),
                  verticalSpaceSmall,
                  FormBuilderTextField(
                    name: 'plate',
                    decoration: InputDecoration(
                      labelStyle: body3,
                      labelText: 'Number plate',
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown(
                          name: 'make',
                          decoration: InputDecoration(
                            labelStyle: body3,
                            labelText: 'Make',
                            enabledBorder: border,
                            focusedBorder: border,
                          ),
                          items: controller.makes
                              .map((e) => DropdownMenuItem(
                                  value: e.toLowerCase(),
                                  child: Text(e, style: body1)))
                              .toList(),
                        ),
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'model',
                          decoration: InputDecoration(
                            labelStyle: body3,
                            labelText: 'Model',
                            enabledBorder: border,
                            focusedBorder: border,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceTiny,
                  FormBuilderTextField(
                    name: 'color',
                    decoration: InputDecoration(
                      labelStyle: body3,
                      labelText: 'Color',
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                  verticalSpaceTiny,
                  FormBuilderTextField(
                    name: 'plate',
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelStyle: body3,
                      labelText: 'Description',
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget image(Uint8List bytes) {
    return SizedBox(
      width: Get.width * .2,
      height: Get.width * .2,
      child: ClipRRect(
        borderRadius: fullRadius,
        child: Image.memory(bytes),
      ),
    );
  }

  Widget upload() {
    return GestureDetector(
      onTap: controller.pickImage,
      child: Container(
        width: Get.width * .2,
        height: Get.width * .2,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: grey,
          borderRadius: fullRadius,
        ),
        child: const Icon(Icons.add, color: white),
      ),
    );
  }
}
