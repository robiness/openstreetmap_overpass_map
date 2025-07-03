import 'package:flutter/material.dart';

import 'design_tokens.dart';

/// App Theme Data - Contains all semantic color mappings and design system values
/// This is what components will reference for styling
class AppThemeData {
  // === CORE IDENTITY ===
  final String name;
  final String description;
  final Brightness brightness;

  // === SEMANTIC COLORS ===

  // Status-Based Colors (our priority hierarchy)
  final Color currentState; // 🔴 Electric Orange - highest priority (current check-ins, selected)
  final Color opportunities; // 🟡 Bright Yellow - medium priority (nearby unchecked spots)
  final Color navigation; // 🔵 Bright Blue - functional clarity (buttons, links, actions)
  final Color progress; // 🟢 Electric Green - progress/completion feedback
  final Color accent; // 🟣 Purple - special highlights, badges

  // Contextual Colors
  final Color background; // Main background
  final Color surface; // Cards, panels, elevated surfaces
  final Color surfaceVariant; // Alternative surface color
  final Color outline; // Borders, dividers
  final Color shadow; // Drop shadows, elevation

  // Content Colors
  final Color onBackground; // Text on background
  final Color onSurface; // Text on surface
  final Color onSurfaceVariant; // Secondary text
  final Color onSurfaceSubtle; // Tertiary text, captions

  // Interactive States
  final Color hover; // Hover state overlay
  final Color pressed; // Pressed state overlay
  final Color focused; // Focus state overlay
  final Color disabled; // Disabled state
  final Color disabledContent; // Text/icons on disabled elements

  // Feedback Colors
  final Color success; // Success messages
  final Color warning; // Warning messages
  final Color error; // Error messages
  final Color info; // Info messages

  // === TYPOGRAPHY ===
  final AppTypography typography;

  // === SPACING & LAYOUT ===
  final AppSpacing spacing;

  // === COMPONENT STYLES ===
  final AppComponentStyles components;

  const AppThemeData({
    required this.name,
    required this.description,
    required this.brightness,
    required this.currentState,
    required this.opportunities,
    required this.navigation,
    required this.progress,
    required this.accent,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.outline,
    required this.shadow,
    required this.onBackground,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.onSurfaceSubtle,
    required this.hover,
    required this.pressed,
    required this.focused,
    required this.disabled,
    required this.disabledContent,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.typography,
    required this.spacing,
    required this.components,
  });

  /// Dark Comfort Theme - Primary theme for evening/indoor use
  static AppThemeData get darkComfort => AppThemeData(
    name: 'Dark Comfort',
    description: 'Optimized for evening and indoor exploration',
    brightness: Brightness.dark,

    // Status Colors
    currentState: DesignTokens.electricOrange,
    opportunities: DesignTokens.brightYellow,
    navigation: DesignTokens.brightBlue,
    progress: DesignTokens.electricGreen,
    accent: DesignTokens.vibrantPurple,

    // Contextual Colors
    background: DesignTokens.gray900,
    surface: DesignTokens.gray800,
    surfaceVariant: DesignTokens.gray700,
    outline: DesignTokens.gray900,
    shadow: DesignTokens.withOpacity(
      DesignTokens.black,
      DesignTokens.opacityMedium,
    ),

    // Content Colors
    onBackground: DesignTokens.gray100,
    onSurface: DesignTokens.gray100,
    onSurfaceVariant: DesignTokens.gray300,
    onSurfaceSubtle: DesignTokens.gray400,

    // Interactive States
    hover: DesignTokens.withOpacity(
      DesignTokens.white,
      DesignTokens.opacitySubtle,
    ),
    pressed: DesignTokens.withOpacity(
      DesignTokens.white,
      DesignTokens.opacityLight,
    ),
    focused: DesignTokens.withOpacity(
      DesignTokens.brightBlue,
      DesignTokens.opacityLight,
    ),
    disabled: DesignTokens.gray600,
    disabledContent: DesignTokens.gray500,

    // Feedback Colors
    success: DesignTokens.successGreen,
    warning: DesignTokens.warningAmber,
    error: DesignTokens.errorRed,
    info: DesignTokens.infoBlue,

    typography: AppTypography.standard,
    spacing: AppSpacing.standard,
    components: AppComponentStyles.darkComfort,
  );

  /// High Contrast Theme - For outdoor use and bright sunlight
  static AppThemeData get highContrast => AppThemeData(
    name: 'High Contrast',
    description: 'Maximum visibility for outdoor exploration',
    brightness: Brightness.dark,

    // Status Colors (enhanced for outdoor visibility)
    currentState: DesignTokens.neonOrange,
    opportunities: DesignTokens.neonYellow,
    navigation: DesignTokens.neonBlue,
    progress: DesignTokens.neonGreen,
    accent: DesignTokens.neonPink,

    // Contextual Colors (high contrast)
    background: DesignTokens.black,
    surface: DesignTokens.gray900,
    surfaceVariant: DesignTokens.gray800,
    outline: DesignTokens.gray400,
    shadow: DesignTokens.withOpacity(
      DesignTokens.black,
      DesignTokens.opacityHeavy,
    ),

    // Content Colors (maximum contrast)
    onBackground: DesignTokens.white,
    onSurface: DesignTokens.white,
    onSurfaceVariant: DesignTokens.gray200,
    onSurfaceSubtle: DesignTokens.gray300,

    // Interactive States
    hover: DesignTokens.withOpacity(
      DesignTokens.white,
      DesignTokens.opacityLight,
    ),
    pressed: DesignTokens.withOpacity(
      DesignTokens.white,
      DesignTokens.opacityMedium,
    ),
    focused: DesignTokens.withOpacity(
      DesignTokens.neonBlue,
      DesignTokens.opacityMedium,
    ),
    disabled: DesignTokens.gray700,
    disabledContent: DesignTokens.gray600,

    // Feedback Colors (enhanced visibility)
    success: DesignTokens.neonGreen,
    warning: DesignTokens.neonYellow,
    error: DesignTokens.neonOrange,
    info: DesignTokens.neonBlue,

    typography: AppTypography.standard,
    spacing: AppSpacing.standard,
    components: AppComponentStyles.highContrast,
  );

  /// Light Mode Theme - For daytime indoor use
  static AppThemeData get lightMode => AppThemeData(
    name: 'Light Mode',
    description: 'Clean and bright for daytime indoor use',
    brightness: Brightness.light,

    // Status Colors (adapted for light background)
    currentState: DesignTokens.darken(DesignTokens.electricOrange, 0.1),
    opportunities: DesignTokens.darken(DesignTokens.brightYellow, 0.2),
    navigation: DesignTokens.darken(DesignTokens.brightBlue, 0.1),
    progress: DesignTokens.darken(DesignTokens.electricGreen, 0.1),
    accent: DesignTokens.darken(DesignTokens.vibrantPurple, 0.1),

    // Contextual Colors
    background: DesignTokens.white,
    surface: DesignTokens.gray50,
    surfaceVariant: DesignTokens.gray100,
    outline: DesignTokens.gray300,
    shadow: DesignTokens.withOpacity(
      DesignTokens.gray600,
      DesignTokens.opacityLight,
    ),

    // Content Colors
    onBackground: DesignTokens.gray900,
    onSurface: DesignTokens.gray900,
    onSurfaceVariant: DesignTokens.gray700,
    onSurfaceSubtle: DesignTokens.gray600,

    // Interactive States
    hover: DesignTokens.withOpacity(
      DesignTokens.gray600,
      DesignTokens.opacitySubtle,
    ),
    pressed: DesignTokens.withOpacity(
      DesignTokens.gray600,
      DesignTokens.opacityLight,
    ),
    focused: DesignTokens.withOpacity(
      DesignTokens.brightBlue,
      DesignTokens.opacityLight,
    ),
    disabled: DesignTokens.gray300,
    disabledContent: DesignTokens.gray400,

    // Feedback Colors
    success: DesignTokens.successGreen,
    warning: DesignTokens.warningAmber,
    error: DesignTokens.errorRed,
    info: DesignTokens.infoBlue,

    typography: AppTypography.standard,
    spacing: AppSpacing.standard,
    components: AppComponentStyles.lightMode,
  );
}

/// Typography System
class AppTypography {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  const AppTypography({
    required this.displayLarge,
    required this.displayMedium,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  static const AppTypography standard = AppTypography(
    displayLarge: TextStyle(
      fontSize: DesignTokens.fontSize40,
      fontWeight: DesignTokens.fontWeightBold,
      height: DesignTokens.lineHeightTight,
    ),
    displayMedium: TextStyle(
      fontSize: DesignTokens.fontSize32,
      fontWeight: DesignTokens.fontWeightBold,
      height: DesignTokens.lineHeightTight,
    ),
    headlineLarge: TextStyle(
      fontSize: DesignTokens.fontSize28,
      fontWeight: DesignTokens.fontWeightSemiBold,
      height: DesignTokens.lineHeightNormal,
    ),
    headlineMedium: TextStyle(
      fontSize: DesignTokens.fontSize24,
      fontWeight: DesignTokens.fontWeightSemiBold,
      height: DesignTokens.lineHeightNormal,
    ),
    titleLarge: TextStyle(
      fontSize: DesignTokens.fontSize20,
      fontWeight: DesignTokens.fontWeightSemiBold,
      height: DesignTokens.lineHeightNormal,
    ),
    titleMedium: TextStyle(
      fontSize: DesignTokens.fontSize18,
      fontWeight: DesignTokens.fontWeightMedium,
      height: DesignTokens.lineHeightNormal,
    ),
    titleSmall: TextStyle(
      fontSize: DesignTokens.fontSize16,
      fontWeight: DesignTokens.fontWeightMedium,
      height: DesignTokens.lineHeightNormal,
    ),
    bodyLarge: TextStyle(
      fontSize: DesignTokens.fontSize16,
      fontWeight: DesignTokens.fontWeightRegular,
      height: DesignTokens.lineHeightRelaxed,
    ),
    bodyMedium: TextStyle(
      fontSize: DesignTokens.fontSize14,
      fontWeight: DesignTokens.fontWeightRegular,
      height: DesignTokens.lineHeightRelaxed,
    ),
    bodySmall: TextStyle(
      fontSize: DesignTokens.fontSize12,
      fontWeight: DesignTokens.fontWeightRegular,
      height: DesignTokens.lineHeightNormal,
    ),
    labelLarge: TextStyle(
      fontSize: DesignTokens.fontSize14,
      fontWeight: DesignTokens.fontWeightMedium,
      height: DesignTokens.lineHeightNormal,
    ),
    labelMedium: TextStyle(
      fontSize: DesignTokens.fontSize12,
      fontWeight: DesignTokens.fontWeightMedium,
      height: DesignTokens.lineHeightNormal,
    ),
    labelSmall: TextStyle(
      fontSize: DesignTokens.fontSize10,
      fontWeight: DesignTokens.fontWeightMedium,
      height: DesignTokens.lineHeightNormal,
    ),
  );
}

/// Spacing System
class AppSpacing {
  final double tiny; // 4px
  final double small; // 8px
  final double medium; // 16px
  final double large; // 24px
  final double huge; // 32px
  final double massive; // 48px

  const AppSpacing({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.huge,
    required this.massive,
  });

  static const AppSpacing standard = AppSpacing(
    tiny: DesignTokens.space4,
    small: DesignTokens.space8,
    medium: DesignTokens.space16,
    large: DesignTokens.space24,
    huge: DesignTokens.space32,
    massive: DesignTokens.space48,
  );
}

/// Component-specific styles
class AppComponentStyles {
  final SpotStyles spots;
  final ButtonStyles buttons;
  final CardStyles cards;
  final InputStyles inputs;

  const AppComponentStyles({
    required this.spots,
    required this.buttons,
    required this.cards,
    required this.inputs,
  });

  static const AppComponentStyles darkComfort = AppComponentStyles(
    spots: SpotStyles.darkComfort,
    buttons: ButtonStyles.darkComfort,
    cards: CardStyles.darkComfort,
    inputs: InputStyles.darkComfort,
  );

  static const AppComponentStyles highContrast = AppComponentStyles(
    spots: SpotStyles.highContrast,
    buttons: ButtonStyles.highContrast,
    cards: CardStyles.highContrast,
    inputs: InputStyles.highContrast,
  );

  static const AppComponentStyles lightMode = AppComponentStyles(
    spots: SpotStyles.lightMode,
    buttons: ButtonStyles.lightMode,
    cards: CardStyles.lightMode,
    inputs: InputStyles.lightMode,
  );
}

/// Map spot styling
class SpotStyles {
  final double currentLocationSize;
  final double selectedSize;
  final double opportunitySize;
  final double completedSize;
  final double regularSize;
  final double borderWidth;
  final double glowRadius;

  const SpotStyles({
    required this.currentLocationSize,
    required this.selectedSize,
    required this.opportunitySize,
    required this.completedSize,
    required this.regularSize,
    required this.borderWidth,
    required this.glowRadius,
  });

  static const SpotStyles darkComfort = SpotStyles(
    currentLocationSize: DesignTokens.spotHuge, // 18px
    selectedSize: DesignTokens.spotLarge, // 16px
    opportunitySize: DesignTokens.spotMedium, // 14px
    completedSize: DesignTokens.spotRegular, // 12px
    regularSize: DesignTokens.spotSmall, // 10px
    borderWidth: 2.0,
    glowRadius: 4.0,
  );

  static const SpotStyles highContrast = SpotStyles(
    currentLocationSize: DesignTokens.spotHuge + 2, // 20px
    selectedSize: DesignTokens.spotLarge + 2, // 18px
    opportunitySize: DesignTokens.spotMedium + 2, // 16px
    completedSize: DesignTokens.spotRegular + 2, // 14px
    regularSize: DesignTokens.spotSmall + 2, // 12px
    borderWidth: 3.0,
    glowRadius: 6.0,
  );

  static const SpotStyles lightMode = SpotStyles(
    currentLocationSize: DesignTokens.spotHuge, // 18px
    selectedSize: DesignTokens.spotLarge, // 16px
    opportunitySize: DesignTokens.spotMedium, // 14px
    completedSize: DesignTokens.spotRegular, // 12px
    regularSize: DesignTokens.spotSmall, // 10px
    borderWidth: 1.5,
    glowRadius: 3.0,
  );
}

/// Button styling
class ButtonStyles {
  final double height;
  final double borderRadius;
  final EdgeInsets padding;
  final double elevation;

  const ButtonStyles({
    required this.height,
    required this.borderRadius,
    required this.padding,
    required this.elevation,
  });

  static const ButtonStyles darkComfort = ButtonStyles(
    height: 48.0,
    borderRadius: DesignTokens.radiusMedium,
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.space20,
      vertical: DesignTokens.space12,
    ),
    elevation: DesignTokens.elevationLow,
  );

  static const ButtonStyles highContrast = ButtonStyles(
    height: 52.0,
    borderRadius: DesignTokens.radiusLarge,
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.space24,
      vertical: DesignTokens.space16,
    ),
    elevation: DesignTokens.elevationMedium,
  );

  static const ButtonStyles lightMode = ButtonStyles(
    height: 44.0,
    borderRadius: DesignTokens.radiusMedium,
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.space16,
      vertical: DesignTokens.space10,
    ),
    elevation: DesignTokens.elevationLow,
  );
}

/// Card styling
class CardStyles {
  final double borderRadius;
  final EdgeInsets padding;
  final double elevation;
  final double borderWidth;

  const CardStyles({
    required this.borderRadius,
    required this.padding,
    required this.elevation,
    required this.borderWidth,
  });

  static const CardStyles darkComfort = CardStyles(
    borderRadius: DesignTokens.radiusLarge,
    padding: EdgeInsets.all(DesignTokens.space16),
    elevation: DesignTokens.elevationLow,
    borderWidth: 0.0,
  );

  static const CardStyles highContrast = CardStyles(
    borderRadius: DesignTokens.radiusMedium,
    padding: EdgeInsets.all(DesignTokens.space20),
    elevation: DesignTokens.elevationMedium,
    borderWidth: 2.0,
  );

  static const CardStyles lightMode = CardStyles(
    borderRadius: DesignTokens.radiusLarge,
    padding: EdgeInsets.all(DesignTokens.space16),
    elevation: DesignTokens.elevationLow,
    borderWidth: 1.0,
  );
}

/// Input styling
class InputStyles {
  final double borderRadius;
  final EdgeInsets padding;
  final double borderWidth;
  final double height;

  const InputStyles({
    required this.borderRadius,
    required this.padding,
    required this.borderWidth,
    required this.height,
  });

  static const InputStyles darkComfort = InputStyles(
    borderRadius: DesignTokens.radiusMedium,
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.space16,
      vertical: DesignTokens.space12,
    ),
    borderWidth: 1.0,
    height: 48.0,
  );

  static const InputStyles highContrast = InputStyles(
    borderRadius: DesignTokens.radiusMedium,
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.space20,
      vertical: DesignTokens.space16,
    ),
    borderWidth: 2.0,
    height: 52.0,
  );

  static const InputStyles lightMode = InputStyles(
    borderRadius: DesignTokens.radiusMedium,
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.space16,
      vertical: DesignTokens.space12,
    ),
    borderWidth: 1.0,
    height: 44.0,
  );
}
