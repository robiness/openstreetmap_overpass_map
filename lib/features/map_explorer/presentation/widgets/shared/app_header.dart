import 'package:flutter/material.dart';
import 'package:overpass_map/app/theme/app_theme.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      color: AppTheme.primaryColor,
      child: const Row(
        children: [
          Icon(Icons.map, color: Colors.white, size: 32),
          SizedBox(width: AppTheme.spacingMd),
          Text(
            'Social Exploration Game',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
