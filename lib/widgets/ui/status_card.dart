import 'package:flutter/material.dart';

import '../overpass_map_notifier.dart';
import '../theme/app_theme.dart';

class StatusCard extends StatelessWidget {
  final OverpassMapNotifier notifier;

  const StatusCard({
    super.key,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    final selectedArea = notifier.selectedDisplayArea;

    if (selectedArea == null) {
      return _buildDataSourceInfo(context);
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowMd,
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with area type badge
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            decoration: BoxDecoration(
              color: _getAreaTypeColor(
                selectedArea.geoArea.type,
              ).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLg),
                topRight: Radius.circular(AppTheme.radiusLg),
              ),
              border: Border(
                bottom: BorderSide(
                  color: _getAreaTypeColor(
                    selectedArea.geoArea.type,
                  ).withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getAreaTypeIcon(selectedArea.geoArea.type),
                  color: _getAreaTypeColor(selectedArea.geoArea.type),
                  size: 20,
                ),
                const SizedBox(width: AppTheme.spacingSm),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedArea.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingSm,
                              vertical: AppTheme.spacing2xs,
                            ),
                            decoration: BoxDecoration(
                              color: _getAreaTypeColor(
                                selectedArea.geoArea.type,
                              ).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusSm,
                              ),
                              border: Border.all(
                                color: _getAreaTypeColor(
                                  selectedArea.geoArea.type,
                                ).withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              selectedArea.geoArea.type.toUpperCase(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: _getAreaTypeColor(
                                  selectedArea.geoArea.type,
                                ),
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (selectedArea.geoArea.adminLevel > 0)
                        Text(
                          'Admin Level ${selectedArea.geoArea.adminLevel}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textTertiary,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Visit Count Section
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 16,
                      color: AppTheme.getVisitedColor(),
                    ),
                    const SizedBox(width: AppTheme.spacingSm),
                    Text(
                      'Visit Count',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppTheme.spacingMd),

                // Visit count display and controls
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.getVisitedColor().withValues(alpha: 0.05),
                        AppTheme.getVisitedColor()..withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    border: Border.all(
                      color: AppTheme.getVisitedColor().withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Decrement button
                      _buildCountButton(
                        icon: Icons.remove,
                        onPressed: selectedArea.visitCount > 0
                            ? () => notifier.decrementVisitCount(selectedArea.id)
                            : null,
                        isEnabled: selectedArea.visitCount > 0,
                      ),

                      const SizedBox(width: AppTheme.spacingMd),

                      // Visit count display
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              selectedArea.visitCount.toString(),
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.getVisitedColor(),
                              ),
                            ),
                            Text(
                              selectedArea.visitCount == 1 ? 'Visit' : 'Visits',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: AppTheme.spacingMd),

                      // Increment button
                      _buildCountButton(
                        icon: Icons.add,
                        onPressed: () => notifier.incrementVisitCount(selectedArea.id),
                        isEnabled: true,
                      ),
                    ],
                  ),
                ),

                // Visit status indicator
                if (selectedArea.visitCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: AppTheme.spacingMd),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: AppTheme.getVisitedColor(),
                        ),
                        const SizedBox(width: AppTheme.spacingSm),
                        Text(
                          'This area has been visited',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.getVisitedColor(),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataSourceInfo(BuildContext context) {
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
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Text(
                'Data Source Information',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'Source: ${notifier.dataSource}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            'Load time: ${notifier.dataLoadDuration}ms',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isEnabled,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isEnabled ? 1.0 : 0.5,
      child: Material(
        color: isEnabled ? AppTheme.getVisitedColor().withValues(alpha: 0.1) : AppTheme.textTertiary
          ..withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          onTap: onPressed,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              border: Border.all(
                color: isEnabled
                    ? AppTheme.getVisitedColor().withValues(alpha: 0.3)
                    : AppTheme.textTertiary.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              icon,
              size: 18,
              color: isEnabled ? AppTheme.getVisitedColor() : AppTheme.textTertiary,
            ),
          ),
        ),
      ),
    );
  }

  Color _getAreaTypeColor(String type) {
    switch (type) {
      case 'city':
        return AppTheme.getCityColor();
      case 'bezirk':
        return AppTheme.getBezirkColor();
      case 'stadtteil':
        return AppTheme.getStadtteilColor();
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getAreaTypeIcon(String type) {
    switch (type) {
      case 'city':
        return Icons.location_city;
      case 'bezirk':
        return Icons.domain;
      case 'stadtteil':
        return Icons.home_work;
      default:
        return Icons.place;
    }
  }
}
