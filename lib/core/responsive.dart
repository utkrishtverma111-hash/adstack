import 'package:flutter/material.dart';

/// Breakpoints tuned for an office-use admin dashboard.
/// mobile  : < 700   -> single column, drawer nav, stacked cards
/// tablet  : 700-1100 -> 2-column grid, collapsible rail nav
/// desktop : > 1100   -> full sidebar + 3-pane layout (matches design)
class Responsive {
  Responsive._();

  static const double mobileMax = 700;
  static const double tabletMax = 1100;
  static const double desktopWideMax = 1500;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  /// Whether there's enough width to show the right "events/calendar" rail
  /// alongside the main content (matches the reference design on wide web).
  static bool showRightRail(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopWideMax;

  static double value(
    BuildContext context, {
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    final w = MediaQuery.of(context).size.width;
    if (w < mobileMax) return mobile;
    if (w < tabletMax) return tablet ?? (mobile + desktop) / 2;
    return desktop;
  }
}
