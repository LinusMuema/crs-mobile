import 'package:crs/screens/transactions/transactions.controller.dart';
import 'package:get/get.dart';

class TransactionsBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => TransactionsController());
}
