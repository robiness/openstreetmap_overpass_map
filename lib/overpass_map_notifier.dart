import 'package:flutter/material.dart'; // For UI elements in nameMarkers
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/overpass_api.dart';

class OverpassMapNotifier extends ChangeNotifier {
  final OverpassApi _api = OverpassApi();

  String? _cityDataResponse;
  String? get cityDataResponse => _cityDataResponse;

  String? _sentQuery;
  String? get sentQuery => _sentQuery;

  List<Polygon> _cityPolygons = [];
  List<Polygon> get cityPolygons => List.unmodifiable(_cityPolygons);

  List<Polygon> _subDistrictPolygons = [];
  List<Polygon> get subDistrictPolygons => List.unmodifiable(_subDistrictPolygons);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _showCityOutline = false;
  bool get showCityOutline => _showCityOutline;

  bool _showSubDistricts = true;
  bool get showSubDistricts => _showSubDistricts;

  LatLngBounds? _boundsToFit;
  LatLngBounds? consumeBoundsToFit() {
    final bounds = _boundsToFit;
    _boundsToFit = null;
    return bounds;
  }

  OverpassMapNotifier() {
    fetchCityData("Köln", 6);
  }

  List<Polygon> get displayedPolygons {
    List<Polygon> polygons = [];
    if (_showCityOutline) polygons.addAll(_cityPolygons);
    if (_showSubDistricts) polygons.addAll(_subDistrictPolygons);
    return polygons;
  }

  List<Marker> get nameMarkers {
    List<Marker> markers = [];
    for (var polygon in displayedPolygons) {
      if (polygon.points.isNotEmpty && polygon.label != null) {
        double avgLat = polygon.points.map((p) => p.latitude).reduce((a, b) => a + b) / polygon.points.length;
        double avgLng = polygon.points.map((p) => p.longitude).reduce((a, b) => a + b) / polygon.points.length;

        markers.add(
          Marker(
            width: 120.0,
            height: 40.0,
            point: LatLng(avgLat, avgLng),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Center(
                child: Text(
                  polygon.label!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
        );
      }
    }
    return markers;
  }

  Future<void> fetchCityData(String cityName, int adminLevel) async {
    _isLoading = true;
    _error = null;
    _cityDataResponse = null;
    _sentQuery = null;
    _cityPolygons = [];
    _subDistrictPolygons = [];
    _boundsToFit = null;
    notifyListeners();

    try {
      final Map<String, dynamic> responseMap = await _api.getCityOutline(cityName, adminLevel: adminLevel);

      _cityDataResponse = responseMap['result'] as String?;
      _sentQuery = responseMap['query'] as String?;
      // Ensure correct casting for polygon lists
      _cityPolygons = (responseMap['cityPolygons'] as List?)?.whereType<Polygon>().toList() ?? [];
      _subDistrictPolygons = (responseMap['subDistrictPolygons'] as List?)?.whereType<Polygon>().toList() ?? [];

      List<Polygon> polygonsForFit = _cityPolygons.isNotEmpty ? _cityPolygons : _subDistrictPolygons;
      List<LatLng> allPointsForFit = [];
      for (var p in polygonsForFit) {
        allPointsForFit.addAll(p.points);
      }

      if (allPointsForFit.isNotEmpty) {
        _boundsToFit = LatLngBounds.fromPoints(allPointsForFit);
      } else {
        _boundsToFit = null;
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = "Fehler beim Abrufen der Daten: $e";
      _isLoading = false;
      _boundsToFit = null;
      notifyListeners();
    }
  }

  void toggleCityOutline(bool show) {
    _showCityOutline = show;
    notifyListeners();
  }

  void toggleSubDistricts(bool show) {
    _showSubDistricts = show;
    notifyListeners();
  }
}
