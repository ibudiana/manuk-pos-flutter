import 'package:flutter/material.dart';

class AppTheme {
  // Membuat warna custom terpusat
  static const Color firstColor = Color(0xFFFCDC94);
  static const Color secondaryColor = Color(0xFFEF9C66);
  static const Color thirdColor = Color(0xFFC8CFA0);
  static const Color fourthColor = Color(0xFF78ABA8);

  static const Color backgroundPrimaryColor = firstColor;
  static const Color backgroundSecondaryColor = secondaryColor;

  static const Color iconPrimaryColors = fourthColor;
  static const Color iconSecondaryColors = firstColor;

  static const Color primaryText = Colors.black87;
  static const Color secondaryText = Colors.blueGrey;
  static const Color thirdText = Colors.grey;

  static const Color buttonBackground = fourthColor;
  static const Color buttonHoverBackground = thirdColor;
  static const Color buttonForeground = Colors.white;

  // Menggunakan Font Roboto
  static const String fontName = "Roboto";

  // Membuat tema teks terpusat
  static const TextStyle headingText = TextStyle(
    fontFamily: fontName,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: primaryText,
  );

  static const TextStyle subHeadingText = TextStyle(
    fontFamily: fontName,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: secondaryText,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: fontName,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: thirdText,
  );

  static const TextStyle captionText = TextStyle(
    fontFamily: fontName,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: iconSecondaryColors,
  );
}
