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
  final Color
  currentState; // 🔴 Electric Orange - highest priority (current check-ins, selected)
  final Color
  opportunities; // 🟡 Bright Yellow - medium priority (nearby unchecked spots)
  final Color
  navigation; // 🔵 Bright Blue - functional clarity (buttons, links, actions)
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

  // === MAP STYLES ===
  final MapAreaStyles mapStyles;

  AppThemeData({
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
    required this.mapStyles,
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
    shadow: DesignTokens.black.withAlpha(
      (255 * DesignTokens.opacityMedium).round(),
    ),

    // Content Colors
    onBackground: DesignTokens.gray100,
    onSurface: DesignTokens.gray100,
    onSurfaceVariant: DesignTokens.gray300,
    onSurfaceSubtle: DesignTokens.gray400,

    // Interactive States
    hover: DesignTokens.white.withAlpha(
      (255 * DesignTokens.opacitySubtle).round(),
    ),
    pressed: DesignTokens.white.withAlpha(
      (255 * DesignTokens.opacityLight).round(),
    ),
    focused: DesignTokens.brightBlue.withAlpha(
      (255 * DesignTokens.opacityLight).round(),
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
    mapStyles: MapAreaStyles.darkComfort,
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
    shadow: DesignTokens.black.withAlpha(
      (255 * DesignTokens.opacityHeavy).round(),
    ),

    // Content Colors (maximum contrast)
    onBackground: DesignTokens.white,
    onSurface: DesignTokens.white,
    onSurfaceVariant: DesignTokens.gray200,
    onSurfaceSubtle: DesignTokens.gray300,

    // Interactive States
    hover: DesignTokens.white.withAlpha(
      (255 * DesignTokens.opacityLight).round(),
    ),
    pressed: DesignTokens.white.withAlpha(
      (255 * DesignTokens.opacityMedium).round(),
    ),
    focused: DesignTokens.neonBlue.withAlpha(
      (255 * DesignTokens.opacityMedium).round(),
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
    mapStyles: MapAreaStyles.highContrast,
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
    shadow: DesignTokens.gray600.withAlpha(
      (255 * DesignTokens.opacityLight).round(),
    ),

    // Content Colors
    onBackground: DesignTokens.gray900,
    onSurface: DesignTokens.gray900,
    onSurfaceVariant: DesignTokens.gray700,
    onSurfaceSubtle: DesignTokens.gray600,

    // Interactive States
    hover: DesignTokens.gray600.withAlpha(
      (255 * DesignTokens.opacitySubtle).round(),
    ),
    pressed: DesignTokens.gray600.withAlpha(
      (255 * DesignTokens.opacityLight).round(),
    ),
    focused: DesignTokens.brightBlue.withAlpha(
      (255 * DesignTokens.opacityLight).round(),
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
    mapStyles: MapAreaStyles.lightMode,
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
  final Color cardShadow;
  final Color buttonShadow;
  final Color dialogScrim;
  final Color panelScrim;

  AppComponentStyles({
    required this.spots,
    required this.buttons,
    required this.cards,
    required this.inputs,
    required this.cardShadow,
    required this.buttonShadow,
    required this.dialogScrim,
    required this.panelScrim,
  });

  static AppComponentStyles get darkComfort => AppComponentStyles(
    spots: SpotStyles.darkComfort,
    buttons: ButtonStyles.darkComfort,
    cards: CardStyles.darkComfort,
    inputs: InputStyles.darkComfort,
    cardShadow: DesignTokens.black.withAlpha((255 * 0.2).round()),
    buttonShadow: DesignTokens.black.withAlpha((255 * 0.15).round()),
    dialogScrim: DesignTokens.black.withAlpha((255 * 0.6).round()),
    panelScrim: DesignTokens.gray900.withAlpha((255 * 0.8).round()),
  );

  static AppComponentStyles get highContrast => AppComponentStyles(
    spots: SpotStyles.highContrast,
    buttons: ButtonStyles.highContrast,
    cards: CardStyles.highContrast,
    inputs: InputStyles.highContrast,
    cardShadow: DesignTokens.black.withAlpha((255 * 0.3).round()),
    buttonShadow: DesignTokens.black.withAlpha((255 * 0.25).round()),
    dialogScrim: DesignTokens.black.withAlpha((255 * 0.8).round()),
    panelScrim: DesignTokens.black.withAlpha((255 * 0.9).round()),
  );

  static AppComponentStyles get lightMode => AppComponentStyles(
    spots: SpotStyles.lightMode,
    buttons: ButtonStyles.lightMode,
    cards: CardStyles.lightMode,
    inputs: InputStyles.lightMode,
    cardShadow: DesignTokens.gray500.withAlpha((255 * 0.15).round()),
    buttonShadow: DesignTokens.gray400.withAlpha((255 * 0.1).round()),
    dialogScrim: DesignTokens.black.withAlpha((255 * 0.4).round()),
    panelScrim: DesignTokens.white.withAlpha((255 * 0.7).round()),
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

/// Defines the styles for geographic areas on the map
class MapAreaStyles {
  final Color unvisitedFill;
  final Color unvisitedBorder;
  final double unvisitedBorderWidth;

  final Color inProgressFill;
  final Color inProgressBorder;
  final double inProgressBorderWidth;

  final Color completedFill;
  final Color completedBorder;
  final double completedBorderWidth;

  final Color selectedFill;
  final Color selectedBorder;
  final double selectedBorderWidth;

  MapAreaStyles({
    required this.unvisitedFill,
    required this.unvisitedBorder,
    required this.unvisitedBorderWidth,
    required this.inProgressFill,
    required this.inProgressBorder,
    required this.inProgressBorderWidth,
    required this.completedFill,
    required this.completedBorder,
    required this.completedBorderWidth,
    required this.selectedFill,
    required this.selectedBorder,
    required this.selectedBorderWidth,
  });

  static MapAreaStyles get darkComfort => MapAreaStyles(
    unvisitedFill: DesignTokens.gray900.withAlpha((255 * 0.1).round()),
    unvisitedBorder: DesignTokens.gray900,
    unvisitedBorderWidth: 1.0,
    inProgressFill: DesignTokens.electricGreen.withAlpha((255 * 0.25).round()),
    inProgressBorder: DesignTokens.electricGreen.withAlpha((255 * 0.8).round()),
    inProgressBorderWidth: 1.5,
    completedFill: DesignTokens.electricGreen.withAlpha((255 * 0.4).round()),
    completedBorder: DesignTokens.electricGreen,
    completedBorderWidth: 1.5,
    selectedFill: DesignTokens.electricOrange.withAlpha((255 * 0.3).round()),
    selectedBorder: DesignTokens.electricOrange,
    selectedBorderWidth: 2.5,
  );

  static MapAreaStyles get highContrast => MapAreaStyles(
    unvisitedFill: DesignTokens.gray400.withAlpha((255 * 0.15).round()),
    unvisitedBorder: DesignTokens.gray400,
    unvisitedBorderWidth: 1.5,
    inProgressFill: DesignTokens.neonGreen.withAlpha((255 * 0.3).round()),
    inProgressBorder: DesignTokens.neonGreen,
    inProgressBorderWidth: 2.0,
    completedFill: DesignTokens.neonGreen.withAlpha((255 * 0.5).round()),
    completedBorder: DesignTokens.neonGreen,
    completedBorderWidth: 2.0,
    selectedFill: DesignTokens.neonOrange.withAlpha((255 * 0.4).round()),
    selectedBorder: DesignTokens.neonOrange,
    selectedBorderWidth: 3.0,
  );

  static MapAreaStyles get lightMode => MapAreaStyles(
    unvisitedFill: DesignTokens.gray300.withAlpha((255 * 0.1).round()),
    unvisitedBorder: DesignTokens.gray300,
    unvisitedBorderWidth: 1.0,
    inProgressFill: DesignTokens.darken(
      DesignTokens.electricGreen,
      0.1,
    ).withAlpha((255 * 0.2).round()),
    inProgressBorder: DesignTokens.darken(
      DesignTokens.electricGreen,
      0.1,
    ).withAlpha((255 * 0.8).round()),
    inProgressBorderWidth: 1.5,
    completedFill: DesignTokens.darken(
      DesignTokens.electricGreen,
      0.1,
    ).withAlpha((255 * 0.3).round()),
    completedBorder: DesignTokens.darken(DesignTokens.electricGreen, 0.1),
    completedBorderWidth: 1.5,
    selectedFill: DesignTokens.darken(
      DesignTokens.electricOrange,
      0.1,
    ).withAlpha((255 * 0.25).round()),
    selectedBorder: DesignTokens.darken(DesignTokens.electricOrange, 0.1),
    selectedBorderWidth: 2.5,
  );
}
