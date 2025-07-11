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

  /// Night Explorer Theme - Primary dark theme for evening exploration
  static AppThemeData get nightExplorer => AppThemeData(
    name: 'Night Explorer',
    description: 'Modern dark theme optimized for evening exploration',
    brightness: Brightness.dark,

    // Semantic Action Colors (bright versions for dark theme)
    currentState: DesignTokens.currentOrangeBright,
    opportunities: DesignTokens.opportunityYellowBright,
    navigation: DesignTokens.navigationBlueBright,
    progress: DesignTokens.progressGreenBright,
    accent: DesignTokens.explorerGreenBright,

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
    focused: DesignTokens.navigationBlueBright.withAlpha(
      (255 * DesignTokens.opacityLight).round(),
    ),
    disabled: DesignTokens.gray600,
    disabledContent: DesignTokens.gray500,

    // Feedback Colors (bright versions for dark theme)
    success: DesignTokens.successGreenBright,
    warning: DesignTokens.warningAmberBright,
    error: DesignTokens.errorRedBright,
    info: DesignTokens.infoBlueBright,

    typography: AppTypography.standard,
    spacing: AppSpacing.standard,
    components: AppComponentStyles.nightExplorer,
    mapStyles: MapAreaStyles.nightExplorer,
  );


  /// Daylight Explorer Theme - Clean light theme for daytime exploration
  static AppThemeData get daylightExplorer => AppThemeData(
    name: 'Daylight Explorer',
    description: 'Clean and modern light theme for daytime exploration',
    brightness: Brightness.light,

    // Semantic Action Colors (standard versions for light theme)
    currentState: DesignTokens.currentOrange,
    opportunities: DesignTokens.opportunityYellow,
    navigation: DesignTokens.navigationBlue,
    progress: DesignTokens.progressGreen,
    accent: DesignTokens.explorerGreen,

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
    focused: DesignTokens.navigationBlue.withAlpha(
      (255 * DesignTokens.opacityLight).round(),
    ),
    disabled: DesignTokens.gray300,
    disabledContent: DesignTokens.gray400,

    // Feedback Colors (standard versions for light theme)
    success: DesignTokens.successGreen,
    warning: DesignTokens.warningAmber,
    error: DesignTokens.errorRed,
    info: DesignTokens.infoBlue,

    typography: AppTypography.standard,
    spacing: AppSpacing.standard,
    components: AppComponentStyles.daylightExplorer,
    mapStyles: MapAreaStyles.daylightExplorer,
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

  static AppComponentStyles get nightExplorer => AppComponentStyles(
    spots: SpotStyles.nightExplorer,
    buttons: ButtonStyles.nightExplorer,
    cards: CardStyles.nightExplorer,
    inputs: InputStyles.nightExplorer,
    cardShadow: DesignTokens.black.withAlpha((255 * 0.2).round()),
    buttonShadow: DesignTokens.black.withAlpha((255 * 0.15).round()),
    dialogScrim: DesignTokens.black.withAlpha((255 * 0.6).round()),
    panelScrim: DesignTokens.gray900.withAlpha((255 * 0.8).round()),
  );

  static AppComponentStyles get daylightExplorer => AppComponentStyles(
    spots: SpotStyles.daylightExplorer,
    buttons: ButtonStyles.daylightExplorer,
    cards: CardStyles.daylightExplorer,
    inputs: InputStyles.daylightExplorer,
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

  static const SpotStyles nightExplorer = SpotStyles(
    currentLocationSize: DesignTokens.spotHuge, // 18px
    selectedSize: DesignTokens.spotLarge, // 16px
    opportunitySize: DesignTokens.spotMedium, // 14px
    completedSize: DesignTokens.spotRegular, // 12px
    regularSize: DesignTokens.spotSmall, // 10px
    borderWidth: 2.0,
    glowRadius: 4.0,
  );

  static const SpotStyles daylightExplorer = SpotStyles(
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

  static const ButtonStyles nightExplorer = ButtonStyles(
    height: 48.0,
    borderRadius: DesignTokens.radiusMedium,
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.space20,
      vertical: DesignTokens.space12,
    ),
    elevation: DesignTokens.elevationLow,
  );

  static const ButtonStyles daylightExplorer = ButtonStyles(
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

  static const CardStyles nightExplorer = CardStyles(
    borderRadius: DesignTokens.radiusLarge,
    padding: EdgeInsets.all(DesignTokens.space16),
    elevation: DesignTokens.elevationLow,
    borderWidth: 0.0,
  );

  static const CardStyles daylightExplorer = CardStyles(
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

  static const InputStyles nightExplorer = InputStyles(
    borderRadius: DesignTokens.radiusMedium,
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.space16,
      vertical: DesignTokens.space12,
    ),
    borderWidth: 1.0,
    height: 48.0,
  );

  static const InputStyles daylightExplorer = InputStyles(
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

  static MapAreaStyles get nightExplorer => MapAreaStyles(
    unvisitedFill: DesignTokens.gray900.withAlpha((255 * 0.1).round()),
    unvisitedBorder: DesignTokens.gray700,
    unvisitedBorderWidth: 1.0,
    inProgressFill: DesignTokens.progressGreenBright.withAlpha((255 * 0.3).round()),
    inProgressBorder: DesignTokens.progressGreenBright,
    inProgressBorderWidth: 1.5,
    // Completed areas: Deep green solid border + transparent green fill
    completedFill: DesignTokens.progressGreenBright.withAlpha((255 * 0.3).round()),
    completedBorder: DesignTokens.progressGreenBright, // Solid border
    completedBorderWidth: 2.0,
    // Selected areas: Deep orange solid border + transparent lighter orange fill  
    selectedFill: DesignTokens.currentOrangeBright.withAlpha((255 * 0.3).round()),
    selectedBorder: DesignTokens.currentOrangeBright, // Solid border
    selectedBorderWidth: 3.0,
  );

  static MapAreaStyles get daylightExplorer => MapAreaStyles(
    unvisitedFill: DesignTokens.gray300.withAlpha((255 * 0.1).round()),
    unvisitedBorder: DesignTokens.gray300,
    unvisitedBorderWidth: 1.0,
    inProgressFill: DesignTokens.progressGreen.withAlpha((255 * 0.25).round()),
    inProgressBorder: DesignTokens.progressGreen,
    inProgressBorderWidth: 1.5,
    // Completed areas: Deep green solid border + transparent green fill
    completedFill: DesignTokens.progressGreen.withAlpha((255 * 0.3).round()),
    completedBorder: DesignTokens.progressGreen, // Solid border
    completedBorderWidth: 2.0,
    // Selected areas: Deep orange solid border + transparent lighter orange fill
    selectedFill: DesignTokens.currentOrange.withAlpha((255 * 0.3).round()),
    selectedBorder: DesignTokens.currentOrange, // Solid border
    selectedBorderWidth: 3.0,
  );
}
