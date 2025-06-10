import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/spot.dart';
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
          margin: const EdgeInsets.all(16),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with close button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getCategoryColor(selectedSpot.category),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getCategoryIcon(selectedSpot.category),
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        selectedSpot.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => notifier.selectSpot(null),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(
                          selectedSpot.category,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        selectedSpot.category.toUpperCase(),
                        style: TextStyle(
                          color: _getCategoryColor(selectedSpot.category),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description
                    if (selectedSpot.spot.description != null) ...[
                      Text(
                        selectedSpot.spot.description!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                    ],

                    // Tags
                    if (selectedSpot.spot.tags.isNotEmpty) ...[
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: selectedSpot.spot.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(fontSize: 11),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // User stats
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Visited ${selectedSpot.visitCount} times',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Action buttons
                    Row(
                      children: [
                        // Visit button
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => notifier.incrementSpotVisitCount(
                              selectedSpot.id,
                            ),
                            icon: const Icon(Icons.add_location, size: 18),
                            label: const Text('Mark Visited'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Favorite button
                        IconButton(
                          onPressed: () =>
                              notifier.toggleSpotFavorite(selectedSpot.id),
                          icon: Icon(
                            selectedSpot.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: selectedSpot.isFavorite
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    // Rating
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Rate this spot:',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        ...List.generate(5, (index) {
                          final rating = index + 1;
                          final currentRating =
                              selectedSpot.userData.userRating ?? 0;
                          return GestureDetector(
                            onTap: () => notifier.setSpotRating(
                              selectedSpot.id,
                              rating.toDouble(),
                            ),
                            child: Icon(
                              rating <= currentRating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 20,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
