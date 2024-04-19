import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/peminjaman/response_history_peminjaman.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class HistorypeminjamanController extends GetxController with StateMixin{

  var historyPeminjaman = RxList<DataHistory>();
  String idUser = StorageProvider.read(StorageKey.idUser);

  // Post Ulasan
  double ratingBuku= 0;
  final loadingUlasan = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController ulasanController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getDataPeminjaman();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataPeminjaman() async {
    change(null, status: RxStatus.loading());

    try {
      final responseHistoryPeminjaman = await ApiProvider.instance().get(
          '${Endpoint.pinjamBuku}/$idUser');

      if (responseHistoryPeminjaman.statusCode == 200) {
        final ResponseHistoryPeminjaman responseHistory = ResponseHistoryPeminjaman.fromJson(responseHistoryPeminjaman.data);

        if (responseHistory.data!.isEmpty) {
          historyPeminjaman.clear();
          change(null, status: RxStatus.empty());
        } else {
          historyPeminjaman.assignAll(responseHistory.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  // View Post Ulasan Buku
  Future<void> kontenBeriUlasan(String idBuku, String NamaBuku) async{
    const Color textColor = Color(0xFF000AFF);
    const Color backgroundInput = Color(0xFFEFEFEF);
    const Color colorBorder = Color(0xFFC6D3E3);

    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: GoogleFonts.abhayaLibre(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: const Color(0xFFC6D3E3),
          ),
          backgroundColor: const Color(0xFFC6D3E3),
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xFF271C68),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Form Ulasan Buku',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.abhayaLibre(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Form(
                key: formKey,
                child: ListBody(
                  children: <Widget>[

                    Text(
                      'Rating Buku',
                      style: GoogleFonts.abhayaLibre(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    RatingBar.builder(
                      allowHalfRating: false,
                      itemCount: 5,
                      minRating: 1,
                      initialRating: 5,
                      direction: Axis.horizontal,
                      itemSize: 50,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {
                        ratingBuku = value;
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      'Ulasan Buku',
                      style: GoogleFonts.abhayaLibre(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: ulasanController,
                      style: GoogleFonts.abhayaLibre(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                      maxLines: 5,
                      decoration: InputDecoration(
                          fillColor: backgroundInput,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: textColor.withOpacity(0.90),
                              ),
                              borderRadius: BorderRadius.circular(5.5)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorBorder.withOpacity(0.90),
                              ),
                              borderRadius: BorderRadius.circular(5.5)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: textColor.withOpacity(0.90),
                              ),
                              borderRadius: BorderRadius.circular(5.5)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorBorder.withOpacity(0.90),
                              ),
                              borderRadius: BorderRadius.circular(5.5)),
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                          hintText: 'Ulasan Buku...........',
                          hintStyle: GoogleFonts.abhayaLibre(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          )
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pleasse input ulasan buku';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(Get.context!).size.width,
                  height: 40,
                  child: TextButton(
                    autofocus: true,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF271C68),
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    onPressed: (){
                      postUlasanBuku(idBuku, NamaBuku);
                      Navigator.of(Get.context!).pop();
                    },
                    child: Text(
                      'Simpan Ulasan Buku',
                      style: GoogleFonts.abhayaLibre(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  postUlasanBuku(String buku, String namaBuku) async {
    loadingUlasan(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        int ratingBukuInt = ratingBuku.round();
        final response = await ApiProvider.instance().post(Endpoint.ulasanBuku,
            data: dio.FormData.fromMap(
                {
                  "Rating": ratingBukuInt,
                  "BukuID": buku,
                  "Ulasan": ulasanController.text.toString()
                }
            )
        );
        if (response.statusCode == 201) {
          _showMyDialog(
                  (){
                Navigator.of(Get.context!).pop();
              },
              "Ulasan Buku $namaBuku berhasil di simpan",
            "Oke",
            QuickAlertType.success,);
          ulasanController.text = '';

        } else {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Ulasan Gagal disimpan, Silakan coba kembali",
            "Oke",
            QuickAlertType.error,
          );
        }
      }
      loadingUlasan(false);
    } on dio.DioException catch (e) {
      loadingUlasan(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "${e.response?.data['Message']}",
            "Oke",
            QuickAlertType.warning,
          );
        }
      } else {
        _showMyDialog(
              (){
            Navigator.pop(Get.context!, 'OK');
          },
          e.message ?? "",
          "Oke",
          QuickAlertType.warning,
        );
      }
    } catch (e) {
      loadingUlasan(false);
      _showMyDialog(
            (){
          Navigator.pop(Get.context!, 'OK');
        },
        e.toString(),
        "Error",
        QuickAlertType.error,
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
