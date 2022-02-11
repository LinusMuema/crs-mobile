import 'package:crs/screens/navigation/navigation.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Navigation extends GetView<NavigationController> {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var index = controller.selected.value;
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: index,
          selectedFontSize: 12,
          showSelectedLabels: true,
          selectedItemColor: black,
          onTap: controller.navigate,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: controller.screens.map((e) {
            var icon = e.toLowerCase();
            var selected = index == controller.screens.indexOf(e);
            return BottomNavigationBarItem(
              label: e,
              icon: Padding(
                padding: smallInsets,
                child: SvgPicture.asset(
                  'assets/images/$icon.svg',
                  width: Get.width * .05,
                  color: selected ? black : grey,
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
