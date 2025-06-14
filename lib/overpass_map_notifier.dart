import 'dart:convert'; // For json.encode/decode if persisting UserAreaData map

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/overpass_api.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For persistence

import 'models/boundary_data.dart';
import 'models/osm_models.dart';
import 'models/spot.dart';
import 'models/user_area_data.dart'; // Import the new model
import 'services/map_rendering_service.dart';

// Define a class to combine GeographicArea with its UserAreaData for UI convenience
class DisplayableArea {
  final GeographicArea geoArea;
  final UserAreaData userArea;

  DisplayableArea({required this.geoArea, required this.userArea});

  // Delegate properties for easier access in UI
  int get id => geoArea.id;
  String get name => geoArea.name;
  String get type => geoArea.type;
  int get adminLevel => geoArea.adminLevel;
  List<List<List<double>>> get coordinates => geoArea.coordinates;
  int get visitCount => userArea.visitCount;
}

// Removed AreaRenderingMode enum since we only use animated rendering now

class OverpassMapNotifier extends ChangeNotifier {
  final OverpassApi _api;

  BoundaryData? _boundaryData;
  BoundaryData? get boundaryData => _boundaryData;

  // Removed rendering mode selection - now only using animated layer

  // Animation settings - always enabled
  bool get enableAnimations => true; // Always enabled

  Duration _animationDuration = const Duration(milliseconds: 1000);
  Duration get animationDuration => _animationDuration;

  Curve _animationCurve = Curves.easeInOut;
  Curve get animationCurve => _animationCurve;

  // Renamed from _userAreaVisitData to make it package-private for testing access
  Map<int, UserAreaData> userAreaVisitData = {};
  static const String _userVisitDataKey = 'user_visit_data';

  // Spots data
  List<Spot> _spots = [];
  List<Spot> get spots => _spots;

  Map<int, UserSpotData> userSpotData = {};
  static const String _userSpotDataKey = 'user_spot_data';

  // Spot filtering and display - simplified to always show all spots
  bool _showSpots = true;
  bool get showSpots => true; // Always show spots now

  String _dataSource = "unknown";
  String get dataSource => _dataSource;

  int _dataLoadDuration = 0;
  int get dataLoadDuration => _dataLoadDuration;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _error;

  String? get error => _error;

  // Display toggles
  bool _showCityOutline = true; // Changed to true

  bool get showCityOutline => _showCityOutline;

  bool _showBezirke = true;

  bool get showSubDistricts => _showBezirke; // Keep old name for compatibility
  bool get showBezirke => _showBezirke;

  bool _showStadtteile = true; // Changed to true

  bool get showStadtteile => _showStadtteile;

  // Map interaction
  GeographicArea? _rawSelectedArea; // Store the raw GeographicArea
  DisplayableArea? get selectedDisplayArea {
    if (_rawSelectedArea == null) return null;
    // Use the renamed field here
    final userVisits =
        userAreaVisitData[_rawSelectedArea!.id] ??
        UserAreaData(areaId: _rawSelectedArea!.id);
    return DisplayableArea(geoArea: _rawSelectedArea!, userArea: userVisits);
  }

  Spot? _selectedSpot;
  DisplayableSpot? get selectedDisplaySpot {
    if (_selectedSpot == null) return null;
    final userData =
        userSpotData[_selectedSpot!.id] ??
        UserSpotData(spotId: _selectedSpot!.id);
    return DisplayableSpot(spot: _selectedSpot!, userData: userData);
  }

  LatLngBounds? _boundsToFit;

  LatLngBounds? consumeBoundsToFit() {
    final bounds = _boundsToFit;
    _boundsToFit = null;
    return bounds;
  }

  OverpassMapNotifier(this._api) {
    // Accept OverpassApi in constructor
    _loadUserVisitData(); // Load visit counts on initialization
    _loadUserSpotData(); // Load spot visit data on initialization
    fetchCityData("Köln", 6);
  }

  Future<void> _loadUserVisitData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(_userVisitDataKey);
      if (jsonString != null) {
        final Map<String, dynamic> decodedMap = json.decode(jsonString);
        // Use the renamed field here
        userAreaVisitData = decodedMap.map(
          (key, value) => MapEntry(
            int.parse(key),
            UserAreaData.fromJson(value as Map<String, dynamic>),
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      print("Error loading user visit data: $e");
    }
  }

  Future<void> _saveUserVisitData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String jsonString = json.encode(
        // Use the renamed field here
        userAreaVisitData.map(
          (key, value) => MapEntry(key.toString(), value.toJson()),
        ),
      );
      await prefs.setString(_userVisitDataKey, jsonString);
    } catch (e) {
      print("Error saving user visit data: $e");
    }
  }

  Future<void> _loadUserSpotData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(_userSpotDataKey);
      if (jsonString != null) {
        final Map<String, dynamic> decodedMap = json.decode(jsonString);
        userSpotData = decodedMap.map(
          (key, value) => MapEntry(
            int.parse(key),
            UserSpotData.fromJson(value as Map<String, dynamic>),
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      print("Error loading user spot data: $e");
    }
  }

  Future<void> _saveUserSpotData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String jsonString = json.encode(
        userSpotData.map(
          (key, value) => MapEntry(key.toString(), value.toJson()),
        ),
      );
      await prefs.setString(_userSpotDataKey, jsonString);
    } catch (e) {
      print("Error saving user spot data: $e");
    }
  }

  void incrementVisitCount(int areaId) {
    // Use the renamed field here
    userAreaVisitData.putIfAbsent(areaId, () => UserAreaData(areaId: areaId));
    userAreaVisitData[areaId]!.incrementVisitCount();
    _saveUserVisitData();
    notifyListeners();
  }

  void decrementVisitCount(int areaId) {
    // Use the renamed field here
    if (userAreaVisitData.containsKey(areaId) &&
        userAreaVisitData[areaId]!.visitCount > 0) {
      userAreaVisitData[areaId]!.visitCount--;
      _saveUserVisitData();
      notifyListeners();
    }
  }

  void setVisitCount(int areaId, int count) {
    if (count < 0) return;
    // Use the renamed field here
    userAreaVisitData.putIfAbsent(areaId, () => UserAreaData(areaId: areaId));
    userAreaVisitData[areaId]!.visitCount = count;
    _saveUserVisitData();
    notifyListeners();
  }

  List<DisplayableArea> _getDisplayableAreas(List<GeographicArea> geoAreas) {
    return geoAreas.map((geo) {
      // Use the renamed field here
      final userVisits =
          userAreaVisitData[geo.id] ?? UserAreaData(areaId: geo.id);
      return DisplayableArea(geoArea: geo, userArea: userVisits);
    }).toList();
  }

  // Removed displayedPolygons getter since we only use animated rendering now

  /// Get markers for area names
  List<Marker> get nameMarkers {
    // Temporarily disabled area labels
    return [];

    // Original implementation commented out:
    // if (_boundaryData == null) return [];

    // List<GeographicArea> areasForMarkers = [];

    // if (_showCityOutline) {
    //   areasForMarkers.addAll(_boundaryData!.cities);
    // }
    // if (_showBezirke) {
    //   areasForMarkers.addAll(_boundaryData!.bezirke);
    // }
    // if (_showStadtteile) {
    //   areasForMarkers.addAll(_boundaryData!.stadtteile);
    // }

    // // Create DisplayableAreas to pass to MapRenderingService if it needs visit counts for markers
    // List<DisplayableArea> displayableAreasForMarkers = _getDisplayableAreas(
    //   areasForMarkers,
    // );

    // // Assuming MapRenderingService.createAreaMarkers can now take List<DisplayableArea>
    // // or you adapt it to take GeographicArea and a lookup map for visit counts.
    // // For now, let's assume it's adapted or we pass GeographicArea and handle count in UI.
    // return MapRenderingService.createAreaMarkersWithVisits(
    //   displayableAreasForMarkers,
    // );
  }

  /// Get markers for spots
  List<Marker> get spotMarkers {
    if (!_showSpots) return [];

    final displayableSpots = filteredDisplayableSpots;
    return displayableSpots.map((displayableSpot) {
      return Marker(
        point: displayableSpot.location,
        child: GestureDetector(
          onTap: () => selectSpot(displayableSpot.spot),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _getSpotColor(displayableSpot),
              shape: BoxShape.circle,
              border: Border.all(
                color: _selectedSpot?.id == displayableSpot.id
                    ? Colors.orange
                    : Colors.white,
                width: 2,
              ),
            ),
            child: Icon(
              _getSpotIcon(displayableSpot.category),
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      );
    }).toList();
  }

  Color _getSpotColor(DisplayableSpot spot) {
    if (spot.isFavorite) return Colors.red;
    if (spot.isVisited) return Colors.purple;

    switch (spot.category) {
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

  IconData _getSpotIcon(String category) {
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

  /// Fetch city boundary data and spots
  Future<void> fetchCityData(String cityName, int adminLevel) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Fetch boundary data
      final result = await _api.getCityData(
        cityName,
        cityAdminLevel: adminLevel,
      );
      _boundaryData = result.data;
      _dataSource = result.source;
      _dataLoadDuration = result.duration;

      if (_boundaryData != null) {
        // Ensure user data is loaded/initialized for newly fetched areas
        // This is implicitly handled by _getDisplayableAreas or when an area is selected
        final List<GeographicArea> allElements = [];
        allElements.addAll(_boundaryData!.cities);
        allElements.addAll(_boundaryData!.bezirke);
        allElements.addAll(_boundaryData!.stadtteile);

        if (allElements.isNotEmpty) {
          _boundsToFit = MapRenderingService.calculateBounds(allElements);
        }

        // Fetch spots for the city
        await fetchSpots(cityName);
      } else {
        _error = "No data received.";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch spots for a city
  Future<void> fetchSpots(String cityName) async {
    try {
      _spots = await _api.getSpots(
        cityName: cityName,
        categories: [
          'restaurant',
          'cafe',
          'bar',
          'biergarten',
          'viewpoint',
          'shop',
        ], // Get all categories
      );

      // Assign spots to their parent areas
      _assignSpotsToAreas();

      notifyListeners();
    } catch (e) {
      print("Error fetching spots: $e");
      // Don't fail the whole operation if spots fail
    }
  }

  /// Assign spots to their parent areas using point-in-polygon check
  void _assignSpotsToAreas() {
    if (_boundaryData == null) return;

    // Only assign to stadtteile (most granular level)
    final stadtteile = _boundaryData!.stadtteile;
    final spotsPerArea = <int, List<Spot>>{};

    // First pass: assign all spots to areas
    for (final spot in _spots) {
      // Find which stadtteil this spot belongs to
      for (final area in stadtteile) {
        if (_isPointInArea(spot.location, area)) {
          // Update the spot's parentAreaId
          final updatedSpot = Spot(
            id: spot.id,
            name: spot.name,
            category: spot.category,
            location: spot.location,
            description: spot.description,
            tags: spot.tags,
            createdAt: spot.createdAt,
            createdBy: spot.createdBy,
            properties: spot.properties,
            parentAreaId: area.id,
          );

          // Group spots by area
          spotsPerArea.putIfAbsent(area.id, () => []);
          spotsPerArea[area.id]!.add(updatedSpot);
          break; // Found the area, no need to check others
        }
      }
    }

    // Second pass: ensure every area has exactly 1 spot
    final selectedSpots = <Spot>[];
    int nextSpotId = _getNextAvailableSpotId();

    for (final area in stadtteile) {
      final areaSpots = spotsPerArea[area.id] ?? [];

      if (areaSpots.isNotEmpty) {
        // Select the best spot for this area
        final bestSpot = _selectBestSpotForArea(areaSpots);
        selectedSpots.add(bestSpot);
      } else {
        // Create a default spot for areas without any POIs
        final defaultSpot = _createDefaultSpotForArea(area, nextSpotId++);
        selectedSpots.add(defaultSpot);
      }
    }

    // Replace the spots list with only the selected spots
    _spots = selectedSpots;

    print(
      "Selected ${_spots.length} spots (1 per area) from ${spotsPerArea.values.expand((spots) => spots).length} total POIs, created ${selectedSpots.length - spotsPerArea.values.expand((spots) => spots).length} default spots",
    );

    // Recalculate area exploration statistics
    _recalculateAllAreaStats();
  }

  /// Get the next available spot ID to avoid conflicts
  int _getNextAvailableSpotId() {
    if (_spots.isEmpty)
      return 1000000; // Start from a high number for generated spots
    return _spots.map((s) => s.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  /// Create a default spot for an area that has no POIs
  Spot _createDefaultSpotForArea(GeographicArea area, int spotId) {
    final centerPoint = _calculateAreaCenter(area);

    return Spot(
      id: spotId,
      name: "${area.name} Center",
      category: 'viewpoint', // Default to viewpoint for generated spots
      location: centerPoint,
      description: "Explore the center of ${area.name}",
      tags: ['generated', 'area_center'], // List of strings, not map
      createdAt: DateTime.now(),
      createdBy: 'system',
      properties: {'type': 'generated', 'area_id': area.id.toString()},
      parentAreaId: area.id,
    );
  }

  /// Calculate the approximate center of a geographic area
  LatLng _calculateAreaCenter(GeographicArea area) {
    if (area.coordinates.isEmpty || area.coordinates[0].isEmpty) {
      // Fallback to Köln center if no coordinates
      return const LatLng(50.9375, 6.9603);
    }

    // Get the first ring (outer boundary) of the area
    final ring = area.coordinates[0];

    double sumLat = 0;
    double sumLng = 0;
    int count = 0;

    for (final coord in ring) {
      if (coord.length >= 2) {
        sumLng += coord[0]; // longitude
        sumLat += coord[1]; // latitude
        count++;
      }
    }

    if (count == 0) {
      // Fallback to Köln center
      return const LatLng(50.9375, 6.9603);
    }

    return LatLng(sumLat / count, sumLng / count);
  }

  /// Select the best spot to represent an area
  Spot _selectBestSpotForArea(List<Spot> spotsInArea) {
    // Priority order for spot categories (most interesting first)
    const categoryPriority = {
      'viewpoint': 0, // Highest priority - unique experiences
      'restaurant': 1, // High priority - social experiences
      'biergarten': 2, // High priority - local culture
      'cafe': 3, // Medium priority - social spots
      'bar': 4, // Medium priority - nightlife
      'shop': 5, // Lower priority - commercial
    };

    // Sort spots by priority, then by name for consistency
    spotsInArea.sort((a, b) {
      final aPriority = categoryPriority[a.category] ?? 999;
      final bPriority = categoryPriority[b.category] ?? 999;

      if (aPriority != bPriority) {
        return aPriority.compareTo(bPriority);
      }

      // If same priority, prefer spots with names vs "Unnamed Spot"
      if (a.name.startsWith('Unnamed') && !b.name.startsWith('Unnamed')) {
        return 1;
      }
      if (!a.name.startsWith('Unnamed') && b.name.startsWith('Unnamed')) {
        return -1;
      }

      // Finally sort by name for consistency
      return a.name.compareTo(b.name);
    });

    return spotsInArea.first;
  }

  /// Check if a point is inside a geographic area using point-in-polygon algorithm
  bool _isPointInArea(LatLng point, GeographicArea area) {
    for (final ring in area.coordinates) {
      if (ring.isEmpty) continue;

      // Check the first ring (outer boundary)
      if (_isPointInPolygon(point, ring)) {
        return true;
      }
    }
    return false;
  }

  /// Point-in-polygon algorithm using ray casting
  bool _isPointInPolygon(LatLng point, List<List<double>> polygon) {
    if (polygon.length < 3) return false;

    bool inside = false;
    int j = polygon.length - 1;

    for (int i = 0; i < polygon.length; i++) {
      final yi = polygon[i][1]; // latitude
      final xi = polygon[i][0]; // longitude
      final yj = polygon[j][1];
      final xj = polygon[j][0];

      if (((yi > point.latitude) != (yj > point.latitude)) &&
          (point.longitude <
              (xj - xi) * (point.latitude - yi) / (yj - yi) + xi)) {
        inside = !inside;
      }
      j = i;
    }

    return inside;
  }

  /// Toggle city outline visibility
  void toggleCityOutline(bool show) {
    _showCityOutline = show;
    notifyListeners();
  }

  /// Toggle bezirke visibility
  void toggleBezirke(bool show) {
    _showBezirke = show;
    notifyListeners();
  }

  /// Toggle stadtteile visibility
  void toggleStadtteile(bool show) {
    _showStadtteile = show;
    notifyListeners();
  }

  /// Toggle spots visibility (simplified - always true now)
  void toggleSpots(bool show) {
    // Spots are always shown now, but keeping method for compatibility
    notifyListeners();
  }

  /// Get all spots as displayable spots (no filtering needed now)
  List<DisplayableSpot> get filteredDisplayableSpots {
    return _spots.map((spot) {
      final userData = userSpotData[spot.id] ?? UserSpotData(spotId: spot.id);
      return DisplayableSpot(spot: spot, userData: userData);
    }).toList();
  }

  /// Spot interaction methods
  void incrementSpotVisitCount(int spotId) {
    userSpotData.putIfAbsent(spotId, () => UserSpotData(spotId: spotId));
    userSpotData[spotId]!.incrementVisitCount();
    _saveUserSpotData();

    // Update area exploration statistics
    _updateAreaExplorationStats(spotId);

    notifyListeners();
  }

  /// Update area exploration statistics when a spot is visited
  void _updateAreaExplorationStats(int spotId) {
    // Find the spot and its parent area
    final spot = _spots.firstWhere(
      (s) => s.id == spotId,
      orElse: () => throw Exception("Spot $spotId not found"),
    );

    if (spot.parentAreaId == null) return;

    final areaId = spot.parentAreaId!;

    // Calculate total spots and visited spots for this area
    final spotsInArea = _spots.where((s) => s.parentAreaId == areaId).toList();
    final totalSpots = spotsInArea.length;
    final visitedSpots = spotsInArea
        .where(
          (s) =>
              userSpotData[s.id]?.visitCount != null &&
              userSpotData[s.id]!.visitCount > 0,
        )
        .length;

    // Update or create area data
    userAreaVisitData.putIfAbsent(areaId, () => UserAreaData(areaId: areaId));
    userAreaVisitData[areaId]!.updateSpotExploration(
      totalSpotsInArea: totalSpots,
      visitedSpotsInArea: visitedSpots,
    );

    _saveUserVisitData();

    // Log completion achievement
    if (userAreaVisitData[areaId]!.isCompleted) {
      final area = _boundaryData?.stadtteile.firstWhere((a) => a.id == areaId);
      if (area != null) {
        print(
          "🎉 Area completed: ${area.name} ($visitedSpots/$totalSpots spots)",
        );
      }
    }
  }

  /// Recalculate all area exploration statistics
  void _recalculateAllAreaStats() {
    if (_boundaryData == null) return;

    // Process all stadtteile
    for (final area in _boundaryData!.stadtteile) {
      final spotsInArea = _spots
          .where((s) => s.parentAreaId == area.id)
          .toList();
      final totalSpots = spotsInArea.length;
      final visitedSpots = spotsInArea
          .where(
            (s) =>
                userSpotData[s.id]?.visitCount != null &&
                userSpotData[s.id]!.visitCount > 0,
          )
          .length;

      // Update area data
      userAreaVisitData.putIfAbsent(
        area.id,
        () => UserAreaData(areaId: area.id),
      );
      userAreaVisitData[area.id]!.updateSpotExploration(
        totalSpotsInArea: totalSpots,
        visitedSpotsInArea: visitedSpots,
      );
    }

    _saveUserVisitData();
  }

  /// Get areas by exploration status
  List<DisplayableArea> getAreasByStatus(AreaExplorationStatus status) {
    if (_boundaryData == null) return [];

    return _boundaryData!.stadtteile
        .map((area) {
          final userData =
              userAreaVisitData[area.id] ?? UserAreaData(areaId: area.id);
          return DisplayableArea(geoArea: area, userArea: userData);
        })
        .where(
          (displayArea) => displayArea.userArea.explorationStatus == status,
        )
        .toList();
  }

  /// Get exploration statistics summary
  Map<String, int> get explorationStats {
    if (_boundaryData == null) return {};

    final stats = <String, int>{
      'total_areas': 0,
      'unvisited_areas': 0,
      'partial_areas': 0,
      'completed_areas': 0,
      'total_spots': 0,
      'visited_spots': 0,
    };

    for (final area in _boundaryData!.stadtteile) {
      final userData =
          userAreaVisitData[area.id] ?? UserAreaData(areaId: area.id);
      stats['total_areas'] = stats['total_areas']! + 1;
      stats['total_spots'] = stats['total_spots']! + userData.totalSpots;
      stats['visited_spots'] = stats['visited_spots']! + userData.visitedSpots;

      switch (userData.explorationStatus) {
        case AreaExplorationStatus.unvisited:
          stats['unvisited_areas'] = stats['unvisited_areas']! + 1;
          break;
        case AreaExplorationStatus.partial:
          stats['partial_areas'] = stats['partial_areas']! + 1;
          break;
        case AreaExplorationStatus.completed:
          stats['completed_areas'] = stats['completed_areas']! + 1;
          break;
        case AreaExplorationStatus.noSpots:
          // Don't count areas with no spots
          stats['total_areas'] = stats['total_areas']! - 1;
          break;
      }
    }

    return stats;
  }

  void toggleSpotFavorite(int spotId) {
    userSpotData.putIfAbsent(spotId, () => UserSpotData(spotId: spotId));
    userSpotData[spotId]!.isFavorite = !userSpotData[spotId]!.isFavorite;
    _saveUserSpotData();
    notifyListeners();
  }

  void setSpotRating(int spotId, double rating) {
    userSpotData.putIfAbsent(spotId, () => UserSpotData(spotId: spotId));
    userSpotData[spotId]!.userRating = rating;
    _saveUserSpotData();
    notifyListeners();
  }

  /// Select an area for detailed view/interaction
  /// If the same area is already selected, it will be deselected (toggle behavior)
  /// [moveCamera] controls whether the camera should move to fit the selected area
  void selectArea(GeographicArea? area, {bool moveCamera = false}) {
    // Deselect spot when selecting area
    _selectedSpot = null;

    // Toggle behavior: if clicking on already selected area, deselect it
    if (area != null && _rawSelectedArea?.id == area.id) {
      _rawSelectedArea = null;
      _boundsToFit = null;
    } else {
      _rawSelectedArea = area;
      if (area != null) {
        // Only set bounds to fit if camera movement is requested
        if (moveCamera) {
          _boundsToFit = MapRenderingService.calculateBounds([area]);
        }
        // Use the renamed field here
        userAreaVisitData.putIfAbsent(
          area.id,
          () => UserAreaData(areaId: area.id),
        );
      }
    }
    notifyListeners();
  }

  /// Select a spot for detailed view/interaction
  /// If the same spot is already selected, it will be deselected (toggle behavior)
  /// [moveCamera] controls whether the camera should move to center on the spot
  void selectSpot(Spot? spot, {bool moveCamera = false}) {
    // Deselect area when selecting spot
    _rawSelectedArea = null;

    // Toggle behavior: if clicking on already selected spot, deselected it
    if (spot != null && _selectedSpot?.id == spot.id) {
      _selectedSpot = null;
      _boundsToFit = null;
    } else {
      _selectedSpot = spot;
      if (spot != null) {
        // Only set bounds to fit if camera movement is requested
        if (moveCamera) {
          // Create a small bounds around the spot
          const offset = 0.001; // Small offset for zoom
          _boundsToFit = LatLngBounds(
            LatLng(
              spot.location.latitude - offset,
              spot.location.longitude - offset,
            ),
            LatLng(
              spot.location.latitude + offset,
              spot.location.longitude + offset,
            ),
          );
        }
        // Ensure user data exists for the spot
        userSpotData.putIfAbsent(spot.id, () => UserSpotData(spotId: spot.id));
      }
    }
    notifyListeners();
  }

  /// Get animated area layer widget
  Widget get animatedAreaLayer {
    if (_boundaryData == null) return const SizedBox.shrink();

    List<GeographicArea> areasToShow = [];

    if (_showCityOutline) {
      areasToShow.addAll(_boundaryData!.cities);
    }
    if (_showBezirke) {
      areasToShow.addAll(_boundaryData!.bezirke);
    }
    if (_showStadtteile) {
      areasToShow.addAll(_boundaryData!.stadtteile);
    }

    // Get exploration-based area IDs
    final completedAreaIds = <int>{};
    final partialAreaIds = <int>{};
    final unvisitedAreaIds = <int>{};

    for (final area in areasToShow) {
      final userData =
          userAreaVisitData[area.id] ?? UserAreaData(areaId: area.id);
      switch (userData.explorationStatus) {
        case AreaExplorationStatus.completed:
          completedAreaIds.add(area.id);
          break;
        case AreaExplorationStatus.partial:
          partialAreaIds.add(area.id);
          break;
        case AreaExplorationStatus.unvisited:
          unvisitedAreaIds.add(area.id);
          break;
        case AreaExplorationStatus.noSpots:
          // Areas with no spots remain default
          break;
      }
    }

    return MapRenderingService.createAnimatedAreaLayer(
      areas: areasToShow,
      animationDuration: _animationDuration,
      animationCurve: _animationCurve,
      selectedArea: _rawSelectedArea,
      completedAreaIds: completedAreaIds,
      partialAreaIds: partialAreaIds,
      unvisitedAreaIds: unvisitedAreaIds,
      selectionColor: Colors.orange,
      completedColor: Colors.green.shade600,
      partialColor: Colors.amber.shade600,
      unvisitedColor: Colors.grey.shade400,
    );
  }

  // Removed setRenderingMode method since we only use animated rendering now

  // Removed toggleAnimations method since animations are always enabled now

  /// Set animation duration
  void setAnimationDuration(Duration duration) {
    _animationDuration = duration;
    notifyListeners();
  }

  /// Set animation curve
  void setAnimationCurve(Curve curve) {
    _animationCurve = curve;
    notifyListeners();
  }

  /// Animate to a specific area
  void animateToArea(GeographicArea area) {
    selectArea(area);
    // The animated layer will handle the visual animation
    notifyListeners();
  }

  List<Marker> markers = [];
}
