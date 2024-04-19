import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListRekomendasiBuku extends StatelessWidget {
  final context;

  CustomListRekomendasiBuku({
    super.key,
    required this.context,
  });

  List<CardItem> items = [
    CardItem(
      imageURl: "assets/buku/buku1.png",
      judulBuku: "One Piece",
    ),
    CardItem(
      imageURl: "assets/buku/buku2.png",
      judulBuku: "Dilan 1991",
    ),
    CardItem(
      imageURl: "assets/buku/buku3.png",
      judulBuku: "Ancika",
    ),
    CardItem(
      imageURl: "assets/buku/buku1.png",
      judulBuku: "One Piece",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount : 4,
        separatorBuilder: (context, _) => SizedBox(width: 15,),
        itemBuilder: (context, index) => builCard(items:items[index]),
      ),
    );
  }

  Widget builCard({
    required CardItem items,
})=> Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.asset(
                items.imageURl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5,),
        AutoSizeText(
          items.judulBuku,
          maxLines: 1,
          maxFontSize: 16,
          minFontSize: 12,
          style: GoogleFonts.abhayaLibre(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        )
      ],
    ),
  );
}

class CardItem {
  final String imageURl;
  final String judulBuku;

  const CardItem({
    required this.imageURl,
    required this.judulBuku,
});
}
