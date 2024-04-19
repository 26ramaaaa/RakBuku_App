import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramadhan_rakbuku/app/data/model/buku/response_book.dart';
import 'package:ramadhan_rakbuku/app/data/model/response_kategori.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_search_book.dart';
import '../../../data/provider/api_provider.dart';

class SearchbukuController extends GetxController with StateMixin{

  final TextEditingController searchController = TextEditingController();

  var dataAllBook = RxList<DataBook>();
  var dataKategori = RxList<DataKategori>();
  var searchBook = RxList<DataSearch>();

  @override
  void onInit() {
    super.onInit();
    getDataBook();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get Data Buku
  Future<void> getDataBook() async{
    dataAllBook.clear();
    change(null, status: RxStatus.loading());

    try {

      final response = await ApiProvider.instance().get(Endpoint.buku);
      final responseKategori = await ApiProvider.instance().get(Endpoint.kategori);
      if (response.statusCode == 200 && responseKategori.statusCode == 200) {
        final ResponseBook responseBuku = ResponseBook.fromJson(response.data);
        final ResponseKategori responseBukuKategori = ResponseKategori.fromJson(responseKategori.data);
        if(responseBuku.data!.isEmpty){
          change(null, status: RxStatus.empty());
        }else{
          dataAllBook(responseBuku.data!);
          dataKategori(responseBukuKategori.data!);
          change(responseBuku.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }

    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getDataSearchBook(String keyword) async {
    try {
      change(null, status: RxStatus.loading());

      final response = await ApiProvider.instance().get('${Endpoint.searchBuku}?keyword=$keyword');

      if (response.statusCode == 200) {
        final responseData = ResponseSearchBook.fromJson(response.data);

        if (responseData.data!.isEmpty) {
          searchBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          searchBook.assignAll(responseData.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioError catch (e) {
      handleError(e);
    } catch (e) {
      handleError(e);
    }
  }

  void handleError(dynamic e) {
    if (e is DioError) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } else {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
