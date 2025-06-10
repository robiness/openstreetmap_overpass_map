import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../overpass_map_notifier.dart';

class SpotCategoryFilters extends StatefulWidget {
  final bool isCompactMode;

  const SpotCategoryFilters({
    super.key,
    this.isCompactMode = false,
  });

  @override
  State<SpotCategoryFilters> createState() => _SpotCategoryFiltersState();
}

class _SpotCategoryFiltersState extends State<SpotCategoryFilters> {
  bool _isExpanded = false;

  static const Map<String, IconData> categoryIcons = {
    'restaurant': Icons.restaurant,
    'cafe': Icons.local_cafe,
    'bar': Icons.local_bar,
    'biergarten': Icons.sports_bar,
    'viewpoint': Icons.landscape,
    'shop': Icons.shopping_bag,
  };

  static const Map<String, Color> categoryColors = {
    'restaurant': Colors.orange,
    'cafe': Colors.brown,
    'bar': Colors.indigo,
    'biergarten': Colors.green,
    'viewpoint': Colors.blue,
    'shop': Colors.teal,
  };

  static const Map<String, String> categoryLabels = {
    'restaurant': 'Restaurants',
    'cafe': 'Cafés',
    'bar': 'Bars',
    'biergarten': 'Biergärten',
    'viewpoint': 'Viewpoints',
    'shop': 'Shops',
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<OverpassMapNotifier>(
      builder: (context, notifier, child) {
        if (widget.isCompactMode) {
          return _buildCompactWidget(notifier);
        } else {
          return _buildFullWidget(notifier);
        }
      },
    );
  }

  Widget _buildCompactWidget(OverpassMapNotifier notifier) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isExpanded ? 280 : 60,
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _isExpanded
          ? _buildExpandedContent(notifier)
          : _buildCollapsedContent(notifier),
    );
  }

  Widget _buildCollapsedContent(OverpassMapNotifier notifier) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Toggle button
        IconButton(
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          icon: Icon(
            Icons.tune,
            color: notifier.showSpots ? Colors.blue : Colors.grey,
          ),
          tooltip: 'Spot Filters',
        ),
        // Spot count indicator
        if (notifier.showSpots && notifier.spots.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${notifier.filteredDisplayableSpots.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExpandedContent(OverpassMapNotifier notifier) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.place,
                color: notifier.showSpots ? Colors.blue : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  'Spots',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Switch(
                value: notifier.showSpots,
                onChanged: notifier.toggleSpots,
                activeColor: Colors.blue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              IconButton(
                onPressed: () => setState(() => _isExpanded = false),
                icon: const Icon(Icons.close, size: 18),
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: EdgeInsets.zero,
              ),
            ],
          ),

          if (notifier.showSpots) ...[
            const SizedBox(height: 8),
            // Category chips - compact horizontal layout
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: categoryIcons.keys.map((category) {
                final isEnabled = notifier.enabledSpotCategories.contains(
                  category,
                );
                final color = categoryColors[category] ?? Colors.grey;
                final icon = categoryIcons[category] ?? Icons.place;

                return GestureDetector(
                  onTap: () =>
                      notifier.toggleSpotCategory(category, !isEnabled),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isEnabled ? color : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          size: 12,
                          color: isEnabled
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: isEnabled
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Stats
            if (notifier.spots.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '${notifier.filteredDisplayableSpots.length}/${notifier.spots.length} spots',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildFullWidget(OverpassMapNotifier notifier) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Spots toggle header - more compact
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.place,
                  color: notifier.showSpots ? Colors.blue : Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    'Spots',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: notifier.showSpots,
                  onChanged: notifier.toggleSpots,
                  activeColor: Colors.blue,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),

          // Category filters (only show if spots are enabled)
          if (notifier.showSpots)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Category chips - more compact
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: categoryIcons.keys.map((category) {
                      final isEnabled = notifier.enabledSpotCategories.contains(
                        category,
                      );
                      final color = categoryColors[category] ?? Colors.grey;
                      final icon = categoryIcons[category] ?? Icons.place;
                      final label = categoryLabels[category] ?? category;

                      return GestureDetector(
                        onTap: () =>
                            notifier.toggleSpotCategory(category, !isEnabled),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isEnabled ? color : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isEnabled ? color : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                icon,
                                size: 14,
                                color: isEnabled
                                    ? Colors.white
                                    : Colors.grey.shade600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                label,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: isEnabled
                                      ? Colors.white
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Stats summary
                  if (notifier.spots.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      '${notifier.filteredDisplayableSpots.length} of ${notifier.spots.length} spots shown',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
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
}
