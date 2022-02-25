import 'package:cached_network_image/cached_network_image.dart';
import 'package:crs/screens/profile/profile.controller.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../components/loaders.dart';
import '../../theme/colors.dart';

class Profile extends GetView<ProfileController> {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Profile",
                    style: heading1.copyWith(
                      fontSize: 25,
                    )),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Logout",
                      style: heading1.copyWith(fontSize: 20),
                    ))
              ],
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: 70.0,
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: controller.getUser().avatar,
                  width: Get.width,
                  fit: BoxFit.cover,
                  placeholder: (c, i) => threeBounce(color: black),
                ),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              "Peter Kayere",
              style: heading1.copyWith(fontSize: 25),
            ),
          ),
          Text(
            "peter.m.kayere@gmail.com",
            style: heading3.copyWith(fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "0797954425",
              style: heading3.copyWith(fontSize: 15),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            width: Get.width,
            child: FormBuilder(
              child: Column(
                children: [
                  userDetails('Username', 'Peter Kayere'),
                  const SizedBox(
                    height: 10,
                  ),
                  userDetails('Email', 'peter.m.kayere@gmail.com'),
                  const SizedBox(
                    height: 10,
                  ),
                  userDetails('Phone', '0797954425')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget userDetails(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: heading1.copyWith(fontSize: 20),
          ),
        ),
        SizedBox(
          width: Get.width,
          height: 50,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    body,
                    style: heading3.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
