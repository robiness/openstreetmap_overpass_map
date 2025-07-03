import 'package:flutter/material.dart';

import 'app_theme_data.dart';
import 'theme_provider.dart';

/// Theme Switcher Widget - Provides UI controls for switching themes
class ThemeSwitcher extends StatelessWidget {
  final bool showLabels;
  final MainAxisAlignment alignment;
  final bool isCompact;

  const ThemeSwitcher({
    super.key,
    this.showLabels = true,
    this.alignment = MainAxisAlignment.center,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.themeProvider;
    final currentTheme = themeProvider.currentTheme;

    if (isCompact) {
      return _CompactThemeSwitcher(themeProvider: themeProvider);
    }

    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: alignment,
        children: themeProvider.availableThemes.map((theme) {
          final isSelected = theme.name == currentTheme.name;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _ThemeOption(
              theme: theme,
              isSelected: isSelected,
              showLabel: showLabels,
              onTap: () => themeProvider.setTheme(theme),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Individual theme option widget
class _ThemeOption extends StatelessWidget {
  final AppThemeData theme;
  final bool isSelected;
  final bool showLabel;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.theme,
    required this.isSelected,
    required this.showLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? appTheme.navigation : appTheme.outline,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? appTheme.navigation.withValues(alpha: 0.1) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Theme Preview
            _ThemePreview(theme: theme),

            if (showLabel) ...[
              const SizedBox(height: 8),
              Text(
                theme.name,
                style: appTheme.typography.labelMedium.copyWith(
                  color: isSelected ? appTheme.navigation : appTheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              Text(
                theme.description,
                style: appTheme.typography.labelSmall.copyWith(
                  color: appTheme.onSurfaceSubtle,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Visual preview of a theme
class _ThemePreview extends StatelessWidget {
  final AppThemeData theme;

  const _ThemePreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.background,
        border: Border.all(color: theme.outline, width: 0.5),
      ),
      child: Stack(
        children: [
          // Background representation
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5),
                color: theme.background,
              ),
            ),
          ),

          // Surface representation
          Positioned(
            top: 4,
            left: 4,
            right: 4,
            height: 12,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: theme.surface,
              ),
            ),
          ),

          // Color dots representing priority colors
          Positioned(
            bottom: 4,
            left: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ColorDot(color: theme.currentState, size: 6),
                const SizedBox(width: 2),
                _ColorDot(color: theme.opportunities, size: 5),
                const SizedBox(width: 2),
                _ColorDot(color: theme.navigation, size: 4),
                const SizedBox(width: 2),
                _ColorDot(color: theme.progress, size: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small color dot for theme preview
class _ColorDot extends StatelessWidget {
  final Color color;
  final double size;

  const _ColorDot({
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Compact theme switcher (just a cycling button)
class _CompactThemeSwitcher extends StatelessWidget {
  final ThemeProvider themeProvider;

  const _CompactThemeSwitcher({required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final currentTheme = themeProvider.currentTheme;

    return InkWell(
      onTap: () => themeProvider.nextTheme(),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: appTheme.surface,
          border: Border.all(color: appTheme.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemePreview(theme: currentTheme),
            const SizedBox(width: 8),
            Text(
              currentTheme.name,
              style: appTheme.typography.labelMedium.copyWith(
                color: appTheme.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: appTheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom Sheet Theme Selector
class ThemeSelectorBottomSheet extends StatelessWidget {
  const ThemeSelectorBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const ThemeSelectorBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final themeProvider = context.themeProvider;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: appTheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: appTheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            'Choose Theme',
            style: appTheme.typography.headlineMedium.copyWith(
              color: appTheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'Switch themes based on your environment and preference',
            style: appTheme.typography.bodyMedium.copyWith(
              color: appTheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Theme Options
          ...themeProvider.availableThemes.map((theme) {
            final isSelected = theme.name == themeProvider.currentTheme.name;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  themeProvider.setTheme(theme);
                  Navigator.of(context).pop();
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? appTheme.navigation : appTheme.outline,
                      width: isSelected ? 2 : 1,
                    ),
                    color: isSelected ? appTheme.navigation.withValues(alpha: 0.1) : null,
                  ),
                  child: Row(
                    children: [
                      _ThemePreview(theme: theme),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              theme.name,
                              style: appTheme.typography.titleMedium.copyWith(
                                color: isSelected ? appTheme.navigation : appTheme.onSurface,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              ),
                            ),
                            Text(
                              theme.description,
                              style: appTheme.typography.bodySmall.copyWith(
                                color: appTheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: appTheme.navigation,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 16),

          // Auto Mode Info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: appTheme.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: appTheme.info.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: appTheme.info,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Auto theme switching based on ambient light coming soon!',
                    style: appTheme.typography.bodySmall.copyWith(
                      color: appTheme.info,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
