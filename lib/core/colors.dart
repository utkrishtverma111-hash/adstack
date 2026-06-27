import 'package:flutter/material.dart';

/// Adstacks Media — Dashboard color system.
///
/// NOTE ON BRAND COLOR: I couldn't pull the exact hex values from the live
/// Adstacks Media logo file (no pixel/image-color access from here), so this
/// palette is a placeholder built for a performance-marketing agency look —
/// deep navy/blue (trust, data, performance) + a warm coral/orange accent
/// (growth, energy — also reads well against dark surfaces).
/// Swap brandPurple / brandPink below with the exact hex from your logo
/// (open it in any color picker) — every other widget in the app references
/// these two constants, so it's a one-file change.
class AppColors {
  AppColors._();

  // Brand — swap these with your exact logo hex values.
  static const Color brandPurple = Color(0xFF1657C9); // primary brand blue
  static const Color brandPurpleLight = Color(0xFF4C8DFF); // lighter tint
  static const Color brandPink = Color(0xFFFF7A45); // coral/orange accent

  // Surfaces
  static const Color scaffold = Color(0xFFF4F5FA); // light app background
  static const Color sidebarBg = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color darkCard = Color(0xFF1E1B36); // sidebar-right panel dark
  static const Color darkCardAlt = Color(0xFF252140);

  // Text
  static const Color textPrimary = Color(0xFF1B1832);
  static const Color textSecondary = Color(0xFF8E8AA3);
  static const Color textOnDark = Color(0xFFF2F0FA);
  static const Color textOnDarkMuted = Color(0xFFB3AFC9);

  // Accents / status
  static const Color success = Color(0xFF3FD17C);
  static const Color warning = Color(0xFFFFB258);
  static const Color danger = Color(0xFFFF6584);
  static const Color chartLineRed = Color(0xFFFF6584);
  static const Color chartLinePurple = Color(0xFF6E5BF1);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandPurple, brandPink],
  );

  static const LinearGradient bannerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6A4FE0), Color(0xFFB45FE0)],
  );
}
