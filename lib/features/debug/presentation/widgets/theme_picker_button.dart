import 'package:flutter/material.dart';
import 'package:overpass_map/app/theme/app_theme_data.dart';
import 'package:overpass_map/app/theme/theme_provider.dart';

class ThemePickerButton extends StatelessWidget {
  const ThemePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _showThemeDialog(context),
      icon: const Icon(Icons.palette_outlined),
      label: const Text('Change Theme'),
    );
  }

  void _showThemeDialog(BuildContext context) {
    final themeProvider = context.themeProvider;
    final currentThemeName = themeProvider.currentTheme.name;
    final availableThemes = themeProvider.availableThemes;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableThemes.length,
              itemBuilder: (context, index) {
                final theme = availableThemes[index];
                return RadioListTile<String>(
                  title: Text(theme.name),
                  subtitle: Text(theme.description),
                  value: theme.name,
                  groupValue: currentThemeName,
                  onChanged: (String? value) {
                    if (value != null) {
                      final selectedTheme = availableThemes.firstWhere(
                        (t) => t.name == value,
                        orElse: () => availableThemes.first,
                      );
                      themeProvider.setTheme(selectedTheme);
                      Navigator.of(dialogContext).pop();
                    }
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
