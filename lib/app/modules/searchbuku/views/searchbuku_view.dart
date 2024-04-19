import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_book.dart';
import '../../../routes/app_pages.dart';
import '../controllers/searchbuku_controller.dart';

class SearchbukuView extends GetView<SearchbukuController> {
  const SearchbukuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color textColor = Color(0xFF000AFF);
    const Color backgroundInput = Color(0xFFEFEFEF);
    const Color background = Color(0xFFC6D3E3);
    const Color colorBorder = Color(0xFFC6D3E3);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{
          await controller.getDataBook();
        },
        child: Container(
          width: width,
          height: height,
          color: background,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.035,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.6,
                        child: TextFormField(
                          controller: controller.searchController,
                          style: GoogleFonts.alegreya(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          onChanged: (value){
                            if (value.isEmpty) {
                              controller.getDataBook();
                            } else {
                              controller.getDataSearchBook(value);
                            }
                          },
                          decoration: InputDecoration(
                              fillColor: backgroundInput,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textColor.withOpacity(0.90),
                                  ),
                                  borderRadius: BorderRadius.circular(100.100)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: colorBorder.withOpacity(0.90),
                                  ),
                                  borderRadius: BorderRadius.circular(100.100)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textColor.withOpacity(0.90),
                                  ),
                                  borderRadius: BorderRadius.circular(100.100)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: colorBorder.withOpacity(0.90),
                                  ),
                                  borderRadius: BorderRadius.circular(100.100)),
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              hintText: 'Pencarian Buku',
                              hintStyle: GoogleFonts.abhayaLibre(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              )
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pleasse input character here';
                            }
                            return null;
                          },
                        ),
                      ),

                      FittedBox(
                        child: SizedBox(
                          width: width * 0.25,
                          child: SvgPicture.asset(
                            'assets/images/logo_rakbuku.svg',
                            width: 100,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: height * 0.025,
                  ),

                  Obx(
                        () {
                      if (controller.searchController.text.isEmpty) {
                        return controller.dataAllBook.isEmpty
                            ? kontenDataKosong('Buku')
                            : kontenLayoutBuku(height);
                      } else {
                        return sectionSearchBook(width, height);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
  
  Widget kontenLayoutBuku(double height){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kontenKategoriBuku(),

        SizedBox(
          height: height * 0.020,
        ),

        kontenSemuaBuku(),
      ],
    );
  }

  Widget kontenKategoriBuku(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Obx(() {
                return SizedBox(
                  height: MediaQuery.of(Get.context!).size.height * 0.050,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.dataKategori.length,
                      itemBuilder: (context, index) {
                        var buku = controller.dataKategori[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            child: TextButton(
                                onPressed: (){},
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0XFFF5F5F5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    buku.namaKategori!,
                                    style: GoogleFonts.alegreya(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: const Color(0xFF271C68),
                                    ),
                                  ),
                                )
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
          ),
        ],
      ),
    );
  }

  Widget kontenSemuaBuku(){
    const Color textColor = Color(0xFF271C68);
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Obx((){
            if (controller.dataAllBook.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              );
            }else{
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.dataAllBook.length,
                itemBuilder: (context, index){
                  var kategori = controller.dataAllBook[index].kategoriBuku;
                  var bukuList = controller.dataAllBook[index].dataBuku;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            kategori!,
                            style: GoogleFonts.alegreya(
                                fontSize: 18.0,
                                color: textColor,
                                fontWeight: FontWeight.w800
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          height: 260,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bukuList!.length,
                            itemBuilder: (context, index) {
                              DataBuku buku = bukuList[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFFF3F3F3).withOpacity(0.80),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 150, // Sesuaikan lebar gambar sesuai kebutuhan Anda
                                          height: 175, // Sesuaikan tinggi gambar sesuai kebutuhan Anda
                                          child: AspectRatio(
                                            aspectRatio: 4 / 5,
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              child: Image.network(
                                                buku.coverBuku.toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 5),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),

                                              const SizedBox(height: 4),

                                              FittedBox(
                                                child: Text(
                                                  "Penulis : ${buku.penulis!}",
                                                  style: GoogleFonts.alegreya(
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: 10.0
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),

                                              const SizedBox(height: 5),

                                              // Menampilkan rating di bawah teks penulis
                                              buku.rating != null && buku.rating! > 0
                                                  ? RatingBarIndicator(
                                                rating: buku.rating!,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemSize: 15,
                                                itemBuilder: (context, _) => const Icon(
                                                  Icons.star,
                                                  color: textColor,
                                                ),
                                              )
                                                  : RatingBarIndicator(
                                                rating: 5,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemSize: 15,
                                                itemBuilder: (context, _) => const Icon(
                                                  Icons.star,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
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
                      ),
                    ],
                  );
                },
              );
            }
          }
          )
        ],
      ),
    );
  }

  Widget kontenDataKosong(String text) {
    const Color background = Colors.white;
    const Color borderColor = Color(0xFF424242);
    return Center(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor.withOpacity(0.20),
              width: 0.3,
            )),
        child: Center(
          child: Text(
            'Sorry Data $text Empty!',
            style: GoogleFonts.alegreya(
              color: const Color(0xFF271C68),
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget sectionSearchBook(double width, double height) {
    String text = controller.searchController.text.toString();
    const Color textColor = Color(0xFF271C68);

    if (controller.searchBook.isEmpty) {
      return kontenDataKosong(text);
    } else {
      return SizedBox(
        height: MediaQuery.of(Get.context!).size.height,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 5 / 8,
          ),
          itemCount: controller.searchBook.length,
          itemBuilder: (context, index) {
            var buku = controller.searchBook[index];
            return InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.DETAILBOOK,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: Container(
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF3F3F3).withOpacity(0.80),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 175,
                      child: AspectRatio(
                        aspectRatio: 5 / 7,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            buku.coverBuku.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            buku.judul!,
                            style: GoogleFonts.alegreya(
                                fontWeight: FontWeight.w800,
                                color: textColor,
                                fontSize: 20.0
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),

                          const SizedBox(height: 4),

                          FittedBox(
                            child: Text(
                              "Penulis : ${buku.penulis!}",
                              style: GoogleFonts.alegreya(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 10.0
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // Menampilkan rating di bawah teks penulis
                          buku.rating != null && buku.rating! > 0
                              ? RatingBarIndicator(
                            rating: buku.rating!,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 15,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: textColor,
                            ),
                          )
                              : RatingBarIndicator(
                            rating: 5,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 15,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
