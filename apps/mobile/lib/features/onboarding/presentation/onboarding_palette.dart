import 'package:flutter/material.dart';

/// Colors estimated from the Figma prototype screenshots (no exact hex
/// values / design tokens were available at the time this was written).
/// TODO(design): move into a shared app_theme.dart once Issue #7 (core
/// setup) lands, and swap for exact values if the design team provides them.
class OnboardingPalette {
  OnboardingPalette._();

  static const primaryBlue = Color(0xFF1D4ED8);
  static const primaryBlueDark = Color(0xFF1E3A8A);
  static const badgeBackground = Color(0xFFEFF6FF);
  static const titleColor = Color(0xFF111827);
  static const descriptionColor = Color(0xFF6B7280);
  static const indicatorInactive = Color(0xFFD1D5DB);

  static const primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryBlue, primaryBlueDark],
  );
}
