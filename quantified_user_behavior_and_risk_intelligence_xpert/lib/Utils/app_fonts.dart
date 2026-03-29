import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized typography and text styles for the entire application
class AppFonts {
  // Primary Font: Orbitron (Futuristic, tech-style)
  static TextStyle get orbitronLogo => GoogleFonts.orbitron(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 4,
  );

  static TextStyle get orbitronXL => GoogleFonts.orbitron(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
  );

  static TextStyle get orbitronLarge => GoogleFonts.orbitron(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 2,
  );

  static TextStyle get orbitronMedium => GoogleFonts.orbitron(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static TextStyle get orbitronSmall => GoogleFonts.orbitron(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
  );

  static TextStyle get orbitronXSmall => GoogleFonts.orbitron(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  );

  static TextStyle get orbitronSubtitle => GoogleFonts.orbitron(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    letterSpacing: 2,
  );

  // Heading styles for Material design integration
  static TextStyle get displayLarge => GoogleFonts.orbitron(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
  );

  static TextStyle get displayMedium => GoogleFonts.orbitron(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );

  static TextStyle get displaySmall => GoogleFonts.orbitron(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static TextStyle get headlineLarge => GoogleFonts.orbitron(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static TextStyle get headlineMedium => GoogleFonts.orbitron(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
  );

  static TextStyle get titleLarge => GoogleFonts.orbitron(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
  );

  static TextStyle get titleMedium =>
      GoogleFonts.orbitron(fontSize: 14, fontWeight: FontWeight.w600);

  static TextStyle get bodyLarge =>
      GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.normal);

  static TextStyle get bodyMedium =>
      GoogleFonts.orbitron(fontSize: 14, fontWeight: FontWeight.normal);

  static TextStyle get labelLarge => GoogleFonts.orbitron(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle get labelMedium => GoogleFonts.orbitron(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}
