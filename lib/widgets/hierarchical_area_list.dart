import 'package:flutter/material.dart';

import '../models/boundary_data.dart';
import '../models/osm_models.dart';
import '../overpass_map_notifier.dart';

/// A hierarchical, scrollable list widget that displays cities, bezirke, and stadtteile
/// with visual differentiation and visit count information
class HierarchicalAreaList extends StatelessWidget {
  final BoundaryData? boundaryData;
  final OverpassMapNotifier notifier;
  final GeographicArea? selectedArea;

  const HierarchicalAreaList({
    super.key,
    required this.boundaryData,
    required this.notifier,
    this.selectedArea,
  });

  @override
  Widget build(BuildContext context) {
    if (boundaryData == null) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with enhanced legend
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.location_city, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Geographic Areas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Visual state legend
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Visual States:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.radio_button_checked, size: 14, color: Colors.orange),
                              const SizedBox(width: 4),
                              const Text('Selected', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, size: 14, color: Colors.purple),
                              const SizedBox(width: 4),
                              const Text('Visited', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.orange),
                        const SizedBox(width: 4),
                        const Text('Selected + Visited', style: TextStyle(fontSize: 10)),
                      ],
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
            padding: const EdgeInsets.all(8.0),
            children: [
              // Cities section
              if (boundaryData!.cities.isNotEmpty) ...[
                _buildSectionHeader('Cities', Icons.location_city, Colors.red, boundaryData!.cities.length),
                ...boundaryData!.cities.map(
                  (city) => _buildAreaListItem(
                    area: city,
                    level: 0,
                    icon: Icons.location_city,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Bezirke section
              if (boundaryData!.bezirke.isNotEmpty) ...[
                _buildSectionHeader('Bezirke', Icons.domain, Colors.blue, boundaryData!.bezirke.length),
                ...boundaryData!.bezirke.map(
                  (bezirk) => _buildAreaListItem(
                    area: bezirk,
                    level: 1,
                    icon: Icons.domain,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Stadtteile section
              if (boundaryData!.stadtteile.isNotEmpty) ...[
                _buildSectionHeader('Stadtteile', Icons.home_work, Colors.green, boundaryData!.stadtteile.length),
                ...boundaryData!.stadtteile.map(
                  (stadtteil) => _buildAreaListItem(
                    area: stadtteil,
                    level: 2,
                    icon: Icons.home_work,
                    color: Colors.green,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color, int count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color.withValues(alpha: 0.8),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaListItem({
    required GeographicArea area,
    required int level,
    required IconData icon,
    required Color color,
  }) {
    final visitCount = notifier.userAreaVisitData[area.id]?.visitCount ?? 0;
    final isSelected = selectedArea?.id == area.id;
    final isVisited = visitCount > 0;

    // Different indentation based on hierarchy level
    final leftPadding = 16.0 + (level * 20.0);

    // Enhanced state-based styling
    Color backgroundColor;
    Color borderColor;
    double borderWidth;
    IconData? stateIcon;
    Color? stateIconColor;

    if (isSelected && isVisited) {
      // Both selected and visited - special combined state
      backgroundColor = Colors.orange.withValues(alpha: 0.25);
      borderColor = Colors.purple;
      borderWidth = 2.5;
      stateIcon = Icons.star;
      stateIconColor = Colors.orange;
    } else if (isSelected) {
      backgroundColor = Colors.orange.withValues(alpha: 0.2);
      borderColor = Colors.orange;
      borderWidth = 2.0;
      stateIcon = Icons.radio_button_checked;
      stateIconColor = Colors.orange;
    } else if (isVisited) {
      backgroundColor = Colors.purple.withValues(alpha: 0.15);
      borderColor = Colors.purple.withValues(alpha: 0.4);
      borderWidth = 1.5;
      stateIcon = Icons.check_circle;
      stateIconColor = Colors.purple;
    } else {
      backgroundColor = Colors.transparent;
      borderColor = Colors.transparent;
      borderWidth = 0.0;
      stateIcon = null;
      stateIconColor = null;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0), // More rounded corners
        border: borderWidth > 0 ? Border.all(color: borderColor, width: borderWidth) : null,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.3),
                  blurRadius: 8.0,
                  offset: const Offset(0, 2),
                ),
              ]
            : isVisited
            ? [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.2),
                  blurRadius: 4.0,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () => notifier.selectArea(area),
          child: Padding(
            padding: EdgeInsets.only(
              left: leftPadding,
              right: 12.0,
              top: 12.0,
              bottom: 12.0,
            ),
            child: Row(
              children: [
                // State indicator icon (before hierarchy indicator)
                if (stateIcon != null) ...[
                  Icon(
                    stateIcon,
                    color: stateIconColor,
                    size: 16.0,
                  ),
                  const SizedBox(width: 8.0),
                ],

                // Hierarchy indicator
                if (level > 0) ...[
                  Container(
                    width: 3.0, // Slightly thicker
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                    margin: const EdgeInsets.only(right: 8.0),
                  ),
                ],

                // Main area icon with enhanced styling
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: (isSelected || isVisited) ? color.withValues(alpha: 0.15) : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? color
                        : isVisited
                        ? color.withValues(alpha: 0.8)
                        : color.withValues(alpha: 0.7),
                    size: 18 - (level * 2), // Smaller icons for lower levels
                  ),
                ),
                const SizedBox(width: 12), // Increased spacing
                // Area info with enhanced typography
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        area.name,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 14 - (level * 0.5), // Smaller text for lower levels
                          color: isSelected
                              ? Colors.orange.shade700
                              : isVisited
                              ? Colors.purple.shade700
                              : Colors.black87,
                          letterSpacing: isSelected ? 0.5 : 0.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (level == 0) // Only show admin level for cities
                        Text(
                          'Admin Level ${area.adminLevel}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),

                // Enhanced visit count badge
                if (visitCount > 0) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.withValues(alpha: 0.15),
                          Colors.purple.withValues(alpha: 0.25),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Colors.purple.withValues(alpha: 0.4),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 12,
                          color: Colors.purple.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          visitCount.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.purple.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],

                // Enhanced visit count controls with better styling
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => notifier.decrementVisitCount(area.id),
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.remove_circle_outline,
                            size: 16,
                            color: visitCount > 0 ? Colors.purple.shade600 : Colors.grey[400],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => notifier.incrementVisitCount(area.id),
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.add_circle_outline,
                            size: 16,
                            color: Colors.purple.shade600,
                          ),
                        ),
                      ),
                    ],
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
