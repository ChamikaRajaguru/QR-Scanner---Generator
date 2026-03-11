import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF6750A4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);

  // Secondary Palette
  static const Color secondary = Color(0xFF625B71);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color onSecondaryContainer = Color(0xFF1D192B);

  // Background/Surface
  static const Color background = Color(0xFFFEF7FF);
  static const Color onBackground = Color(0xFF1D1B20);
  static const Color surface = Color(0xFFFEF7FF);
  static const Color onSurface = Color(0xFF1D1B20);

  // Dark Mode Colors
  static const Color primaryDark = Color(0xFFD0BCFF);
  static const Color onPrimaryDark = Color(0xFF381E72);
  static const Color primaryContainerDark = Color(0xFF4F378B);
  static const Color onPrimaryContainerDark = Color(0xFFEADDFF);

  static const Color backgroundDark = Color(0xFF141218);
  static const Color onBackgroundDark = Color(0xFFE6E1E5);
  static const Color surfaceDark = Color(0xFF141218);
  static const Color onSurfaceDark = Color(0xFFE6E1E5);

  // QR Colors
  static const List<Color> qrColors = [
    Colors.black,
    primary,
    Color(0xFFB91C1C), // Red
    Color(0xFF15803D), // Green
    Color(0xFF1D4ED8), // Blue
    Color(0xFF7C2D12), // Brown
  ];
}
