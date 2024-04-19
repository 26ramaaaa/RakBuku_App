import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class DashboardController extends GetxController {

  HomeController home_controller = Get.put(HomeController(), permanent:true);

  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
