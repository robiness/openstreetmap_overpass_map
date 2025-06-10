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
  GeographicArea? _previousSelectedArea;

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
          // Calculate appropriate padding based on screen size and mobile layout
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;
          final isMobile = screenWidth < 768;

          EdgeInsets padding;
          if (isMobile) {
            // On mobile, account for app bar and potential bottom sheet
            final appBarHeight = kToolbarHeight;
            final bottomSheetHeight =
                screenHeight *
                0.4; // Estimate bottom sheet takes ~40% of screen
            padding = EdgeInsets.only(
              top: 50.0 + appBarHeight, // Account for app bar
              left: 50.0,
              right: 50.0,
              bottom: 50.0 + bottomSheetHeight, // Account for bottom sheet
            );
          } else {
            // Desktop layout - use original padding
            padding = const EdgeInsets.all(50.0);
          }

          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: boundsToFit,
              padding: padding,
            ),
          );
        }
      });
    }

    // Show bottom sheet on mobile when a new area is selected
    final currentSelectedArea = _mapNotifier.selectedDisplayArea?.geoArea;
    if (mounted &&
        currentSelectedArea != null &&
        currentSelectedArea != _previousSelectedArea) {
      final screenWidth = MediaQuery.of(context).size.width;
      final isMobile = screenWidth < 768;
      if (isMobile) {
        _previousSelectedArea = currentSelectedArea;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showStatusBottomSheet(context, _mapNotifier);
          }
        });
      }
    }
    _previousSelectedArea = currentSelectedArea;
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
        // Responsive breakpoint
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < 768;

        if (isMobile) {
          // Mobile layout: Full screen map with drawer and bottom sheet
          return Scaffold(
            backgroundColor: AppTheme.surfaceColor,
            appBar: AppBar(
              title: const Text('Overpass Map'),
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              actions: [
                if (notifier.selectedDisplayArea?.geoArea != null)
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showStatusBottomSheet(context, notifier),
                    tooltip: 'Show Area Details',
                  ),
              ],
            ),
            drawer: _buildMobileDrawer(notifier),
            body: Stack(
              children: [
                _buildMapView(notifier),
                // Performance overlay for mobile
                perf.PerformanceOverlay(
                  areas: _getAllAreas(notifier),
                  showOverlay: true,
                ),
              ],
            ),
          );
        } else {
          // Desktop layout: Original sidebar layout
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
                                perf.PerformanceOverlay(
                                  areas: _getAllAreas(notifier),
                                  showOverlay: true,
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
        }
      },
    );
  }

  // Mobile drawer containing the area list
  Widget _buildMobileDrawer(OverpassMapNotifier notifier) {
    return Drawer(
      child: Column(
        children: [
          _buildAppHeader(),
          Expanded(
            child: HierarchicalAreaList(
              boundaryData: notifier.boundaryData,
              notifier: notifier,
              selectedArea: notifier.selectedDisplayArea?.geoArea,
            ),
          ),
        ],
      ),
    );
  }

  // Bottom sheet for status card on mobile
  void _showStatusBottomSheet(
    BuildContext context,
    OverpassMapNotifier notifier,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent, // No darkening of background
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: const BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppTheme.radiusXl),
            topRight: Radius.circular(AppTheme.radiusXl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bottom sheet handle
            Container(
              margin: const EdgeInsets.only(top: AppTheme.spacingMd),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: Text(
                      'Area Details',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    color: AppTheme.textSecondary,
                  ),
                ],
              ),
            ),
            // Status card content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacingLg,
                  0,
                  AppTheme.spacingLg,
                  AppTheme.spacingLg,
                ),
                child: StatusCard(notifier: notifier),
              ),
            ),
          ],
        ),
      ),
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
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
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
    final double deltaLatRad =
        (point2.latitude - point1.latitude) * (math.pi / 180);
    final double deltaLngRad =
        (point2.longitude - point1.longitude) * (math.pi / 180);

    final double a =
        math.pow(math.sin(deltaLatRad / 2), 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.pow(math.sin(deltaLngRad / 2), 2);

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
