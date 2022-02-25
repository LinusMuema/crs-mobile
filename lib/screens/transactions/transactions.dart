import 'package:cached_network_image/cached_network_image.dart';
import 'package:crs/components/loaders.dart';
import 'package:crs/models/request.model.dart';
import 'package:crs/screens/transactions/transactions.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transactions extends GetView<TransactionsController> {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: regularHInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceRegular,
              Text('My Transactions', style: heading1.copyWith(fontSize: 20)),
              verticalSpaceSmall,
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.requests.length,
                itemBuilder: (context, index) {
                  var request = controller.requests[index];
                  return card(request);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget card(Request request) {
    var cost = request.getCost();
    var vehicle = request.vehicle;
    var style = request.status == 'rejected' ? heading5 : heading4;
    var greenBox = const BoxDecoration(color: green, borderRadius: fullRadius);

    return Obx(() {
      return Container(
        margin: regularVInsets,
        height: Get.width * .2,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: smallRadius,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: Get.width * .2,
                imageUrl: vehicle.images.first,
                placeholder: (c, i) => pulse(color: black),
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(vehicle.getName()!, style: heading1),
                          Row(
                            children: [
                              Text(vehicle.plate, style: body1),
                              horizontalSpaceTiny,
                              Text('•', style: body1),
                              horizontalSpaceTiny,
                              Text(vehicle.color, style: body1)
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Renting from:', style: heading1),
                          Text(request.getRange(), style: body1)
                        ],
                      )
                    ],
                  ),
                  verticalSpaceTiny,
                  controller.loading.value
                      ? threeBounce(color: black)
                      : request.status == 'accepted'
                          ? GestureDetector(
                              onTap: () => controller.collectVehicle(request),
                              child: Container(
                                decoration: greenBox,
                                width: Get.width * .3,
                                padding: smallVInsets,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(Icons.done,
                                        color: white, size: 18),
                                    Text('Collect', style: body2),
                                    horizontalSpaceTiny,
                                  ],
                                ),
                              ),
                            )
                          : request.status == 'collected'
                              ? Text('Ksh. $cost', style: heading4)
                              : Text(request.status, style: style)
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
