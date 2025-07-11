import 'package:flutter/material.dart';

/// Design Tokens - Atomic design values that form the foundation of our design system
/// These are the raw values that get mapped to semantic meanings in themes
class DesignTokens {
  // === COLOR TOKENS ===

  // === URBAN EXPLORER BRAND COLORS ===
  
  // Primary Brand Colors
  static const Color explorerGreen = Color(0xFF059669);      // Deep green - trustworthy exploration
  static const Color explorerGreenBright = Color(0xFF10B981); // Bright green - for dark theme
  static const Color discoveryAmber = Color(0xFFF59E0B);     // Warm amber - energy & discovery
  static const Color discoveryAmberBright = Color(0xFFFBBF24); // Bright amber - for dark theme
  static const Color navigationBlue = Color(0xFF1E40AF);     // Deep blue - navigation & clarity
  static const Color navigationBlueBright = Color(0xFF3B82F6); // Electric blue - for dark theme
  
  // Semantic Action Colors
  static const Color currentOrange = Color(0xFFEA580C);      // Current/Selected - immediate attention
  static const Color currentOrangeBright = Color(0xFFFB923C); // Bright orange - for dark theme
  static const Color opportunityYellow = Color(0xFFEAB308);  // Opportunities - inviting
  static const Color opportunityYellowBright = Color(0xFFFDE047); // Bright yellow - for dark theme
  static const Color progressGreen = Color(0xFF059669);      // Progress/Visited - achievement
  static const Color progressGreenBright = Color(0xFF10B981); // Emerald green - for dark theme

  // Neutral Colors
  static const Color gray900 = Color(0xFF0F172A);
  static const Color gray800 = Color(0xFF1E293B);
  static const Color gray700 = Color(0xFF334155);
  static const Color gray600 = Color(0xFF475569);
  static const Color gray500 = Color(0xFF64748B);
  static const Color gray400 = Color(0xFF94A3B8);
  static const Color gray300 = Color(0xFFCBD5E1);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray100 = Color(0xFFF1F5F9);
  static const Color gray50 = Color(0xFFF8FAFC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Status & Feedback Colors
  static const Color errorRed = Color(0xFFDC2626);          // Clear error indication
  static const Color errorRedBright = Color(0xFFEF4444);    // Bright red - for dark theme
  static const Color warningAmber = Color(0xFFF59E0B);      // Warning indication
  static const Color warningAmberBright = Color(0xFFFBBF24); // Bright amber - for dark theme
  static const Color successGreen = Color(0xFF059669);      // Success indication (same as progress)
  static const Color successGreenBright = Color(0xFF10B981); // Bright green - for dark theme
  static const Color infoBlue = Color(0xFF0284C7);          // Information indication
  static const Color infoBlueBright = Color(0xFF38BDF8);    // Sky blue - for dark theme

  // === SPACING TOKENS ===
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space6 = 6.0;
  static const double space8 = 8.0;
  static const double space10 = 10.0;
  static const double space12 = 12.0;
  static const double space14 = 14.0;
  static const double space16 = 16.0;
  static const double space18 = 18.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space28 = 28.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space56 = 56.0;
  static const double space64 = 64.0;

  // === SIZE TOKENS ===

  // Spot Sizes (map markers)
  static const double spotTiny = 8.0;
  static const double spotSmall = 10.0;
  static const double spotRegular = 12.0;
  static const double spotMedium = 14.0;
  static const double spotLarge = 16.0;
  static const double spotHuge = 18.0;

  // Icon Sizes
  static const double iconTiny = 12.0;
  static const double iconSmall = 16.0;
  static const double iconMedium = 20.0;
  static const double iconLarge = 24.0;
  static const double iconHuge = 32.0;

  // Border Radius
  static const double radiusNone = 0.0;
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusHuge = 16.0;
  static const double radiusFull = 999.0;

  // === TYPOGRAPHY TOKENS ===

  // Font Sizes
  static const double fontSize10 = 10.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;
  static const double fontSize32 = 32.0;
  static const double fontSize40 = 40.0;

  // Font Weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightExtraBold = FontWeight.w800;

  // Line Heights (as multipliers)
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;

  // === EFFECT TOKENS ===

  // Elevation/Shadow Levels
  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationHighest = 16.0;

  // Opacity Levels
  static const double opacityInvisible = 0.0;
  static const double opacitySubtle = 0.1;
  static const double opacityLight = 0.2;
  static const double opacityMedium = 0.5;
  static const double opacityHeavy = 0.8;
  static const double opacityOpaque = 1.0;

  // Animation Durations (milliseconds)
  static const int durationFast = 150;
  static const int durationMedium = 250;
  static const int durationSlow = 350;
  static const int durationSlower = 500;

  // === HELPER METHODS ===

  /// Creates a darker shade of the given color
  static Color darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Creates a lighter shade of the given color
  static Color lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }
}
