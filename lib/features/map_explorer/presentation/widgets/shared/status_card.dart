import 'package:flutter/material.dart';
import 'package:overpass_map/app/theme/app_theme.dart';

class StatusCard extends StatelessWidget {
  final String message;
  final Color color;
  final IconData icon;
  final Widget? child;

  const StatusCard({
    super.key,
    required this.message,
    required this.color,
    required this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withAlpha((255 * 0.1).round()),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        side: BorderSide(color: color, width: 1),
      ),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            if (child != null) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}
