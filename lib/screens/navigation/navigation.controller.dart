import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt selected = 0.obs;
  List<String> screens = ['Discover', 'Transactions', 'Garage', 'Profile'];

  void navigate(int index) => selected.value = index;
}
