import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldPeminjaman extends StatelessWidget {
  final bool obsureText;
  final String labelText;
  final String? initialValue;
  final Widget? preficIcon;
  final Widget? surficeIcon;

  const CustomTextFieldPeminjaman({
    super.key,
    required this.obsureText,
    required this.labelText,
    required this.initialValue,
    this.preficIcon,
    this.surficeIcon,
  });

  @override
  Widget build(BuildContext context) {
    const Color backgroundInput = Color(0xFFEFEFEF);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            width: 70,
            child: Text(
              labelText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.abhayaLibre(
                  fontSize: 16.0,
                  letterSpacing: -0.3,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(
            child: TextFormField(
              enabled: false,
              initialValue: initialValue,
              obscureText: obsureText,
              style: GoogleFonts.abhayaLibre(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  prefixIcon: preficIcon,
                  fillColor: backgroundInput,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 3
                      ),
                      borderRadius: BorderRadius.circular(100.100)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.black,
                          width: 3
                      ),
                      borderRadius: BorderRadius.circular(100.100)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.black,
                          width: 3
                      ),
                      borderRadius: BorderRadius.circular(100.100)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.black,
                          width: 3,
                      ),
                      borderRadius: BorderRadius.circular(100.100)),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
