import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_detail_buku.dart';
import '../controllers/detailbook_controller.dart';

class DetailbookView extends GetView<DetailbookController> {
  const DetailbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 55;

    const Color background = Color(0xFFC6D3E3);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: background,
      statusBarIconBrightness: Brightness.light, // Change this color as needed
    ));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          toolbarHeight: 55,
          title: Text(
            Get.parameters['judul'].toString(),
            style: GoogleFonts.alegreya(
                fontSize: 18.0,
                color: const Color(0xFF271C68),
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft, color: Color(0xFF271C68),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),

        body: Container(
          color: const Color(0xFFC6D3E3),
          width: width,
          height: bodyHeight,
          child: ListView(
            children: [
              SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: sectionDetailBook()
              ),
              const SizedBox(height: 10),
            ],
          ),
        )
    );
  }

  Widget sectionDetailBook(){
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    final bodyHeight = height - 50;
    return Obx((){
      if (controller.dataDetailBook.value == null) {
        return SizedBox(
          width: width,
          height: bodyHeight,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC6D3E3)),
            ),
          ),
        );
      } else if (controller.dataDetailBook.value == null) {
        return SizedBox(
          width: width,
          height: bodyHeight,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC6D3E3)),
            ),
          ),
        );
      } else {
        var dataBuku = controller.dataDetailBook.value?.buku;
        var dataUlasan = controller.dataDetailBook.value?.ulasan;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: height * 0.015,
            ),

            SizedBox(
              width: width,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 225,
                      width: width * 0.40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          dataBuku!.coverBuku.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: width * 0.035,
                    ),

                    Expanded(
                      child: SizedBox(
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataBuku.judul!,
                                      maxLines: 2,
                                      style: GoogleFonts.alegreya(
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF271C68),
                                        fontSize: 32.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                    ),

                                    SizedBox(
                                      height: height * 0.010,
                                    ),

                                    Text(
                                      dataBuku.deskripsi!,
                                      style: GoogleFonts.alegreya(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                      maxLines: 5,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    SizedBox(
                                      height: height * 0.010,
                                    ),

                                    RatingBarIndicator(
                                      rating: dataBuku.rating!,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Color(0xFFFFC107),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: height * 0.020,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)
                            ),
                            backgroundColor: dataBuku.statusPeminjaman == 'Belum dipinjam' ? const Color(0xFF271C68) : Colors.white,
                          ),
                          onPressed: (){
                            if (dataBuku.statusPeminjaman == 'Belum dipinjam') {
                              controller.showConfirmPeminjaman(() => Navigator.pop(Get.context!, 'OK'), 'Lanjutkan');
                            }else if(dataBuku.statusPeminjaman == 'Dipinjam'){
                              return;
                            }
                          },
                          child: Text(
                            dataBuku.statusPeminjaman == 'Belum dipinjam'
                                ? 'Pinjam Buku' : 'Dipinjam',
                            style: GoogleFonts.alegreya(
                              fontWeight: FontWeight.w900,
                              color: dataBuku.statusPeminjaman == 'Belum dipinjam'
                                  ? Colors.white :const Color(0xFF271C68),
                              fontSize: 26.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    InkWell(
                      onTap: (){
                        if (dataBuku.status == 'Tersimpan'){
                          controller.deleteKoleksiBook(dataBuku.bukuID.toString(), Get.context!);
                        }else{
                          controller.addKoleksiBuku(Get.context!);
                        }
                      },
                      child: Icon(
                        dataBuku.status == 'Tersimpan' ? CupertinoIcons.bookmark_solid : CupertinoIcons.bookmark,
                        color:  dataBuku.status == 'Tersimpan' ? const Color(0xFF271C68) : Colors.black,
                        size: 35,
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pengarang: ${dataBuku.penulis}',
                    style: GoogleFonts.alegreya(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      height: 1.6,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                  Text(
                    'Penerbit: ${dataBuku.penerbit}',
                    style: GoogleFonts.alegreya(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      height: 1.6,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                  Text(
                    'Tahun Terbit: ${dataBuku.tahunTerbit}',
                    style: GoogleFonts.alegreya(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      height: 1.6,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                  Text(
                    'Jumlah Halaman: ${dataBuku.jumlahHalaman.toString()}',
                    style: GoogleFonts.alegreya(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      height: 1.6,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                  Text(
                    'Jumlah Peminjam: ${dataBuku.jumlahPeminjam.toString()}',
                    style: GoogleFonts.alegreya(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      height: 1.6,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),

                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width : width * 0.40,
                  height : 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFF271C68),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )
                  ),
                  child: Center(
                    child: Text(
                      'Ulasan Buku',
                      style: GoogleFonts.alegreya(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                        height: 1.6,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: buildUlasanList(dataUlasan),
                ),
              ],
            ),
          ],
        );
      }
    }
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Center(
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/fotoprofile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: width * 0.025,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ulasan.users?.username ?? '',
                          style: GoogleFonts.alegreya(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        RatingBarIndicator(
                          direction: Axis.horizontal,
                          rating: ulasan.rating!.toDouble(),
                          itemCount: 5,
                          itemSize: 14,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xFFFFC107),
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          ulasan.ulasan!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.alegreya(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242).withOpacity(0.01),
          width: 0.5,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.alegreya(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
