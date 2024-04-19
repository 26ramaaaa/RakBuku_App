import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Color
    const Color primary = Color(0xFFC6D3E3);
    const Color colorText = Color(0xFF271C68);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: primary,
      statusBarIconBrightness: Brightness.light, // Change this color as needed
    ));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{
          await controller.getData();
        },
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            color: primary
          ),
          child: RefreshIndicator(
            onRefresh: () async{
              await controller.getData();
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: height * 0.030,
                  ),

                  Container(
                    width: width * 0.50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 8), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: InkWell(
                          onTap: () async{
                            await controller.getData();
                          },
                          child: Text(
                            'Koleksi Buku',
                            style: GoogleFonts.alegreya(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                              color: colorText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() => controller.koleksiBook.isEmpty?
                        kontenDataKosong() : kontenKoleksiBuku(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget kontenKoleksiBuku() {
    const Color colorText = Color(0xFF271C68);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.koleksiBook.length,
      itemBuilder: (context, index) {
        var dataKoleksi = controller.koleksiBook[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: InkWell(
            onTap: () {
              Get.toNamed(
                Routes.DETAILBOOK,
                parameters: {
                  'id': (dataKoleksi.bukuID ?? 0).toString(),
                  'judul': (dataKoleksi.judul!).toString(),
                },
              );
            },
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              height: 175,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 135,
                    height: 175,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: AspectRatio(
                        aspectRatio: 4 / 5,
                        child: Image.network(
                          dataKoleksi.coverBuku.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataKoleksi.judul!,
                          style: GoogleFonts.alegreya(
                            fontWeight: FontWeight.w900,
                            color: colorText,
                            fontSize: 24.0,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        RatingBarIndicator(
                          rating: dataKoleksi.rating!,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 24,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xFFFFC107),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          dataKoleksi.deskripsi!,
                          style: GoogleFonts.abhayaLibre(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.justify,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget kontenDataKosong(){
    const Color background = Color(0xFFFFFFFF);
    const Color borderColor = Color(0xFF424242);
    const Color colorText = Color(0xFF271C68);

    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor.withOpacity(0.10),
            width: 0.2,
          )
      ),
      child: Center(
        child: Text(
          'Bookmark empty',
          style: GoogleFonts.alegreya(
            color: colorText,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
