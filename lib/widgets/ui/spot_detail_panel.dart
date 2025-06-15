import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../overpass_map_notifier.dart';

class SpotDetailPanel extends StatelessWidget {
  const SpotDetailPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OverpassMapNotifier>(
      builder: (context, notifier, child) {
        final selectedSpot = notifier.selectedDisplaySpot;

        if (selectedSpot == null) {
          return const SizedBox.shrink();
        }

        return Container(
          constraints: const BoxConstraints(
            maxWidth: 320,
            maxHeight: 200,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black..withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Compact header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getCategoryColor(selectedSpot.category),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getCategoryIcon(selectedSpot.category),
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedSpot.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () => notifier.selectSpot(null),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),

              // Compact content
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Category and stats in one row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(
                                selectedSpot.category,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              selectedSpot.category.toUpperCase(),
                              style: TextStyle(
                                color: _getCategoryColor(selectedSpot.category),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Quick stats
                          if (selectedSpot.isVisited) ...[
                            Icon(
                              Icons.visibility,
                              size: 12,
                              color: Colors.purple,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${selectedSpot.visitCount}',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                          if (selectedSpot.isFavorite) ...[
                            if (selectedSpot.isVisited) const SizedBox(width: 6),
                            const Icon(
                              Icons.favorite,
                              size: 12,
                              color: Colors.red,
                            ),
                          ],
                          if (selectedSpot.userData.userRating != null) ...[
                            if (selectedSpot.isVisited || selectedSpot.isFavorite) const SizedBox(width: 6),
                            Icon(Icons.star, size: 12, color: Colors.amber),
                            const SizedBox(width: 2),
                            Text(
                              selectedSpot.userData.userRating!.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Quick action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildQuickActionButton(
                            icon: Icons.add_location,
                            label: 'Visit',
                            onTap: () => notifier.incrementSpotVisitCount(
                              selectedSpot.id,
                            ),
                          ),
                          _buildQuickActionButton(
                            icon: selectedSpot.isFavorite ? Icons.favorite : Icons.favorite_border,
                            label: 'Fav',
                            color: selectedSpot.isFavorite ? Colors.red : null,
                            onTap: () => notifier.toggleSpotFavorite(selectedSpot.id),
                          ),
                          _buildQuickActionButton(
                            icon: Icons.my_location,
                            label: 'Center',
                            onTap: () => notifier.selectSpot(
                              selectedSpot.spot,
                              moveCamera: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color ?? Colors.grey.shade700),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color ?? Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'restaurant':
        return Colors.orange;
      case 'cafe':
        return Colors.brown;
      case 'bar':
        return Colors.indigo;
      case 'biergarten':
        return Colors.green;
      case 'viewpoint':
        return Colors.blue;
      case 'shop':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'restaurant':
        return Icons.restaurant;
      case 'cafe':
        return Icons.local_cafe;
      case 'bar':
        return Icons.local_bar;
      case 'biergarten':
        return Icons.sports_bar;
      case 'viewpoint':
        return Icons.landscape;
      case 'shop':
        return Icons.shopping_bag;
      default:
        return Icons.place;
    }
  }
}
