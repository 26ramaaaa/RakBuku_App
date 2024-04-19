import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/historypeminjaman_controller.dart';

class HistorypeminjamanView extends GetView<HistorypeminjamanController> {
  const HistorypeminjamanView({Key? key}) : super(key: key);
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
            await controller.getDataPeminjaman();
          },
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
                color: primary
            ),
            child: RefreshIndicator(
              onRefresh: () async{
                await controller.getDataPeminjaman();
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
                      width: width * 0.80,
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
                              await controller.getDataPeminjaman();
                            },
                            child: Text(
                              'History Peminjaman Buku',
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
                      child: Obx(() => controller.historyPeminjaman.isEmpty?
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
      itemCount: controller.historyPeminjaman.length,
      itemBuilder: (context, index) {
        var dataHistory = controller.historyPeminjaman[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: InkWell(
            onTap: () {
              dataHistory.status == 'Selesai' ? controller.kontenBeriUlasan(dataHistory.bukuId.toString(), dataHistory.judulBuku.toString()) : ();
              // Get.toNamed(Routes.BUKTIPEMINJAMAN, parameters: {
              //   'idPeminjaman': dataHistory.peminjamanID.toString(),
              //   'asalHalaman' : 'historyPeminjaman',
              // });
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
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: AspectRatio(
                            aspectRatio: 4 / 5,
                            child: Image.network(
                              dataHistory.coverBuku.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: dataHistory.status == 'Ditolak'
                                    ? const Color(0xFFEA1818)
                                    : dataHistory.status == 'Dipinjam'
                                    ? const Color(0xFFF5F5F5)
                                    : dataHistory.status ==
                                    'Selesai'
                                    ? const Color(0xFF271C68)
                                    : const Color(0xFF1B1B1D),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    dataHistory.status == 'Selesai' ? const SizedBox() : const Icon(
                                      Icons.info,
                                      color: Colors.black,
                                      size: 20,
                                    ),

                                    dataHistory.status == 'Selesai' ? const SizedBox() : const SizedBox(
                                      width: 10,
                                    ),

                                    Text(
                                      dataHistory.status == 'Selesai' ? 'Beri Ulasan' : dataHistory.status.toString(),
                                      style: GoogleFonts.averiaGruesaLibre(
                                        color: dataHistory.status == 'Selesai' ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
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
                          dataHistory.judulBuku!,
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

                        Text(
                          'Tanggal Pinjam : ${dataHistory.tanggalPinjam!}',
                          style: GoogleFonts.alegreya(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          'Deadline Pengembalian : ${dataHistory.deadline!}',
                          style: GoogleFonts.alegreya(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          'Status Peminjaman : ${dataHistory.status!}',
                          style: GoogleFonts.alegreya(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
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
