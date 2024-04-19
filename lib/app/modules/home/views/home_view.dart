import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadhan_rakbuku/app/data/provider/storage_provider.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{
          await controller.getData();
        },
        child: Container(
          color: const Color(0xFFC6D3E3),
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionUser(
                    "Hallo ${StorageProvider.read(StorageKey.username)}",
                    "Kamu ingin membaca apa hari ini?",
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: sectionCard(
                      "Selamat datang di Perpustakaan Digital kami, tempat di mana setiap 'halaman' adalah pintu menuju dunia pengetahuan yang tak terbatas",
                    ),
                  ),

                  kontenBukuPopular(),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  kontenBukuTerbaru(),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget sectionUser(String judul, String deskripsi){
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const  BorderRadius.only(
            topRight: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/fotoprofile.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(
                width: 20,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    judul,
                    maxLines: 1,
                    maxFontSize: 20,
                  minFontSize: 15,
                    style: GoogleFonts.alegreya(
                      color: const Color(0xFF271C68),
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0
                    ),
                  ),

                  AutoSizeText(
                    deskripsi,
                    maxLines: 1,
                    maxFontSize: 18,
                    minFontSize: 15,
                    style: GoogleFonts.alegreya(
                        color: const Color(0xFF271C68),
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionCard(String deskripsi){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/book.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(
              width: 20,
            ),

            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    height: 80,
                    child: SvgPicture.asset(
                      'assets/images/logo_rakbuku.svg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  SizedBox(
                    width: 250,
                    child: AutoSizeText(
                      deskripsi,
                      maxLines: 4,
                      maxFontSize: 12,
                      minFontSize: 10,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.alegreya(
                          color: const Color(0xFF271C68),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget kontenBukuPopular(){
    const Color textColor = Color(0xFF271C68);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Buku TerPopular",
            maxLines: 1,
            style: GoogleFonts.alegreya(
              fontWeight: FontWeight.w800,
              color: textColor,
              fontSize: 20.0,
            ),
          ),
        ),

        const SizedBox(
          height: 15,
        ),

       Obx(() {
            if (controller.popularBooks.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              );
            } else {
              return SizedBox(
                height: 240,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.popularBooks.length,
                    itemBuilder: (context, index) {
                      var buku = controller.popularBooks[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.DETAILBOOK,
                            parameters: {
                              'id': (buku.bukuID ?? 0).toString(),
                              'judul': (buku.judul!).toString()
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 20 : 0,
                            right: index < controller.popularBooks.length - 1 ? 10 : 20,
                          ),
                          child: Container(
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF3F3F3).withOpacity(0.80),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 140, // Sesuaikan lebar gambar sesuai kebutuhan Anda
                                  height: 175, // Sesuaikan tinggi gambar sesuai kebutuhan Anda
                                  child: AspectRatio(
                                    aspectRatio: 4 / 5,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)
                                      ),
                                      child: Image.network(
                                        buku.coverBuku.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          buku.judul!,
                                          style: GoogleFonts.alegreya(
                                              fontWeight: FontWeight.w800,
                                              color: textColor,
                                              fontSize: 16.0
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),

                                        FittedBox(
                                          child: Text(
                                            "Penulis : ${buku.penulis!}",
                                            maxLines: 1,
                                            style: GoogleFonts.alegreya(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 10.0
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget kontenBukuTerbaru() {
    const Color textColor = Color(0xFF271C68);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Buku Terbaru",
              maxLines: 1,
              style: GoogleFonts.alegreya(
                fontWeight: FontWeight.w800,
                color: textColor,
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() {
              if (controller.newBooks.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                );
              } else {
                return SizedBox(
                  height: 240,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.newBooks.length,
                      itemBuilder: (context, index) {
                        var buku = controller.newBooks[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.DETAILBOOK,
                              parameters: {
                                'id': (buku.bukuID ?? 0).toString(),
                                'judul': (buku.judulBuku!).toString()
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 20 : 0,
                              right: index < controller.newBooks.length - 1 ? 10 : 20,
                            ),
                            child: Container(
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFF3F3F3).withOpacity(0.80),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 140,
                                    height: 175,
                                    child: AspectRatio(
                                      aspectRatio: 4 / 5,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10)
                                        ),
                                        child: Image.network(
                                          buku.coverBuku.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            buku.judulBuku!,
                                            style: GoogleFonts.alegreya(
                                                fontWeight: FontWeight.w800,
                                                color: textColor,
                                                fontSize: 16.0
                                            ),
                                            maxLines:2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),

                                          FittedBox(
                                            child: Text(
                                              "Penulis : ${buku.penulisBuku!}",
                                              maxLines: 1,
                                              style: GoogleFonts.alegreya(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 10.0
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
