import 'package:flutter/material.dart';
import 'package:overpass_map/app/theme/app_theme.dart';

class StatusCard extends StatelessWidget {
  final String message;
  final Color color;
  final IconData icon;

  const StatusCard({
    super.key,
    required this.message,
    this.color = AppTheme.primaryColor,
    this.icon = Icons.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowSm,
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 48, color: color),
          const SizedBox(height: AppTheme.spacingLg),
          Text(message),
        ],
      ),
    );
  }
}
