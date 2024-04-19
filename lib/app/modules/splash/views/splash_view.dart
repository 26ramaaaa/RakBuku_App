import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // untuk berpindah halaman otomatis setelah 4 detik
    Future.delayed(const Duration(milliseconds: 4000), (() {
      String? status = StorageProvider.read(StorageKey.status);
      if (status == "logged") {
        Get.offAllNamed(Routes.DASHBOARD);
      }else{
        Get.offAllNamed(Routes.LOGIN);
      }
    }));

    double toolbar = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double bodyHeight = height - toolbar;

    return Scaffold(
      body: SafeArea(
        child: Container(
          // memberikan background color
          color: const Color(0xFFC6D3E3),
          height: bodyHeight,
          child: Center(
            // menggunakan Column untuk menempatkan logo dan CircularProgressIndicator secara vertikal
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // menempatkan logo di tengah-tengah
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                    child: SvgPicture.asset('assets/images/logo_rakbuku.svg'),
                    ),
                  ),
                // menempatkan CircularProgressIndicator di bawah
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
