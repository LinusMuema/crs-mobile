import 'dart:typed_data';

import 'package:crs/screens/vehicle/vehicle.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class Vehicle extends GetView<VehicleController> {
  const Vehicle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border = getInputBorder(radius: smallRadius);
    var errorBorder = getInputBorder(radius: smallRadius, color: red);

    var required = FormBuilderValidators.required(context);
    var validator = FormBuilderValidators.compose([required]);

    return Obx(() {
      var images = [upload()];
      for (var e in controller.images) {
        images.add(image(e));
      }

      return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    style: body1,
                    name: 'plate',
                    validator: validator,
                    decoration: InputDecoration(
                      labelStyle: body3,
                      labelText: 'Number plate',
                      enabledBorder: border,
                      focusedBorder: border,
                      errorBorder: errorBorder,
                    ),
                  ),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      Expanded(
                        child: TypeAheadFormField(
                          validator: validator,
                          onSuggestionSelected: controller.setSuggestion,
                          suggestionsCallback: controller.getSuggestions,
                          itemBuilder: (context, String value) {
                            return ListTile(title: Text(value, style: body1));
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            style: body1,
                            controller: controller.textController,
                            decoration: InputDecoration(
                              labelStyle: body3,
                              labelText: 'Make',
                              enabledBorder: border,
                              focusedBorder: border,
                              errorBorder: errorBorder,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: FormBuilderTextField(
                          style: body1,
                          name: 'model',
                          validator: validator,
                          decoration: InputDecoration(
                            labelStyle: body3,
                            labelText: 'Model',
                            enabledBorder: border,
                            focusedBorder: border,
                            errorBorder: errorBorder,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceTiny,
                  FormBuilderTextField(
                    style: body1,
                    name: 'color',
                    validator: validator,
                    decoration: InputDecoration(
                      labelStyle: body3,
                      labelText: 'Color',
                      enabledBorder: border,
                      focusedBorder: border,
                      errorBorder: errorBorder,
                    ),
                  ),
                  verticalSpaceTiny,
                  FormBuilderTextField(
                    maxLines: 5,
                    style: body1,
                    name: 'plate',
                    validator: validator,
                    decoration: InputDecoration(
                      labelStyle: body3,
                      labelText: 'Description',
                      enabledBorder: border,
                      focusedBorder: border,
                      errorBorder: errorBorder,
                    ),
                  ),
                  verticalSpaceSmall,
                  ElevatedButton(
                    onPressed: controller.submit,
                    child: Text('submit', style: body2),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget image(Uint8List bytes) {
    return Container(
      margin: smallHInsets,
      width: Get.width * .2,
      height: Get.width * .2,
      child: ClipRRect(
        borderRadius: fullRadius,
        child: Image.memory(bytes, fit: BoxFit.cover),
      ),
    );
  }

  Widget upload() {
    return GestureDetector(
      onTap: controller.pickImage,
      child: Container(
        margin: smallHInsets,
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
