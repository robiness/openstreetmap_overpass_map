import 'package:flutter/material.dart';

import '../../overpass_map_notifier.dart';
import '../../theme/app_theme.dart';

class ControlPanel extends StatelessWidget {
  final OverpassMapNotifier notifier;

  const ControlPanel({
    super.key,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: AppTheme.shadowMd,
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusXl),
                topRight: Radius.circular(AppTheme.radiusXl),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Text(
                  'Map Controls',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Layer Controls
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visible Layers',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),

                // Layer Toggle Cards
                _buildLayerCard(
                  context: context,
                  title: 'City Outline',
                  subtitle: 'Show city boundaries',
                  icon: Icons.location_city,
                  color: AppTheme.getCityColor(),
                  isEnabled: notifier.showCityOutline,
                  onChanged: (value) => notifier.toggleCityOutline(value ?? false),
                ),

                const SizedBox(height: AppTheme.spacingSm),

                _buildLayerCard(
                  context: context,
                  title: 'Bezirke',
                  subtitle: 'Show district boundaries',
                  icon: Icons.domain,
                  color: AppTheme.getBezirkColor(),
                  isEnabled: notifier.showBezirke,
                  onChanged: (value) => notifier.toggleBezirke(value ?? false),
                ),

                const SizedBox(height: AppTheme.spacingSm),

                _buildLayerCard(
                  context: context,
                  title: 'Stadtteile',
                  subtitle: 'Show neighborhood boundaries',
                  icon: Icons.home_work,
                  color: AppTheme.getStadtteilColor(),
                  isEnabled: notifier.showStadtteile,
                  onChanged: (value) => notifier.toggleStadtteile(value ?? false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isEnabled,
    required ValueChanged<bool?> onChanged,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isEnabled ? color.withValues(alpha: 0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: isEnabled ? color.withValues(alpha: 0.3) : AppTheme.borderColor,
          width: isEnabled ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          onTap: () => onChanged(!isEnabled),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(AppTheme.spacingSm),
                  decoration: BoxDecoration(
                    color: isEnabled ? color.withValues(alpha: 0.15) : AppTheme.textTertiary
                      ..withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: isEnabled ? color : AppTheme.textTertiary,
                  ),
                ),

                const SizedBox(width: AppTheme.spacingMd),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: isEnabled ? AppTheme.textPrimary : AppTheme.textSecondary,
                          fontWeight: isEnabled ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isEnabled ? AppTheme.textSecondary : AppTheme.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),

                AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: isEnabled ? 1.1 : 1.0,
                  child: Checkbox(
                    value: isEnabled,
                    onChanged: onChanged,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
