import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crs/components/loaders.dart';
import 'package:crs/screens/details/details.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends GetView<DetailsController> {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var vehicle = controller.vehicle.value!;
      return Scaffold(
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
            !controller.owned.value
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: smallInsets,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Request', style: body2),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      );
    });
  }
}
