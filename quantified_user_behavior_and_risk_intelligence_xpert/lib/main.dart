import 'package:flutter/material.dart';
import 'package:quantified_user_behavior_and_risk_intelligence_xpert/Screens/ConnectivityTestScreen/connectivity_test_screen.dart';
import 'package:quantified_user_behavior_and_risk_intelligence_xpert/Screens/SplashScreen/splash_screen.dart';
import 'package:quantified_user_behavior_and_risk_intelligence_xpert/Screens/UploadScreen/upload_screen.dart';
import 'package:quantified_user_behavior_and_risk_intelligence_xpert/Utils/app_colors.dart';
import 'package:quantified_user_behavior_and_risk_intelligence_xpert/Utils/app_constants.dart';
import 'package:quantified_user_behavior_and_risk_intelligence_xpert/Utils/app_fonts.dart';

void main() {
  runApp(const QubrixApp());
}

class QubrixApp extends StatelessWidget {
  const QubrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.primary,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bgPrimary,
        // ====================================================================
        // TEXT THEME - All using Orbitron font
        // ====================================================================
        textTheme: TextTheme(
          displayLarge: AppFonts.displayLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          displayMedium: AppFonts.displayMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          displaySmall: AppFonts.displaySmall.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineLarge: AppFonts.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineMedium: AppFonts.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          titleLarge: AppFonts.titleLarge.copyWith(color: AppColors.textAccent),
          titleMedium: AppFonts.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          bodyLarge: AppFonts.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          bodyMedium: AppFonts.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          labelLarge: AppFonts.labelLarge.copyWith(color: AppColors.textAccent),
          labelMedium: AppFonts.labelMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        // ====================================================================
        // APP BAR THEME
        // ====================================================================
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.bgPremium,
          foregroundColor: AppColors.textPrimary,
          elevation: 2,
          shadowColor: AppColors.shadow,
          centerTitle: true,
          titleTextStyle: AppFonts.headlineMedium.copyWith(
            color: AppColors.textAccent,
          ),
        ),
        // ====================================================================
        // BUTTON THEMES
        // ====================================================================
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnGold,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: AppFonts.titleMedium.copyWith(
              color: AppColors.textOnGold,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: AppFonts.titleMedium.copyWith(color: AppColors.primary),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: AppFonts.titleMedium,
          ),
        ),
        // ====================================================================
        // CARD THEME
        // ====================================================================
        cardTheme: CardThemeData(
          color: AppColors.bgCard,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.gold, width: 1),
          ),
          shadowColor: AppColors.shadow,
        ),
        // ====================================================================
        // INPUT DECORATION THEME
        // ====================================================================
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.bgCard,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          labelStyle: AppFonts.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          hintStyle: AppFonts.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.grey300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary, width: 2.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          prefixIconColor: AppColors.primary,
          suffixIconColor: AppColors.primary,
        ),
        // ====================================================================
        // PROGRESS INDICATOR THEME
        // ====================================================================
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.cyan,
          linearTrackColor: AppColors.grey200,
        ),
        // ====================================================================
        // FLOATING ACTION BUTTON THEME
        // ====================================================================
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnGold,
          elevation: 6,
          focusElevation: 8,
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/connectivity': (context) => const ConnectivityTestScreen(),
        '/upload': (context) => const UploadScreen(),
      },
    );
  }
}
