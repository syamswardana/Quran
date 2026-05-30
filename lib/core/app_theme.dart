import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0F1419);
  static const Color surface = Color(0xFF1A2332);
  static const Color primaryText = Color(0xFFF5F0E8);
  static const Color secondaryText = Color(0xFF8A9BAE);
  static const Color gold = Color(0xFFC9A962);
  static const Color activeTab = Color(0xFF1B6B4A);
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle title = GoogleFonts.inter(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
  );

  static TextStyle searchHint = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
  );

  static TextStyle tabLabel = GoogleFonts.inter(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle surahName = GoogleFonts.inter(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static TextStyle surahMeta = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
  );

  static TextStyle surahNumber = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
  );

  static TextStyle arabicName = GoogleFonts.amiri(
    fontSize: 22.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.gold,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.background,
      primary: AppColors.gold,
      secondary: AppColors.activeTab,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
    ),
  );
}
