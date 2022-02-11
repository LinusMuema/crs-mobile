import 'package:crs/screens/discover/discover.dart';
import 'package:crs/screens/garage/garage.dart';
import 'package:crs/screens/profile/profile.dart';
import 'package:crs/screens/transactions/transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt selected = 0.obs;
  List<String> titles = ['Discover', 'Transactions', 'Garage', 'Profile'];
  List<Widget> screens = [
    const Discover(),
    const Transactions(),
    const Garage(),
    const Profile()
  ];

  void navigate(int index) => selected.value = index;
}
