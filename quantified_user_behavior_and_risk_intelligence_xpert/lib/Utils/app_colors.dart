import 'package:flutter/material.dart';

/// Centralized color constants for the entire application
/// Premium Dark Theme with Gold and Cyan accents
class AppColors {
  // ============================================================================
  // PREMIUM COLOR PALETTE (Splash Screen Theme)
  // ============================================================================

  // Dark Premium Background
  static const Color bgPremium = Color(0xFF1A1612); // Dark chocolate/black
  static const Color bgPremiumLight = Color(
    0xFF2A1F0E,
  ); // Slightly lighter brown
  static const Color bgPremiumDark = Color(0xFF0F0D0A); // Very dark

  // Gold/Warm Accent (Premium)
  static const Color gold = Color(0xFFC99222); // Warm gold
  static const Color goldLight = Color(0xFFFFD700); // Light gold
  static const Color goldDark = Color(0xFF8B6914); // Dark gold

  // Cyan/Tech Accent
  static const Color cyan = Color(0xFF00D9FF); // Bright cyan
  static const Color cyanLight = Color(0xFF40E0FF); // Light cyan
  static const Color cyanDark = Color(0xFF00A8CC); // Dark cyan

  // ============================================================================
  // THEME COLORS (Using premium palette)
  // ============================================================================

  // Primary Colors
  static const Color primary = gold; // Gold as primary
  static const Color primaryLight = goldLight;
  static const Color primaryDark = goldDark;

  // Secondary Colors
  static const Color secondary = cyan; // Cyan as secondary
  static const Color secondaryLight = cyanLight;
  static const Color secondaryDark = cyanDark;

  // Accent Colors
  static const Color accent = gold;
  static const Color accentGreen = Color(0xFF10B981); // Emerald Green
  static const Color accentOrange = Color(0xFFF97316); // Orange
  static const Color accentRed = Color(0xFFEF4444); // Red

  // ============================================================================
  // BACKGROUNDS
  // ============================================================================

  static const Color bgPrimary = bgPremium; // Main app background
  static const Color bgSecondary = bgPremiumLight; // Secondary background
  static const Color bgCard = Color(
    0xFF2A2420,
  ); // Card background (slightly lighter)
  static const Color bgSurface = Color(0xFF1F1A16); // Surface background

  // ============================================================================
  // NEUTRAL COLORS (Dark Theme)
  // ============================================================================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Grayscale for dark theme
  static const Color grey50 = Color(0xFF3A3530);
  static const Color grey100 = Color(0xFF322D28);
  static const Color grey200 = Color(0xFF2A2420);
  static const Color grey300 = Color(0xFF1F1A16);
  static const Color grey400 = Color(0xFFA8A39E);
  static const Color grey500 = Color(0xFF8B8680);
  static const Color grey600 = Color(0xFF6B6560);
  static const Color grey700 = Color(0xFF4B4540);
  static const Color grey800 = Color(0xFF2A1F0E);
  static const Color grey900 = Color(0xFF0F0D0A);

  // ============================================================================
  // TEXT COLORS
  // ============================================================================

  static const Color textPrimary = Color(0xFFFFFFFF); // White text on dark
  static const Color textSecondary = Color(0xFFB8B3AE); // Light gray
  static const Color textTertiary = Color(0xFF8B8680); // Medium gray
  static const Color textAccent = gold; // Gold accent text
  static const Color textOnGold = Color(0xFF1A1612); // Dark text on gold
  static const Color textOnCyan = Color(0xFF0F0D0A); // Dark text on cyan
  static const Color textOnPrimary = Color(0xFF1A1612); // Dark text on gold
  static const Color textOnSecondary = Color(0xFF0F0D0A); // Dark text on cyan

  // ============================================================================
  // STATUS COLORS
  // ============================================================================

  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFFCD34D); // Yellow/Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = cyan; // Cyan for info

  // ============================================================================
  // RISK LEVEL COLORS
  // ============================================================================

  static const Color riskLow = Color(0xFF10B981); // Green
  static const Color riskMedium = Color(0xFFFCD34D); // Amber/Yellow
  static const Color riskHigh = Color(0xFFEF4444); // Red

  // ============================================================================
  // BORDER & SHADOW
  // ============================================================================

  static const Color borderPrimary = gold; // Gold borders
  static const Color borderSecondary = grey200;
  static const Color shadow = Color(0x26000000); // Dark shadow
  static const Color shadowLight = Color(0x0D000000); // Light shadow

  // ============================================================================
  // ACCENT LINE
  // ============================================================================

  static const Color accentLine = Color(0x40C99222); // Semi-transparent gold

  // Transparent
  static const Color transparent = Color(0x00000000);
}
