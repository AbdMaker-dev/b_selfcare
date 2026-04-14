import 'package:flutter/material.dart';

class AppColors {
  // Primary & Secondary
  static const Color primary = Color(0xFF033377); // Bleu profond
  static const Color secondary = Color(0xFFFFCF00); // Jaune vif
  
  // Neutral
  static const Color background = Color(0xFFF5F7FC);
  static const Color white = Colors.white;
  static const Color textBody = Color(0xFF1F2937);
  static const Color black = Color(0xFF000000);
  static const Color textHeading = Color(0xFF111827);
  static const Color textMuted = Color(0xFF6B7280);
  
  // Accents
  static const Color inputBorder = Color(0x24133273); // 14.12% opacity
  static const Color inputBorderLight = Color(0xFF8090B8); // 14.12% opacity
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF5DCAA5);
  static const Color warning = Color(0xFFF59E0B);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF022A63)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
