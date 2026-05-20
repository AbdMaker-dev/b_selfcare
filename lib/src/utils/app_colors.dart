import 'package:flutter/material.dart';

class AppColors {
  // Primary & Secondary
  static const Color primary = Color(0xFF033377); // Bleu profond
  static const Color secondary = Color(0xFFFFCF00); // Jaune vif
  
  // Neutral
  static const Color background = Color(0xFFF5F7FC);
  static const Color white = Colors.white;
  static const Color gray = Color(0xFFE5E7EB);
  static const Color grayGh = Color(0xFFF3F4F6);
  static const Color grayWh = Color(0xFFF9FAFB);
  static const Color grayAsh = Color(0xFF9CA3AF);
  static const Color greyCharcoal = Color(0xFF374151);
  static const Color graySilver = Color(0xFFD1D5DB);
  static const Color textBody = Color(0xFF1F2937);
  static const Color black = Color(0xFF000000);
  static const Color textHeading = Color(0xFF111827);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color textSecondary = Color(0xFF4B5563);

  // Accents
  static const Color inputBorder = Color(0x24133273); // 14.12% opacity
  static const Color inputBorderLight = Color(0xFF8090B8); // 14.12% opacity #3DBCAB
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF5DCAA5);
  static const Color greenMint = Color(0xFFEAF3DE);
  static const Color green = Color(0xFF3B6D11);
  static const Color greenDull = Color(0xFF3DBCAB);
  static const Color greenOlive = Color(0xFF639922);
  static const Color orangePeach = Color(0xFFFAECE7);
  static const Color orangeBurnt = Color(0xFF993C1D);
  static const Color orangeFire = Color(0xFFD85A30);
  static const Color orangeSalmon = Color(0xFFF5C4B3);

  static const Color amberCream = Color(0xFFFAEEDA);
  static const Color amberBrown = Color(0xFF854F0B);
  static const Color amberGold = Color(0xFFBA7517);

  static const Color beigeIvory = Color(0xFFF1EFE8);
  static const Color beigeMole = Color(0xFF5F5E5A);
  static const Color beigeSmoke = Color(0xFF888780);

  static const Color warning = Color(0xFFF59E0B);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF022A63)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
