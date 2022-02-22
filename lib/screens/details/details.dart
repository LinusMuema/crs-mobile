import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crs/components/dilaog.dart';
import 'package:crs/components/loaders.dart';
import 'package:crs/screens/details/details.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Details extends GetView<DetailsController> {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var owned = controller.owned.value;
      var vehicle = controller.vehicle.value!;

      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      aspectRatio: Get.height * .0015,
                    ),
                    items: vehicle.images.map((e) {
                      return CachedNetworkImage(
                        imageUrl: e,
                        width: Get.width,
                        fit: BoxFit.cover,
                        placeholder: (c, i) => threeBounce(color: black),
                      );
                    }).toList(),
                  ),
                  verticalSpaceTiny,
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: regularHInsets,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(vehicle.getName()!, style: heading1),
                                !controller.owned.value
                                    ? Text('Ksh ${vehicle.rate}/hr',
                                        style: heading4)
                                    : GestureDetector(
                                        onTap: controller.editVehicle,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: Get.width * .2,
                                          padding: smallVInsets,
                                          decoration: const BoxDecoration(
                                            color: black,
                                            borderRadius: fullRadius,
                                          ),
                                          child: Text('Edit', style: body2),
                                        ),
                                      ),
                              ],
                            ),
                            verticalSpaceTiny,
                            Row(
                              children: [
                                Text(vehicle.plate, style: body1),
                                horizontalSpaceTiny,
                                Text('•', style: body1),
                                horizontalSpaceTiny,
                                Text(vehicle.color, style: body1)
                              ],
                            ),
                            verticalSpaceSmall,
                            !controller.owned.value
                                ? Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: fullRadius,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: Get.width * .15,
                                          imageUrl: vehicle.user.avatar,
                                          placeholder: (c, i) =>
                                              pulse(color: black),
                                        ),
                                      ),
                                      horizontalSpaceSmall,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(vehicle.user.username,
                                              style: body1),
                                          Text(vehicle.user.phone, style: body1)
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            verticalSpaceSmall,
                            Text(vehicle.description, style: body1),
                            verticalSpaceLarge,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            !owned
                ? controller.request.value == null
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: smallInsets,
                          child: ElevatedButton(
                            onPressed: () => fadeInDialog(dialog()),
                            child: Text('request', style: body2),
                          ),
                        ),
                      )
                    : Container()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: smallInsets,
                      child: ElevatedButton(
                        onPressed: () => fadeInDialog(dialog()),
                        child: Text(
                          vehicle.available ? 'unlist vehicle' : 'list vehicle',
                          style: body2,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      );
    });
  }

  Widget dialog() {
    var available = controller.vehicle.value!.available;
    return Dialog(
      insetPadding: regularInsets,
      shape: const RoundedRectangleBorder(borderRadius: smallRadius),
      child: controller.owned.isFalse
          ? requestVehicle()
          : !available
              ? listVehicle()
              : unlistVehicle(),
    );
  }

  Widget requestVehicle() {
    var border = getInputBorder(radius: smallRadius);
    var errorBorder = getInputBorder(radius: smallRadius, color: red);

    var required = FormBuilderValidators.required(context);
    var validator = FormBuilderValidators.compose([required]);

    return Obx(() {
      return Padding(
        padding: regularInsets,
        child: FormBuilder(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Request this vehicle', style: heading1),
              verticalSpaceSmall,
              Row(
                children: [
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'from',
                      style: body1,
                      validator: validator,
                      valueTransformer: (DateTime? value) => value.toString(),
                      format: DateFormat('yyyy/mm/dd hh:MM a'),
                      decoration: InputDecoration(
                        labelStyle: body3,
                        labelText: 'From',
                        enabledBorder: border,
                        focusedBorder: border,
                        errorBorder: errorBorder,
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'to',
                      style: body1,
                      validator: validator,
                      format: DateFormat('yyyy/mm/dd hh:MM a'),
                      valueTransformer: (DateTime? value) => value.toString(),
                      decoration: InputDecoration(
                        labelStyle: body3,
                        labelText: 'To',
                        enabledBorder: border,
                        focusedBorder: border,
                        errorBorder: errorBorder,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpaceSmall,
              FormBuilderTextField(
                style: body1,
                name: 'message',
                validator: validator,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: body3,
                  labelText: 'Reason',
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: errorBorder,
                ),
              ),
              verticalSpaceSmall,
              ElevatedButton(
                onPressed: controller.requestVehicle,
                child: controller.loading.value
                    ? threeBounce()
                    : Text('Submit', style: body2),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget listVehicle() {
    var border = getInputBorder(radius: smallRadius);
    var errorBorder = getInputBorder(radius: smallRadius, color: red);

    var required = FormBuilderValidators.required(context);
    var validator = FormBuilderValidators.compose([required]);

    return Obx(() {
      return Padding(
        padding: regularInsets,
        child: FormBuilder(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('List your vehicle', style: heading1),
              verticalSpaceSmall,
              Row(
                children: [
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'from',
                      style: body1,
                      validator: validator,
                      valueTransformer: (DateTime? value) => value.toString(),
                      format: DateFormat('yyyy/mm/dd hh:MM a'),
                      decoration: InputDecoration(
                        labelStyle: body3,
                        labelText: 'From',
                        enabledBorder: border,
                        focusedBorder: border,
                        errorBorder: errorBorder,
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'to',
                      style: body1,
                      validator: validator,
                      format: DateFormat('yyyy/mm/dd hh:MM a'),
                      valueTransformer: (DateTime? value) => value.toString(),
                      decoration: InputDecoration(
                        labelStyle: body3,
                        labelText: 'To',
                        enabledBorder: border,
                        focusedBorder: border,
                        errorBorder: errorBorder,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpaceSmall,
              FormBuilderTextField(
                style: body1,
                name: 'rate',
                validator: validator,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: 'KSH ',
                  labelStyle: body3,
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: errorBorder,
                  labelText: 'Rate per hour',
                  prefixStyle: caption.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              verticalSpaceSmall,
              ElevatedButton(
                onPressed: controller.listVehicle,
                child: controller.loading.value
                    ? threeBounce()
                    : Text('Submit', style: body2),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget unlistVehicle() {
    var unlist = controller.canUnlist();

    return Obx(() {
      return Container(
        width: Get.width,
        padding: regularInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Unlist your vehicle', style: heading1),
            verticalSpaceSmall,
            Text(
              unlist
                  ? "Do you wish to unlist your vehicle? \nThis means your vehicle won't be visible to other clients."
                  : "You can't unlist a vehicle while a request is ongoing. \nPlease decline the request or if you've already given out your vehicle, contact the client for them to return it.",
              style: body1,
              textAlign: TextAlign.center,
            ),
            verticalSpaceSmall,
            unlist
                ? ElevatedButton(
                    onPressed: controller.unlistVehicle,
                    child: controller.loading.value
                        ? threeBounce()
                        : Text('Unlist', style: body2),
                  )
                : Container()
          ],
        ),
      );
    });
  }
}
