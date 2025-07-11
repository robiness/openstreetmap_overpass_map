// Export all theme components for easy importing
export 'design_tokens.dart';
export 'app_theme_data.dart';
export 'theme_provider.dart';
export 'theme_switcher.dart';

// Legacy exports for backwards compatibility
import 'package:flutter/material.dart';
import 'app_theme_data.dart';

/// Legacy AppTheme class for backwards compatibility
/// Use ThemeProvider and AppThemeData directly for new code
@Deprecated('Use ThemeProvider and AppThemeData directly')
class AppTheme {
  /// Get the current light theme (legacy support)
  static ThemeData get lightTheme => AppThemeData.daylightExplorer.toMaterialTheme();

  /// Get the current dark theme (legacy support)
  static ThemeData get darkTheme => AppThemeData.nightExplorer.toMaterialTheme();

  /// Primary color for legacy support
  static Color get primaryColor => AppThemeData.nightExplorer.accent;

  /// Surface color for legacy support
  static Color get surfaceColor => AppThemeData.nightExplorer.surface;
}

/// Extension to convert AppThemeData to MaterialTheme
extension AppThemeDataExtension on AppThemeData {
  ThemeData toMaterialTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,

      // Color Scheme
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: navigation,
        onPrimary: brightness == Brightness.light ? Colors.white : Colors.black,
        secondary: accent,
        onSecondary: brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        tertiary: progress,
        onTertiary: brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        error: error,
        onError: Colors.white,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        shadow: shadow,
        inverseSurface: brightness == Brightness.light
            ? background
            : Colors.white,
        onInverseSurface: brightness == Brightness.light
            ? onBackground
            : Colors.black,
        surfaceContainerHighest: surfaceVariant,
      ),

      // Background
      scaffoldBackgroundColor: background,

      // Typography
      textTheme: TextTheme(
        displayLarge: typography.displayLarge.copyWith(color: onBackground),
        displayMedium: typography.displayMedium.copyWith(color: onBackground),
        headlineLarge: typography.headlineLarge.copyWith(color: onBackground),
        headlineMedium: typography.headlineMedium.copyWith(color: onBackground),
        titleLarge: typography.titleLarge.copyWith(color: onSurface),
        titleMedium: typography.titleMedium.copyWith(color: onSurface),
        titleSmall: typography.titleSmall.copyWith(color: onSurface),
        bodyLarge: typography.bodyLarge.copyWith(color: onSurface),
        bodyMedium: typography.bodyMedium.copyWith(color: onSurfaceVariant),
        bodySmall: typography.bodySmall.copyWith(color: onSurfaceSubtle),
        labelLarge: typography.labelLarge.copyWith(color: onSurface),
        labelMedium: typography.labelMedium.copyWith(color: onSurfaceVariant),
        labelSmall: typography.labelSmall.copyWith(color: onSurfaceSubtle),
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 2,
        titleTextStyle: typography.titleLarge.copyWith(color: onSurface),
        iconTheme: IconThemeData(color: onSurface),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: surface,
        elevation: components.cards.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(components.cards.borderRadius),
          side: components.cards.borderWidth > 0
              ? BorderSide(color: outline, width: components.cards.borderWidth)
              : BorderSide.none,
        ),
        margin: EdgeInsets.zero,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: navigation,
          foregroundColor: Colors.white,
          elevation: components.buttons.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              components.buttons.borderRadius,
            ),
          ),
          padding: components.buttons.padding,
          fixedSize: Size.fromHeight(components.buttons.height),
          textStyle: typography.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: navigation,
          side: BorderSide(color: outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              components.buttons.borderRadius,
            ),
          ),
          padding: components.buttons.padding,
          fixedSize: Size.fromHeight(components.buttons.height),
          textStyle: typography.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: navigation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              components.buttons.borderRadius,
            ),
          ),
          padding: components.buttons.padding,
          textStyle: typography.labelLarge,
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: components.inputs.padding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(components.inputs.borderRadius),
          borderSide: BorderSide(
            color: outline,
            width: components.inputs.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(components.inputs.borderRadius),
          borderSide: BorderSide(
            color: outline,
            width: components.inputs.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(components.inputs.borderRadius),
          borderSide: BorderSide(
            color: navigation,
            width: components.inputs.borderWidth + 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(components.inputs.borderRadius),
          borderSide: BorderSide(
            color: error,
            width: components.inputs.borderWidth,
          ),
        ),
        labelStyle: typography.bodyMedium.copyWith(color: onSurfaceVariant),
        hintStyle: typography.bodyMedium.copyWith(color: onSurfaceSubtle),
      ),

      // Icons
      iconTheme: IconThemeData(
        color: onSurface,
        size: 24,
      ),

      // Dividers
      dividerTheme: DividerThemeData(
        color: outline,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: navigation,
        unselectedItemColor: onSurfaceVariant,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: currentState,
        foregroundColor: Colors.white,
        elevation: components.buttons.elevation + 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surface,
        contentTextStyle: typography.bodyMedium.copyWith(color: onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(components.cards.borderRadius),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: components.cards.elevation + 2,
      ),
    );
  }
}
