import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme_data.dart';

/// Theme Provider - Manages runtime theme switching and persistence
class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'app_theme';

  AppThemeData _currentTheme = AppThemeData.nightExplorer;

  /// Get the current theme
  AppThemeData get currentTheme => _currentTheme;

  /// Get all available themes
  List<AppThemeData> get availableThemes => [
    AppThemeData.nightExplorer,
    AppThemeData.daylightExplorer,
  ];

  /// Initialize the theme provider by loading saved preference
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeName = prefs.getString(_themeKey);

    if (savedThemeName != null) {
      final theme = availableThemes.firstWhere(
        (theme) => theme.name == savedThemeName,
        orElse: () => AppThemeData.nightExplorer,
      );
      _currentTheme = theme;
      notifyListeners();
    }
  }

  /// Switch to a new theme and save the preference
  Future<void> setTheme(AppThemeData theme) async {
    if (_currentTheme.name == theme.name) return;

    _currentTheme = theme;
    notifyListeners();

    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.name);
  }

  /// Switch to theme by name
  Future<void> setThemeByName(String themeName) async {
    final theme = availableThemes.firstWhere(
      (theme) => theme.name == themeName,
      orElse: () => _currentTheme,
    );
    await setTheme(theme);
  }

  /// Switch to next theme in the list (useful for quick cycling)
  Future<void> nextTheme() async {
    final currentIndex = availableThemes.indexWhere(
      (theme) => theme.name == _currentTheme.name,
    );
    final nextIndex = (currentIndex + 1) % availableThemes.length;
    await setTheme(availableThemes[nextIndex]);
  }

  /// Auto-switch based on ambient light or time of day
  /// This could integrate with device sensors or time of day
  Future<void> autoSwitchForConditions({
    bool? isOutdoors,
    bool? isDaylight,
    double? ambientLightLevel,
  }) async {
    AppThemeData targetTheme;

    if (isDaylight == true) {
      // Daylight Explorer for daytime use
      targetTheme = AppThemeData.daylightExplorer;
    } else {
      // Night Explorer for evening/indoor/dark conditions
      targetTheme = AppThemeData.nightExplorer;
    }

    await setTheme(targetTheme);
  }

  /// Get theme-aware Flutter MaterialTheme for compatibility
  /// This bridges our custom theme to Flutter's theming system
  ThemeData toMaterialTheme() {
    final theme = _currentTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: theme.brightness,

      // Color Scheme
      colorScheme: ColorScheme(
        brightness: theme.brightness,
        primary: theme.navigation,
        onPrimary: theme.brightness == Brightness.light ? Colors.white : Colors.black,
        secondary: theme.accent,
        onSecondary: theme.brightness == Brightness.light ? Colors.white : Colors.black,
        tertiary: theme.progress,
        onTertiary: theme.brightness == Brightness.light ? Colors.white : Colors.black,
        error: theme.error,
        onError: Colors.white,
        surface: theme.surface,
        onSurface: theme.onSurface,
        onSurfaceVariant: theme.onSurfaceVariant,
        outline: theme.outline,
        shadow: theme.shadow,
        inverseSurface: theme.brightness == Brightness.light ? theme.background : Colors.white,
        onInverseSurface: theme.brightness == Brightness.light ? theme.onBackground : Colors.black,
        surfaceContainerHighest: theme.surfaceVariant,
      ),

      // Background
      scaffoldBackgroundColor: theme.background,

      // Typography
      textTheme: TextTheme(
        displayLarge: theme.typography.displayLarge.copyWith(
          color: theme.onBackground,
        ),
        displayMedium: theme.typography.displayMedium.copyWith(
          color: theme.onBackground,
        ),
        headlineLarge: theme.typography.headlineLarge.copyWith(
          color: theme.onBackground,
        ),
        headlineMedium: theme.typography.headlineMedium.copyWith(
          color: theme.onBackground,
        ),
        titleLarge: theme.typography.titleLarge.copyWith(
          color: theme.onSurface,
        ),
        titleMedium: theme.typography.titleMedium.copyWith(
          color: theme.onSurface,
        ),
        titleSmall: theme.typography.titleSmall.copyWith(
          color: theme.onSurface,
        ),
        bodyLarge: theme.typography.bodyLarge.copyWith(color: theme.onSurface),
        bodyMedium: theme.typography.bodyMedium.copyWith(
          color: theme.onSurfaceVariant,
        ),
        bodySmall: theme.typography.bodySmall.copyWith(
          color: theme.onSurfaceSubtle,
        ),
        labelLarge: theme.typography.labelLarge.copyWith(
          color: theme.onSurface,
        ),
        labelMedium: theme.typography.labelMedium.copyWith(
          color: theme.onSurfaceVariant,
        ),
        labelSmall: theme.typography.labelSmall.copyWith(
          color: theme.onSurfaceSubtle,
        ),
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: theme.surface,
        foregroundColor: theme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 2,
        titleTextStyle: theme.typography.titleLarge.copyWith(
          color: theme.onSurface,
        ),
        iconTheme: IconThemeData(color: theme.onSurface),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: theme.surface,
        elevation: theme.components.cards.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            theme.components.cards.borderRadius,
          ),
          side: theme.components.cards.borderWidth > 0
              ? BorderSide(
                  color: theme.outline,
                  width: theme.components.cards.borderWidth,
                )
              : BorderSide.none,
        ),
        margin: EdgeInsets.zero,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.navigation,
          foregroundColor: Colors.white,
          elevation: theme.components.buttons.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              theme.components.buttons.borderRadius,
            ),
          ),
          padding: theme.components.buttons.padding,
          fixedSize: Size.fromHeight(theme.components.buttons.height),
          textStyle: theme.typography.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: theme.navigation,
          side: BorderSide(color: theme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              theme.components.buttons.borderRadius,
            ),
          ),
          padding: theme.components.buttons.padding,
          fixedSize: Size.fromHeight(theme.components.buttons.height),
          textStyle: theme.typography.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: theme.navigation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              theme.components.buttons.borderRadius,
            ),
          ),
          padding: theme.components.buttons.padding,
          textStyle: theme.typography.labelLarge,
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: theme.surface,
        contentPadding: theme.components.inputs.padding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            theme.components.inputs.borderRadius,
          ),
          borderSide: BorderSide(
            color: theme.outline,
            width: theme.components.inputs.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            theme.components.inputs.borderRadius,
          ),
          borderSide: BorderSide(
            color: theme.outline,
            width: theme.components.inputs.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            theme.components.inputs.borderRadius,
          ),
          borderSide: BorderSide(
            color: theme.navigation,
            width: theme.components.inputs.borderWidth + 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            theme.components.inputs.borderRadius,
          ),
          borderSide: BorderSide(
            color: theme.error,
            width: theme.components.inputs.borderWidth,
          ),
        ),
        labelStyle: theme.typography.bodyMedium.copyWith(
          color: theme.onSurfaceVariant,
        ),
        hintStyle: theme.typography.bodyMedium.copyWith(
          color: theme.onSurfaceSubtle,
        ),
      ),

      // Icons
      iconTheme: IconThemeData(
        color: theme.onSurface,
        size: 24,
      ),

      // Dividers
      dividerTheme: DividerThemeData(
        color: theme.outline,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: theme.surface,
        selectedItemColor: theme.navigation,
        unselectedItemColor: theme.onSurfaceVariant,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: theme.currentState,
        foregroundColor: Colors.white,
        elevation: theme.components.buttons.elevation + 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: theme.surface,
        contentTextStyle: theme.typography.bodyMedium.copyWith(
          color: theme.onSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            theme.components.cards.borderRadius,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: theme.components.cards.elevation + 2,
      ),
    );
  }
}

/// Extension for easy access to theme throughout the app
extension ThemeContext on BuildContext {
  /// Get the current app theme
  AppThemeData get appTheme => dependOnInheritedWidgetOfExactType<_ThemeProviderInherited>()!.theme;

  /// Get the theme provider
  ThemeProvider get themeProvider => dependOnInheritedWidgetOfExactType<_ThemeProviderInherited>()!.provider;
}

/// Inherited Widget for theme provider
class _ThemeProviderInherited extends InheritedWidget {
  final ThemeProvider provider;
  final AppThemeData theme;

  const _ThemeProviderInherited({
    required this.provider,
    required this.theme,
    required super.child,
  });

  @override
  bool updateShouldNotify(_ThemeProviderInherited oldWidget) {
    return theme != oldWidget.theme;
  }
}

/// Theme Provider Widget - Wrap your app with this
class AppThemeProvider extends StatefulWidget {
  final ThemeProvider provider;
  final Widget child;

  const AppThemeProvider({
    super.key,
    required this.provider,
    required this.child,
  });

  @override
  State<AppThemeProvider> createState() => _AppThemeProviderState();
}

class _AppThemeProviderState extends State<AppThemeProvider> {
  @override
  void initState() {
    super.initState();
    widget.provider.addListener(_onThemeChanged);
  }

  @override
  void didUpdateWidget(AppThemeProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.provider != oldWidget.provider) {
      oldWidget.provider.removeListener(_onThemeChanged);
      widget.provider.addListener(_onThemeChanged);
    }
  }

  @override
  void dispose() {
    widget.provider.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _ThemeProviderInherited(
      provider: widget.provider,
      theme: widget.provider.currentTheme,
      child: widget.child,
    );
  }
}
