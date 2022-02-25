import 'package:cached_network_image/cached_network_image.dart';
import 'package:crs/components/loaders.dart';
import 'package:crs/screens/details/details.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Requests extends GetWidget<DetailsController> {
  const Requests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Requests', style: heading1),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.requests.length,
            itemBuilder: (context, index) {
              var request = controller.requests[index];
              return Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(request.client.username, style: body1),
                                    Text(request.client.phone, style: body1),
                                  ],
                                ),
                                horizontalSpaceTiny,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Renting from:', style: body1),
                                    Text(request.getRange(), style: body1)
                                  ],
                                ),
                              ],
                            ),
                            verticalSpaceTiny,
                            Text(
                              request.message,
                              style: caption1.copyWith(
                                  fontStyle: FontStyle.italic,),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceTiny,
                  request.status == 'pending' ? pending() : Container()
                ],
              );
            },
          ),
        ],
      );
    });
  }

  Widget pending() {
    var redBox = const BoxDecoration(color: red, borderRadius: fullRadius);
    var greenBox = const BoxDecoration(color: green, borderRadius: fullRadius);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
        horizontalSpaceSmall,
        Container(
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
      ],
    );
  }
}
