import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ramadhan_rakbuku/app/modules/bookmark/views/bookmark_view.dart';
import 'package:ramadhan_rakbuku/app/modules/historypeminjaman/views/historypeminjaman_view.dart';
import 'package:ramadhan_rakbuku/app/modules/searchbuku/views/searchbuku_view.dart';

import '../../../components/customBarMaterial.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(

              body: SafeArea(
                child: SafeArea(
                  child: Center(
                      child: IndexedStack(
                        index: controller.tabIndex,
                        children: [
                          HomeView(),
                          SearchbukuView(),
                          BookmarkView(),
                          HistorypeminjamanView(),
                          ProfileView(),
                        ],
                      )
                  ),
                ),
              ),
              bottomNavigationBar: CustomBottomBarMaterial(
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex,
              )
          );
        }
    );
  }
}
