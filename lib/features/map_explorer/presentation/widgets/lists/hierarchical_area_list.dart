import 'package:flutter/material.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/features/debug/presentation/bloc/debug_bloc.dart';

/// A hierarchical, scrollable list widget that displays cities, bezirke, and stadtteile
/// with visual differentiation and visit count information
class HierarchicalAreaList extends StatelessWidget {
  final BoundaryData? boundaryData;
  final GeographicArea? selectedArea;
  final Map<int, UserAreaData> userVisitData;
  final Function(GeographicArea) onAreaTapped;

  const HierarchicalAreaList({
    super.key,
    required this.boundaryData,
    this.selectedArea,
    required this.userVisitData,
    required this.onAreaTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (boundaryData == null) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingXl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_off,
                size: 48,
                color: AppTheme.textTertiary,
              ),
              const SizedBox(height: AppTheme.spacingLg),
              Text(
                'No data available',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              Text(
                'Load geographic data to explore areas',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: AppTheme.surfaceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced legend in sidebar header
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              border: Border(
                bottom: BorderSide(color: AppTheme.borderColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visual States',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),

                // State legend
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Column(
                    children: [
                      _buildLegendItem(
                        context,
                        icon: Icons.radio_button_checked,
                        color: AppTheme.getSelectedColor(),
                        label: 'Selected',
                      ),
                      const SizedBox(height: AppTheme.spacingSm),
                      _buildLegendItem(
                        context,
                        icon: Icons.check_circle,
                        color: AppTheme.getVisitedColor(),
                        label: 'Visited',
                      ),
                      const SizedBox(height: AppTheme.spacingSm),
                      _buildLegendItem(
                        context,
                        icon: Icons.star,
                        color: AppTheme.getSelectedColor(),
                        label: 'Selected + Visited',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Scrollable list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              children: [
                // Cities section
                if (boundaryData!.cities.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'Cities',
                    Icons.location_city,
                    AppTheme.getCityColor(),
                    boundaryData!.cities.length,
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  ...boundaryData!.cities.map(
                    (city) => _buildAreaListItem(
                      context: context,
                      area: city,
                      level: 0,
                      icon: Icons.location_city,
                      color: AppTheme.getCityColor(),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXl),
                ],

                // Bezirke section
                if (boundaryData!.bezirke.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'Bezirke',
                    Icons.domain,
                    AppTheme.getBezirkColor(),
                    boundaryData!.bezirke.length,
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  ...boundaryData!.bezirke.map(
                    (bezirk) => _buildAreaListItem(
                      context: context,
                      area: bezirk,
                      level: 1,
                      icon: Icons.domain,
                      color: AppTheme.getBezirkColor(),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXl),
                ],

                // Stadtteile section
                if (boundaryData!.stadtteile.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'Stadtteile',
                    Icons.home_work,
                    AppTheme.getStadtteilColor(),
                    boundaryData!.stadtteile.length,
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  ...boundaryData!.stadtteile.map(
                    (stadtteil) => _buildAreaListItem(
                      context: context,
                      area: stadtteil,
                      level: 2,
                      icon: Icons.home_work,
                      color: AppTheme.getStadtteilColor(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: color,
        ),
        const SizedBox(width: AppTheme.spacingSm),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    int count,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.1),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),

          const SizedBox(width: AppTheme.spacingMd),

          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSm,
              vertical: AppTheme.spacing2xs,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              count.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaListItem({
    required BuildContext context,
    required GeographicArea area,
    required int level,
    required IconData icon,
    required Color color,
  }) {
    int visitCount = userVisitData[area.id]?.visitCount ?? 0;

    // Visual states based on selection and visits
    bool isSelected = selectedArea?.id == area.id;

    Color tileColor = AppTheme.cardColor;
    Color textColor = AppTheme.textPrimary;
    FontWeight fontWeight = FontWeight.normal;
    double elevation = 2.0;

    if (isSelected) {
      tileColor = AppTheme.getSelectedColor().withValues(alpha: 0.15);
      fontWeight = FontWeight.w600;
      elevation = 4.0;
    }

    return BlocBuilder<DebugBloc, DebugState>(
      builder: (context, debugState) {
        return Card(
          elevation: elevation,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            side: isSelected
                ? BorderSide(
                    color: AppTheme.getSelectedColor(),
                    width: 2.0,
                  )
                : BorderSide(color: AppTheme.borderColor),
          ),
          color: tileColor,
          child: InkWell(
            onTap: () => onAreaTapped(area),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd,
                vertical: AppTheme.spacingLg - (level * 2),
              ),
              child: Row(
                children: [
                  // Left side: icon and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          area.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: fontWeight,
                                color: textColor,
                              ),
                        ),
                        if (visitCount > 0)
                          Text(
                            '$visitCount Visits',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: visitCount > 0
                                      ? AppTheme.getVisitedColor()
                                      : AppTheme.textTertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                      ],
                    ),
                  ),

                  // Right side: visit counter
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSm,
                      vertical: AppTheme.spacing2xs,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      border: Border.all(color: color.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      visitCount.toString(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
