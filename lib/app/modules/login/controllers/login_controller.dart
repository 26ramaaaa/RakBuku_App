import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/user/response_login.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {

  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  login() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data: dio.FormData.fromMap(
                {
                  "email": emailController.text.toString(),
                  "password": passwordController.text.toString()
                }
            )
        );
        if (response.statusCode == 200) {
          ResponseLogin responseLogin = ResponseLogin.fromJson(response.data);
          await StorageProvider.write(StorageKey.status, "logged");
          await StorageProvider.write(StorageKey.username, responseLogin.data!.username.toString());
          await StorageProvider.write(StorageKey.tokenUser, responseLogin.data!.token.toString());
          await StorageProvider.write(StorageKey.idUser, responseLogin.data!.id.toString());
          await StorageProvider.write(StorageKey.email, responseLogin.data!.email.toString());
          await StorageProvider.write(StorageKey.bio, responseLogin.data!.bio.toString());
          await StorageProvider.write(StorageKey.namaLengkap, responseLogin.data!.namaLengkap.toString());
          await StorageProvider.write(StorageKey.telepon, responseLogin.data!.telepon.toString());

          String username =  StorageProvider.read(StorageKey.username);

          _showMyDialog(
                  (){
                Get.offAllNamed(Routes.DASHBOARD);
              },
              "Login Berhasil \n Selamat Datang Kembali $username",
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
    } on dio.DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "${e.response?.data['message']}",
              "Oke",
              QuickAlertType.error
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
          e.toString(),
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
