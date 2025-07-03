import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/theme/theme_provider.dart';
import 'package:overpass_map/features/debug/presentation/bloc/debug_bloc.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';

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
    final appTheme = context.appTheme;

    if (boundaryData == null) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(appTheme.spacing.large),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_off,
                size: 48,
                color: appTheme.onSurfaceSubtle,
              ),
              SizedBox(height: appTheme.spacing.medium),
              Text(
                'No data available',
                style: appTheme.typography.titleMedium.copyWith(
                  color: appTheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: appTheme.spacing.small),
              Text(
                'Load geographic data to explore areas',
                style: appTheme.typography.bodySmall.copyWith(
                  color: appTheme.onSurfaceSubtle,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: appTheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced legend in sidebar header
          Container(
            padding: EdgeInsets.all(appTheme.spacing.medium),
            decoration: BoxDecoration(
              color: appTheme.surface,
              border: Border(
                bottom: BorderSide(color: appTheme.outline),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visual States',
                  style: appTheme.typography.labelLarge.copyWith(
                    color: appTheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: appTheme.spacing.medium),

                // State legend
                Container(
                  padding: EdgeInsets.all(appTheme.spacing.medium),
                  decoration: BoxDecoration(
                    color: appTheme.background,
                    borderRadius: BorderRadius.circular(
                      appTheme.components.cards.borderRadius,
                    ),
                    border: Border.all(color: appTheme.outline),
                  ),
                  child: Column(
                    children: [
                      _buildLegendItem(
                        context,
                        icon: Icons.radio_button_checked,
                        color: appTheme.opportunities,
                        label: 'Selected',
                      ),
                      SizedBox(height: appTheme.spacing.small),
                      _buildLegendItem(
                        context,
                        icon: Icons.check_circle,
                        color: appTheme.accent,
                        label: 'Visited',
                      ),
                      SizedBox(height: appTheme.spacing.small),
                      _buildLegendItem(
                        context,
                        icon: Icons.star,
                        color: appTheme.opportunities,
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
              padding: EdgeInsets.all(appTheme.spacing.medium),
              children: [
                // Cities section
                if (boundaryData!.cities.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'Cities',
                    Icons.location_city,
                    appTheme.error,
                    boundaryData!.cities.length,
                  ),
                  SizedBox(height: appTheme.spacing.medium),
                  ...boundaryData!.cities.map(
                    (city) => _buildAreaListItem(
                      context: context,
                      area: city,
                      level: 0,
                      icon: Icons.location_city,
                      color: appTheme.error,
                    ),
                  ),
                  SizedBox(height: appTheme.spacing.large),
                ],

                // Bezirke section
                if (boundaryData!.bezirke.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'Bezirke',
                    Icons.domain,
                    appTheme.navigation,
                    boundaryData!.bezirke.length,
                  ),
                  SizedBox(height: appTheme.spacing.medium),
                  ...boundaryData!.bezirke.map(
                    (bezirk) => _buildAreaListItem(
                      context: context,
                      area: bezirk,
                      level: 1,
                      icon: Icons.domain,
                      color: appTheme.navigation,
                    ),
                  ),
                  SizedBox(height: appTheme.spacing.large),
                ],

                // Stadtteile section
                if (boundaryData!.stadtteile.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'Stadtteile',
                    Icons.home_work,
                    appTheme.progress,
                    boundaryData!.stadtteile.length,
                  ),
                  SizedBox(height: appTheme.spacing.medium),
                  ...boundaryData!.stadtteile.map(
                    (stadtteil) => _buildAreaListItem(
                      context: context,
                      area: stadtteil,
                      level: 2,
                      icon: Icons.home_work,
                      color: appTheme.progress,
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
    final appTheme = context.appTheme;
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: color,
        ),
        SizedBox(width: appTheme.spacing.small),
        Text(
          label,
          style: appTheme.typography.bodySmall.copyWith(
            color: appTheme.onSurfaceVariant,
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
    final appTheme = context.appTheme;
    return Container(
      padding: EdgeInsets.all(appTheme.spacing.medium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withAlpha((255 * 0.1).round()),
            color.withAlpha((255 * 0.05).round()),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(
          appTheme.components.buttons.borderRadius,
        ),
        border: Border.all(color: color.withAlpha((255 * 0.3).round())),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          SizedBox(width: appTheme.spacing.small),
          Text(
            title,
            style: appTheme.typography.titleSmall.copyWith(color: color),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: appTheme.spacing.small,
              vertical: appTheme.spacing.tiny,
            ),
            decoration: BoxDecoration(
              color: color.withAlpha((255 * 0.15).round()),
              borderRadius: BorderRadius.circular(
                appTheme.components.cards.borderRadius,
              ),
            ),
            child: Text(
              count.toString(),
              style: appTheme.typography.labelSmall.copyWith(color: color),
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
    final isSelected = selectedArea?.id == area.id;
    final visitData = userVisitData[area.id];
    final hasBeenVisited = visitData != null && visitData.visitCount > 0;
    final appTheme = context.appTheme;

    Color tileColor = appTheme.surface;
    Color contentColor = appTheme.onSurface;

    // Apply visual states
    if (isSelected && hasBeenVisited) {
      tileColor = appTheme.opportunities.withAlpha((255 * 0.2).round());
      contentColor = appTheme.opportunities;
    } else if (isSelected) {
      tileColor = appTheme.navigation.withAlpha((255 * 0.15).round());
      contentColor = appTheme.navigation;
    } else if (hasBeenVisited) {
      tileColor = appTheme.accent.withAlpha((255 * 0.1).round());
      contentColor = appTheme.accent;
    }

    return Padding(
      padding: EdgeInsets.only(
        left: level * appTheme.spacing.large,
        bottom: appTheme.spacing.small,
      ),
      child: Material(
        color: tileColor,
        borderRadius: BorderRadius.circular(
          appTheme.components.cards.borderRadius,
        ),
        child: InkWell(
          onTap: () {
            onAreaTapped(area);
            context.read<DebugBloc>().add(
              DebugEvent.logMessage(
                'Tapped on area: ${area.name} (OSM ID: ${area.id})',
              ),
            );
          },
          borderRadius: BorderRadius.circular(
            appTheme.components.cards.borderRadius,
          ),
          splashColor: appTheme.navigation.withValues(alpha: 0.1),
          highlightColor: appTheme.navigation.withValues(alpha: 0.05),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: appTheme.spacing.medium,
              vertical: appTheme.spacing.large - (level * 2),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? appTheme.navigation : appTheme.outline,
                width: isSelected ? 1.5 : 1.0,
              ),
              borderRadius: BorderRadius.circular(
                appTheme.components.cards.borderRadius,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected && hasBeenVisited
                      ? Icons.star
                      : (isSelected ? Icons.radio_button_checked : (hasBeenVisited ? Icons.check_circle : icon)),
                  size: 18,
                  color: contentColor,
                ),
                SizedBox(width: appTheme.spacing.medium),
                Expanded(
                  child: Text(
                    area.name,
                    style: appTheme.typography.bodyLarge.copyWith(
                      color: contentColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (visitData != null) _buildVisitCountChip(context, visitData.visitCount),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisitCountChip(BuildContext context, int count) {
    final appTheme = context.appTheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: appTheme.spacing.small,
        vertical: appTheme.spacing.tiny,
      ),
      decoration: BoxDecoration(
        color: appTheme.accent.withAlpha((255 * 0.15).round()),
        borderRadius: BorderRadius.circular(
          appTheme.components.cards.borderRadius,
        ),
      ),
      child: Text(
        '${count}x Visited',
        style: appTheme.typography.labelSmall.copyWith(
          color: appTheme.accent,
        ),
      ),
    );
  }
}
