import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/overpass_api.dart';

import 'models/osm_models.dart';
import 'services/map_rendering_service.dart';

class OverpassMapNotifier extends ChangeNotifier {
  final _api = OverpassApi();

  OverPassAPIResult? _currentResult;

  OverPassAPIResult? get currentBoundaryData => _currentResult;

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
    if (_currentResult == null) return [];

    List<GeographicArea> areasToShow = [];

    if (_showCityOutline) {
      areasToShow.addAll(_currentResult!.boundaryData.cities);
    }
    if (_showBezirke) {
      areasToShow.addAll(_currentResult!.boundaryData.bezirke);
    }
    if (_showStadtteile) {
      areasToShow.addAll(_currentResult!.boundaryData.stadtteile);
    }

    return MapRenderingService.areasToPolygons(areasToShow);
  }

  /// Get markers for area names
  List<Marker> get nameMarkers {
    if (_currentResult == null) return [];

    List<GeographicArea> areasToShow = [];

    if (_showCityOutline) {
      areasToShow.addAll(_currentResult!.boundaryData.cities);
    }
    if (_showBezirke) {
      areasToShow.addAll(_currentResult!.boundaryData.bezirke);
    }
    if (_showStadtteile) {
      areasToShow.addAll(_currentResult!.boundaryData.stadtteile);
    }

    return MapRenderingService.createAreaMarkers(areasToShow);
  }

  /// Fetch city boundary data
  Future<void> fetchCityData(String cityName, int adminLevel) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentResult = await _api.getCityData(cityName, cityAdminLevel: adminLevel);

      // Calculate bounds and trigger map fit
      final allAreas = _currentResult!.boundaryData.cities;
      if (allAreas.isNotEmpty) {
        _boundsToFit = MapRenderingService.calculateBounds(allAreas);
      }

      print(
        'Loaded ${_currentResult!.boundaryData.cities.length} cities, '
        '${_currentResult!.boundaryData.bezirke.length} bezirke, '
        '${_currentResult!.boundaryData.stadtteile.length} stadtteile',
      );
    } catch (e) {
      _error = 'Failed to load data for $cityName: $e';
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleCityOutline(bool show) {
    _showCityOutline = show;
    notifyListeners();
  }

  /// Toggle bezirke visibility
  void toggleSubDistricts(bool show) {
    _showBezirke = show;
    notifyListeners();
  }

  /// Toggle bezirke visibility (new method name)
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
