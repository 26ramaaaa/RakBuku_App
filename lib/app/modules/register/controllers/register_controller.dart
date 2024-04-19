import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {

  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

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

  registerPost() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.register,
            data:
                {
                  "username": usernameController.text.toString(),
                  "email": emailController.text.toString(),
                  "password": passwordController.text.toString()
                }
        );
        if (response.statusCode == 201) {
          _showMyDialog(
                  (){
                Get.offAllNamed(Routes.LOGIN);
              },
              "Registrasi Berhasil \n Silakan Login Terlebih Dahulu",
              "Lanjut",
              QuickAlertType.success
          );
        } else {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Login Gagal, Coba kembali masuk dengan akun anda",
              "Oke",
              QuickAlertType.error
          );
        }
      }
      loadinglogin(false);
    } on DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "${e.response?.data['Message']}",
              "Oke",
              QuickAlertType.warning
          );
        }
      } else {
        _showMyDialog(
                (){
              Navigator.pop(Get.context!, 'OK');
            },
            e.message ?? "",
            "Oke",
            QuickAlertType.error
        );
      }
    } catch (e) {
      loadinglogin(false);
      _showMyDialog(
              (){
            Navigator.pop(Get.context!, 'OK');
          },
          e.toString() ?? "",
          "Oke",
          QuickAlertType.error
      );
    }
  }

  Future<void> _showMyDialog(final onTap, String deskripsi, String nameButton, QuickAlertType type) async {
    return QuickAlert.show(
      context: Get.context!,
      type: type,
      text: deskripsi,
      confirmBtnText: nameButton,
      confirmBtnTextStyle: const TextStyle(color: Colors.black),
      confirmBtnColor: const Color(0xFFC6D3E3),
      onConfirmBtnTap: onTap,
      title: 'RakBuku App',
      animType: QuickAlertAnimType.scale,
      textColor: Colors.black,
      titleColor: Colors.black,
      barrierDismissible: true,
    );
  }
}
