import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomBarMaterial extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  CustomBottomBarMaterial({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color colorIcon= const Color(0xFF000000).withOpacity(0.50);
    const Color colorSelect= Color(0xFF271C68);
    const Color colorBackground= Color(0xFFFFFFFF);

    return BottomNavigationBar(
      unselectedItemColor: colorIcon,
      selectedItemColor: colorSelect,
      onTap: onTap,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorBackground,
      selectedFontSize: 16,
      selectedLabelStyle: GoogleFonts.abhayaLibre(
          fontWeight: FontWeight.w800
      ),
      iconSize: 28,
      showUnselectedLabels: true,
      items: [
        _bottomNavigationBarItem(
          icon: Icons.house_rounded,
          label: 'Home',
        ),
        _bottomNavigationBarItem(
          icon: Icons.search,
          label: 'Search',
        ),
        _bottomNavigationBarItem(
          icon: Icons.bookmark,
          label: 'Bookmark',
        ),
        _bottomNavigationBarItem(
          icon: Icons.history_rounded,
          label: 'History',
        ),

        _bottomNavigationBarItem(
          icon: Icons.person_2_rounded,
          label: 'Profile',
        ),
      ],
    );
  }
  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
