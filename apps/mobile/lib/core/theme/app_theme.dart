// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Couleurs principales — tirées des maquettes Figma
  static const primary = Color(0xFF1A3C8F); // bleu foncé header
  static const primaryDark = Color(0xFF0D2B6E); // bleu très foncé
  static const accent = Color(0xFF1D9E75); // vert AfriNutri (DAH)
  static const background = Color(0xFFF5F7FA); // fond gris clair
  static const surface = Color(0xFFFFFFFF); // cartes blanches
  static const textPrimary = Color(0xFF0D1B2A); // texte principal
  static const textSecondary = Color(0xFF6B7280); // texte secondaire
  static const error = Color(0xFFE24B4A); // rouge erreur
  static const warning = Color(0xFFEF9F27); // orange calories
  static const success = Color(0xFF1D9E75); // vert succès

  // Macronutriments
  static const proteines = Color(0xFF378ADD); // bleu protéines
  static const glucides = Color(0xFF1D9E75); // vert glucides
  static const lipides = Color(0xFFE24B4A); // rouge lipides
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
          ),
        ),
      );
}
