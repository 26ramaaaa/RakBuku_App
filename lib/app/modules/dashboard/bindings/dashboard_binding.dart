import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadhan_rakbuku/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:ramadhan_rakbuku/app/modules/historypeminjaman/controllers/historypeminjaman_controller.dart';
import 'package:ramadhan_rakbuku/app/modules/home/controllers/home_controller.dart';
import 'package:ramadhan_rakbuku/app/modules/profile/controllers/profile_controller.dart';
import 'package:ramadhan_rakbuku/app/modules/searchbuku/controllers/searchbuku_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<SearchbukuController>(
          () => SearchbukuController(),
    );
    Get.lazyPut<BookmarkController>(
          () => BookmarkController(),
    );
    Get.lazyPut<HistorypeminjamanController>(
          () => HistorypeminjamanController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
