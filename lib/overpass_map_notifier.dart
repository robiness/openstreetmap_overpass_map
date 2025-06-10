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

  // Spot filtering and display
  Set<String> _enabledSpotCategories = {
    'restaurant',
    'cafe',
    'bar',
    'biergarten',
    'viewpoint',
  };
  Set<String> get enabledSpotCategories => _enabledSpotCategories;

  bool _showSpots = true;
  bool get showSpots => _showSpots;

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
        categories: _enabledSpotCategories.toList(),
      );
      notifyListeners();
    } catch (e) {
      print("Error fetching spots: $e");
      // Don't fail the whole operation if spots fail
    }
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

  /// Toggle spots visibility
  void toggleSpots(bool show) {
    _showSpots = show;
    notifyListeners();
  }

  /// Toggle specific spot category
  void toggleSpotCategory(String category, bool enabled) {
    if (enabled) {
      _enabledSpotCategories.add(category);
    } else {
      _enabledSpotCategories.remove(category);
    }
    notifyListeners();
  }

  /// Get filtered spots based on enabled categories
  List<DisplayableSpot> get filteredDisplayableSpots {
    if (!_showSpots) return [];

    return _spots
        .where((spot) => _enabledSpotCategories.contains(spot.category))
        .map((spot) {
          final userData =
              userSpotData[spot.id] ?? UserSpotData(spotId: spot.id);
          return DisplayableSpot(spot: spot, userData: userData);
        })
        .toList();
  }

  /// Spot interaction methods
  void incrementSpotVisitCount(int spotId) {
    userSpotData.putIfAbsent(spotId, () => UserSpotData(spotId: spotId));
    userSpotData[spotId]!.incrementVisitCount();
    _saveUserSpotData();
    notifyListeners();
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
  void selectArea(GeographicArea? area, {bool moveCamera = true}) {
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
  void selectSpot(Spot? spot, {bool moveCamera = true}) {
    // Deselect area when selecting spot
    _rawSelectedArea = null;

    // Toggle behavior: if clicking on already selected spot, deselect it
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

    // Get visited area IDs
    final visitedAreaIds = userAreaVisitData.entries
        .where((entry) => entry.value.visitCount > 0)
        .map((entry) => entry.key)
        .toSet();

    return MapRenderingService.createAnimatedAreaLayer(
      areas: areasToShow,
      animationDuration: _animationDuration,
      animationCurve: _animationCurve,
      selectedArea: _rawSelectedArea,
      visitedAreaIds: visitedAreaIds,
      selectionColor: Colors.orange,
      visitedColor: Colors.purple,
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
