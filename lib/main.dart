import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/models/osm_models.dart';
import 'package:overpass_map/overpass_api.dart';
import 'package:overpass_map/overpass_map_notifier.dart';
import 'package:overpass_map/theme/app_theme.dart';
import 'package:overpass_map/widgets/control_panel.dart';
import 'package:overpass_map/widgets/hierarchical_area_list.dart';
import 'package:overpass_map/widgets/performance_overlay.dart' as perf;
import 'package:overpass_map/widgets/status_card.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => OverpassMapNotifier(OverpassApi()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overpass Map Explorer',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MapExplorerScreen(),
    );
  }
}

class MapExplorerScreen extends StatefulWidget {
  const MapExplorerScreen({super.key});

  @override
  State<MapExplorerScreen> createState() => _MapExplorerScreenState();
}

class _MapExplorerScreenState extends State<MapExplorerScreen> {
  final MapController _mapController = MapController();
  late OverpassMapNotifier _mapNotifier;
  bool _isMapReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mapNotifier = Provider.of<OverpassMapNotifier>(context, listen: false);
    _mapNotifier.addListener(_handleNotifierChanges);
  }

  void _handleNotifierChanges() {
    final boundsToFit = _mapNotifier.consumeBoundsToFit();
    if (boundsToFit != null && mounted && _isMapReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isMapReady) {
          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: boundsToFit,
              padding: const EdgeInsets.all(50.0),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _mapNotifier.removeListener(_handleNotifierChanges);
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OverpassMapNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          backgroundColor: AppTheme.surfaceColor,
          body: Row(
            children: [
              // Sidebar
              Container(
                width: 400,
                decoration: const BoxDecoration(
                  color: AppTheme.cardColor,
                  border: Border(
                    right: BorderSide(color: AppTheme.borderColor),
                  ),
                ),
                child: Column(
                  children: [
                    // App header
                    _buildAppHeader(),

                    // Sidebar content
                    Expanded(
                      child: HierarchicalAreaList(
                        boundaryData: notifier.boundaryData,
                        notifier: notifier,
                        selectedArea: notifier.selectedDisplayArea?.geoArea,
                      ),
                    ),
                  ],
                ),
              ),

              // Main content area
              Expanded(
                child: Column(
                  children: [
                    // Top controls
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingLg),
                      decoration: const BoxDecoration(
                        color: AppTheme.cardColor,
                        border: Border(
                          bottom: BorderSide(color: AppTheme.borderColor),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: ControlPanel(notifier: notifier)),
                          const SizedBox(width: AppTheme.spacingLg),
                          Expanded(child: StatusCard(notifier: notifier)),
                        ],
                      ),
                    ),

                    // Map view
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(AppTheme.spacingLg),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLg,
                          ),
                          boxShadow: AppTheme.shadowMd,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLg,
                          ),
                          child: Stack(
                            children: [
                              _buildMapView(notifier),
                              // Performance overlay - shows stats in debug mode
                              perf.PerformanceOverlay(
                                areas: _getAllAreas(notifier),
                                showOverlay: true, // Set to false to disable
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
        border: Border(bottom: BorderSide(color: AppTheme.borderColor)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: const Icon(Icons.map, color: Colors.white, size: 24),
          ),

          const SizedBox(width: AppTheme.spacingMd),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overpass Map',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Geographic Boundary Explorer',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView(OverpassMapNotifier notifier) {
    if (notifier.isLoading) {
      return Container(
        color: AppTheme.surfaceColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingXl),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  boxShadow: AppTheme.shadowLg,
                ),
                child: Column(
                  children: [
                    const CircularProgressIndicator(strokeWidth: 3),
                    const SizedBox(height: AppTheme.spacingLg),
                    Text(
                      'Loading Geographic Data...',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingSm),
                    Text(
                      'Fetching boundary information from Overpass API',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (notifier.error != null) {
      return Container(
        color: AppTheme.surfaceColor,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(AppTheme.spacingXl),
            padding: const EdgeInsets.all(AppTheme.spacingXl),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              boxShadow: AppTheme.shadowLg,
              border: Border.all(color: AppTheme.errorColor.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48, color: AppTheme.errorColor),
                const SizedBox(height: AppTheme.spacingLg),
                Text(
                  'Error Loading Data',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.errorColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                Text(
                  notifier.error!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingXl),
                ElevatedButton.icon(
                  onPressed: () {
                    // Trigger data reload if such method exists
                    // notifier.reloadData();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: const LatLng(50.9375, 6.9603), // Cologne
        initialZoom: 10.0,
        onMapReady: () {
          setState(() {
            _isMapReady = true;
          });
          _handleNotifierChanges();
        },
        onTap: (tapPosition, latLng) {
          _handleMapTap(notifier, latLng);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.overpass_map',
          tileProvider: CancellableNetworkTileProvider(),
        ),
        // Use the animated area layer
        RepaintBoundary(child: notifier.animatedAreaLayer),
      ],
    );
  }

  void _handleMapTap(OverpassMapNotifier notifier, LatLng latLng) {
    if (notifier.boundaryData == null) return;

    final allGeoAreas = [
      ...notifier.boundaryData!.cities,
      ...notifier.boundaryData!.bezirke,
      ...notifier.boundaryData!.stadtteile,
    ];

    GeographicArea? tappedArea;
    double minDistance = double.infinity;

    for (final area in allGeoAreas) {
      if (area.coordinates.isNotEmpty && area.coordinates.first.isNotEmpty) {
        // Calculate center of area (basic implementation)
        double areaLat = 0;
        double areaLng = 0;
        int pointCount = 0;

        for (var ring in area.coordinates) {
          for (var coord in ring) {
            areaLng += coord[0];
            areaLat += coord[1];
            pointCount++;
          }
        }

        if (pointCount > 0) {
          final center = LatLng(areaLat / pointCount, areaLng / pointCount);

          // Calculate distance using Haversine formula
          final distance = _calculateDistance(center, latLng);

          if (distance < minDistance) {
            minDistance = distance;
            tappedArea = area;
          }
        }
      }
    }

    // Select the closest area (within reasonable distance)
    if (minDistance < 5.0) {
      // Within 5km
      notifier.selectArea(tappedArea);
    }
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    // Simple distance calculation using Haversine formula
    const double earthRadius = 6371; // Earth radius in kilometers

    final double lat1Rad = point1.latitude * (math.pi / 180);
    final double lat2Rad = point2.latitude * (math.pi / 180);
    final double deltaLatRad = (point2.latitude - point1.latitude) * (math.pi / 180);
    final double deltaLngRad = (point2.longitude - point1.longitude) * (math.pi / 180);

    final double a =
        math.pow(math.sin(deltaLatRad / 2), 2) +
        math.cos(lat1Rad) * math.cos(lat2Rad) * math.pow(math.sin(deltaLngRad / 2), 2);

    final double c = 2 * math.asin(math.sqrt(a));

    return earthRadius * c;
  }

  /// Get all areas for performance monitoring
  List<GeographicArea> _getAllAreas(OverpassMapNotifier notifier) {
    if (notifier.boundaryData == null) return [];

    return [
      ...notifier.boundaryData!.cities,
      ...notifier.boundaryData!.bezirke,
      ...notifier.boundaryData!.stadtteile,
    ];
  }
}
