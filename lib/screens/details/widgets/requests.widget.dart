import 'package:cached_network_image/cached_network_image.dart';
import 'package:crs/components/loaders.dart';
import 'package:crs/models/request.model.dart';
import 'package:crs/screens/details/details.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Requests extends GetWidget<DetailsController> {
  const Requests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Requests', style: heading1),
          verticalSpaceTiny,
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.requests.length,
            itemBuilder: (context, index) {
              var request = controller.requests[index];
              var format = DateFormat("yyyy-mm-dd hh:MM a");

              var date = format.format(request.to);
              // format the date like this: "Mon 24th, 20:00"
              var dateFormatted = DateFormat.EEEE()
                  .add_d()
                  .add_jm()
                  .format(request.to);

              var to = format.format(request.to);
              var from = format.format(request.from);
              return Padding(
                padding: regularVInsets,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: fullRadius,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: Get.width * .15,
                            imageUrl: request.client.avatar,
                            placeholder: (c, i) => pulse(color: black),
                          ),
                        ),
                        horizontalSpaceRegular,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(request.client.username,
                                          style: body1),
                                      Text(request.client.phone, style: body1),
                                    ],
                                  ),
                                  horizontalSpaceTiny,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('From: $dateFormatted', style: body1),
                                      Text('To: $to', style: body1)
                                    ],
                                  ),
                                ],
                              ),
                              verticalSpaceTiny,
                              Text(
                                request.message,
                                style: caption1.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceTiny,
                    request.status == 'pending'
                        ? pending(request)
                        : request.status == 'collected'
                            ? collected(request)
                            : status(request),
                  ],
                ),
              );
            },
          ),
        ],
      );
    });
  }

  Widget pending(Request request) {
    var redBox = const BoxDecoration(color: red, borderRadius: fullRadius);
    var greenBox = const BoxDecoration(color: green, borderRadius: fullRadius);
    return Obx(() {
      return controller.loading.value
          ? threeBounce(color: black)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => controller.acceptRequest(request),
                  child: Container(
                    decoration: greenBox,
                    width: Get.width * .3,
                    padding: smallVInsets,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.done, color: white, size: 18),
                        Text('Accept', style: body2),
                        horizontalSpaceTiny,
                      ],
                    ),
                  ),
                ),
                horizontalSpaceSmall,
                GestureDetector(
                  onTap: () => controller.declineRequest(request),
                  child: Container(
                    decoration: redBox,
                    width: Get.width * .3,
                    padding: smallVInsets,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.close, color: white, size: 18),
                        Text('Decline', style: body2),
                        horizontalSpaceTiny,
                      ],
                    ),
                  ),
                ),
              ],
            );
    });
  }

  Widget status(Request request) {
    var text = request.status == 'accepted'
        ? 'Awaiting collection'
        : request.status == 'completed'
            ? 'Earnings : Ksh. ${request.getTotalCost()}'
            : request.status.capitalize;
    var style = request.status == 'rejected' ? heading5 : heading4;
    return Text(text!, style: style);
  }

  Widget collected(Request request) {
    var redBox = const BoxDecoration(color: red, borderRadius: fullRadius);

    return Obx(() {
      return controller.loading.value
          ? threeBounce(color: black)
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                horizontalSpaceSmall,
                Text('Earnings: Ksh ${request.getCost()}', style: body4),
                GestureDetector(
                  onTap: () => controller.endSession(request),
                  child: Container(
                    decoration: redBox,
                    width: Get.width * .3,
                    padding: smallVInsets,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.close, color: white, size: 18),
                        Text('End session', style: body2),
                        horizontalSpaceTiny,
                      ],
                    ),
                  ),
                ),
              ],
            );
    });
  }
}
