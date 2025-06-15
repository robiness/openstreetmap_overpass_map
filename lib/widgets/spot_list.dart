import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/spot.dart';
import '../overpass_map_notifier.dart';

class SpotList extends StatefulWidget {
  final bool showSearchBar;
  final Function(DisplayableSpot)? onSpotTapped;

  const SpotList({
    super.key,
    this.showSearchBar = true,
    this.onSpotTapped,
  });

  @override
  State<SpotList> createState() => _SpotListState();
}

class _SpotListState extends State<SpotList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _sortBy = 'name'; // 'name', 'category', 'visits', 'rating'

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OverpassMapNotifier>(
      builder: (context, notifier, child) {
        final spots = _filterAndSortSpots(notifier.filteredDisplayableSpots);

        return Column(
          children: [
            // Search and sort controls
            if (widget.showSearchBar) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black..withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Search bar
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search spots...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                                icon: const Icon(Icons.clear),
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() => _searchQuery = value.toLowerCase());
                      },
                    ),

                    const SizedBox(height: 12),

                    // Sort dropdown
                    Row(
                      children: [
                        const Text(
                          'Sort by:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButton<String>(
                            value: _sortBy,
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                value: 'name',
                                child: Text('Name'),
                              ),
                              DropdownMenuItem(
                                value: 'category',
                                child: Text('Category'),
                              ),
                              DropdownMenuItem(
                                value: 'visits',
                                child: Text('Visit Count'),
                              ),
                              DropdownMenuItem(
                                value: 'rating',
                                child: Text('Rating'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _sortBy = value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Results header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  Text(
                    '${spots.length} spots found',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  if (notifier.isLoading)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
            ),

            // Spot list
            Expanded(
              child: spots.isEmpty
                  ? _buildEmptyState(notifier)
                  : ListView.builder(
                      itemCount: spots.length,
                      itemBuilder: (context, index) {
                        final spot = spots[index];
                        return _buildSpotListItem(spot, notifier);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(OverpassMapNotifier notifier) {
    if (notifier.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading spots...'),
          ],
        ),
      );
    }

    if (!notifier.showSpots) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.visibility_off, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('Spots are hidden'),
            Text(
              'Enable spots to see results',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 48, color: Colors.grey),
          SizedBox(height: 16),
          Text('No spots found'),
          Text(
            'Try adjusting your filters',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSpotListItem(
    DisplayableSpot spot,
    OverpassMapNotifier notifier,
  ) {
    final isSelected = notifier.selectedDisplaySpot?.id == spot.id;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.orange : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getCategoryColor(spot.category),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getCategoryIcon(spot.category),
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          spot.name,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              spot.category.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                color: _getCategoryColor(spot.category),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                if (spot.isVisited) ...[
                  Icon(Icons.visibility, size: 14, color: Colors.purple),
                  const SizedBox(width: 4),
                  Text(
                    '${spot.visitCount} visits',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
                if (spot.isFavorite) ...[
                  if (spot.isVisited) const SizedBox(width: 8),
                  const Icon(Icons.favorite, size: 14, color: Colors.red),
                ],
                if (spot.userData.userRating != null) ...[
                  if (spot.isVisited || spot.isFavorite) const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        spot.userData.userRating!.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (action) => _handleSpotAction(action, spot, notifier),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'visit',
              child: Row(
                children: [
                  Icon(Icons.add_location, size: 18),
                  SizedBox(width: 8),
                  Text('Mark Visited'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'favorite',
              child: Row(
                children: [
                  Icon(
                    spot.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(spot.isFavorite ? 'Remove Favorite' : 'Add Favorite'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'center',
              child: Row(
                children: [
                  Icon(Icons.my_location, size: 18),
                  SizedBox(width: 8),
                  Text('Center on Map'),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          notifier.selectSpot(spot.spot);
          widget.onSpotTapped?.call(spot);
        },
      ),
    );
  }

  void _handleSpotAction(
    String action,
    DisplayableSpot spot,
    OverpassMapNotifier notifier,
  ) {
    switch (action) {
      case 'visit':
        notifier.incrementSpotVisitCount(spot.id);
        break;
      case 'favorite':
        notifier.toggleSpotFavorite(spot.id);
        break;
      case 'center':
        notifier.selectSpot(spot.spot, moveCamera: true);
        break;
    }
  }

  List<DisplayableSpot> _filterAndSortSpots(List<DisplayableSpot> spots) {
    // Filter by search query
    var filtered = spots.where((spot) {
      if (_searchQuery.isEmpty) return true;
      return spot.name.toLowerCase().contains(_searchQuery) || spot.category.toLowerCase().contains(_searchQuery);
    }).toList();

    // Sort
    filtered.sort((a, b) {
      switch (_sortBy) {
        case 'name':
          return a.name.compareTo(b.name);
        case 'category':
          final categoryCompare = a.category.compareTo(b.category);
          return categoryCompare != 0 ? categoryCompare : a.name.compareTo(b.name);
        case 'visits':
          final visitCompare = b.visitCount.compareTo(
            a.visitCount,
          ); // Descending
          return visitCompare != 0 ? visitCompare : a.name.compareTo(b.name);
        case 'rating':
          final aRating = a.userData.userRating ?? 0;
          final bRating = b.userData.userRating ?? 0;
          final ratingCompare = bRating.compareTo(aRating); // Descending
          return ratingCompare != 0 ? ratingCompare : a.name.compareTo(b.name);
        default:
          return 0;
      }
    });

    return filtered;
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
