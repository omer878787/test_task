import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      textTheme: GoogleFonts.mulishTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textColor,
        displayColor: AppColors.textColor,
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.stroke, width: 1),
        ),
      ),
      dividerColor: AppColors.stroke,
    );
  }
}
