import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/overpass_api.dart';

import 'models/boundary_data.dart';
import 'models/osm_models.dart';
import 'services/map_rendering_service.dart';

class OverpassMapNotifier extends ChangeNotifier {
  final _api = OverpassApi();

  BoundaryData? _boundaryData; // This is now from overpass_json_parser.dart
  BoundaryData? get boundaryData => _boundaryData;

  String _dataSource = "unknown";
  String get dataSource => _dataSource;

  int _dataLoadDuration = 0;
  int get dataLoadDuration => _dataLoadDuration;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _error;

  String? get error => _error;

  // Display toggles
  bool _showCityOutline = false;

  bool get showCityOutline => _showCityOutline;

  bool _showBezirke = true;

  bool get showSubDistricts => _showBezirke; // Keep old name for compatibility
  bool get showBezirke => _showBezirke;

  bool _showStadtteile = false;

  bool get showStadtteile => _showStadtteile;

  // Map interaction
  GeographicArea? _selectedArea;

  GeographicArea? get selectedArea => _selectedArea;

  LatLngBounds? _boundsToFit;

  LatLngBounds? consumeBoundsToFit() {
    final bounds = _boundsToFit;
    _boundsToFit = null;
    return bounds;
  }

  OverpassMapNotifier() {
    fetchCityData("Köln", 6);
  }

  /// Get polygons to display based on current toggle settings
  List<Polygon> get displayedPolygons {
    // if (_currentResult == null) return [];
    if (_boundaryData == null) return [];

    List<GeographicArea> areasToShow = [];

    // Assuming BoundaryData has a way to get these lists (e.g., cities, bezirke, stadtteile)
    // You'll need to adapt this based on your actual BoundaryData structure
    if (_showCityOutline) {
      // areasToShow.addAll(_currentResult!.boundaryData.cities);
      areasToShow.addAll(_boundaryData!.cities);
    }
    if (_showBezirke) {
      // areasToShow.addAll(_currentResult!.boundaryData.bezirke);
      areasToShow.addAll(_boundaryData!.bezirke);
    }
    if (_showStadtteile) {
      // areasToShow.addAll(_currentResult!.boundaryData.stadtteile);
      areasToShow.addAll(_boundaryData!.stadtteile);
    }

    return MapRenderingService.areasToPolygons(areasToShow);
  }

  /// Get markers for area names
  List<Marker> get nameMarkers {
    // if (_currentResult == null) return [];
    if (_boundaryData == null) return [];

    List<GeographicArea> areasToShow = [];

    if (_showCityOutline) {
      // areasToShow.addAll(_currentResult!.boundaryData.cities);
      areasToShow.addAll(_boundaryData!.cities);
    }
    if (_showBezirke) {
      // areasToShow.addAll(_currentResult!.boundaryData.bezirke);
      areasToShow.addAll(_boundaryData!.bezirke);
    }
    if (_showStadtteile) {
      // areasToShow.addAll(_currentResult!.boundaryData.stadtteile);
      areasToShow.addAll(_boundaryData!.stadtteile);
    }

    return MapRenderingService.createAreaMarkers(areasToShow);
  }

  /// Fetch city boundary data
  Future<void> fetchCityData(String cityName, int adminLevel) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _api.getCityData(cityName, cityAdminLevel: adminLevel);
      _boundaryData = result.data;
      _dataSource = result.source;
      _dataLoadDuration = result.duration;

      if (_boundaryData != null) {
        // Construct allElements directly from the BoundaryData fields
        final List<GeographicArea> allElements = [];
        allElements.addAll(_boundaryData!.cities);
        allElements.addAll(_boundaryData!.bezirke);
        allElements.addAll(_boundaryData!.stadtteile);

        if (allElements.isNotEmpty) {
          _boundsToFit = MapRenderingService.calculateBounds(allElements);
        }
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

  /// Select an area for detailed view/interaction
  void selectArea(GeographicArea? area) {
    _selectedArea = area;

    if (area != null) {
      // Fit map to selected area
      _boundsToFit = MapRenderingService.calculateBounds([area]);
    }

    notifyListeners();
  }

  List<Marker> markers = [];
}
