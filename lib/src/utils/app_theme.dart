import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.white,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Montserrat', // Par défaut pour le corps du texte
      
      textTheme: const TextTheme(
        // Titres utilisant Montserrat par défaut
        displayLarge: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: AppColors.textHeading,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textHeading,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textHeading,
        ),
        
        // Corps du texte utilisant Montserrat
        bodyLarge: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular comme demandé
          color: AppColors.textBody,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textBody,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textMuted,
        ),
        
        // Styles spécifiques demandés par l'utilisateur
        labelLarge: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          height: 1.0,
          letterSpacing: 0.0,
          color: AppColors.textHeading,
        ),
      ),
      
      // Configuration des boutons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      // Configuration de l'AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textHeading,
        ),
        iconTheme: IconThemeData(color: AppColors.textHeading),
      ),
      
      // Configuration des inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.6),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.6),
        ),
        labelStyle: const TextStyle(fontFamily: 'Montserrat', color: AppColors.textMuted),
        hintStyle: const TextStyle(fontFamily: 'Montserrat', color: AppColors.textMuted, fontSize: 14),
      ),
    );
  }
}
