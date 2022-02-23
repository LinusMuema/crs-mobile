import 'package:cached_network_image/cached_network_image.dart';
import 'package:crs/components/loaders.dart';
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
      for (var e in controller.urls) {
        var index = controller.urls.indexOf(e);
        images.add(image(index));
      }

      // If we're from edit, set the initial values
      var vehicle = controller.vehicle.value;
      var plate = "", model = "", color = "", description = "";
      if (vehicle != null) {
        plate = vehicle.plate;
        color = vehicle.color;
        model = vehicle.model;
        description = vehicle.description;
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
                    initialValue: plate,
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
                          initialValue: model,
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
                    initialValue: color,
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
                    name: 'description',
                    validator: validator,
                    initialValue: description,
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
                    child: controller.loading.value
                        ? threeBounce()
                        : Text('submit', style: body2),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget image(int index) {
    var loading = controller.uploading[index];
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          'Delete',
          'Are you sure you want to remove this image?',
          backgroundColor: white,
          duration: const Duration(seconds: 5),
          mainButton: TextButton(
            onPressed: () => controller.removeImage(index),
            child: Text('Delete', style: body5),
          ),
        );
      },
      child: Container(
        margin: smallHInsets,
        width: Get.width * .2,
        height: Get.width * .2,
        child: ClipRRect(
          borderRadius: fullRadius,
          child: Stack(
            children: [
              !loading
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (c, i) => pulse(color: black),
                      imageUrl: controller.urls[index],
                    )
                  : Container(
                      color: white.withOpacity(.7),
                      child: pulse(color: black),
                    )
            ],
          ),
        ),
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
