import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/data/osm_models.dart';
import 'package:overpass_map/data/overpass_api.dart';
import 'package:overpass_map/overpass_map_notifier.dart';
import 'package:overpass_map/theme/app_theme.dart';
import 'package:overpass_map/widgets/control_panel.dart';
import 'package:overpass_map/widgets/hierarchical_area_list.dart';
import 'package:overpass_map/widgets/performance_overlay.dart' as perf;
import 'package:overpass_map/widgets/spot_detail_panel.dart';
import 'package:overpass_map/widgets/spot_list.dart';
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
            final bottomSheetHeight = screenHeight * 0.35;
            padding = EdgeInsets.only(
              top: 20.0, // Minimal top padding
              left: 20.0, // Reduced side padding for mobile
              right: 20.0,
              bottom: bottomSheetHeight + 20.0, // Account for bottom sheet + padding
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

    // Show bottom sheet on mobile when a new area or spot is selected
    final currentSelectedArea = _mapNotifier.selectedDisplayArea?.geoArea;
    final currentSelectedSpot = _mapNotifier.selectedDisplaySpot?.spot;

    if (mounted && (currentSelectedArea != null || currentSelectedSpot != null)) {
      final screenWidth = MediaQuery.of(context).size.width;
      final isMobile = screenWidth < 768;
      if (isMobile && currentSelectedArea != _previousSelectedArea) {
        _previousSelectedArea = currentSelectedArea;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showDetailsBottomSheet(context, _mapNotifier);
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
                if (notifier.selectedDisplayArea?.geoArea != null || notifier.selectedDisplaySpot?.spot != null)
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showDetailsBottomSheet(context, notifier),
                    tooltip: 'Show Details',
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
                // Spot detail panel
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: SpotDetailPanel(),
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
                      // Tab bar for Areas vs Spots
                      Container(
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
                        child: DefaultTabController(
                          length: 2,
                          child: TabBar(
                            labelColor: AppTheme.primaryColor,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: AppTheme.primaryColor,
                            tabs: const [
                              Tab(
                                icon: Icon(Icons.location_city),
                                text: 'Areas',
                              ),
                              Tab(icon: Icon(Icons.place), text: 'Spots'),
                            ],
                          ),
                        ),
                      ),
                      // Sidebar content
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: TabBarView(
                            children: [
                              // Areas tab
                              HierarchicalAreaList(
                                boundaryData: notifier.boundaryData,
                                notifier: notifier,
                                selectedArea: notifier.selectedDisplayArea?.geoArea,
                              ),
                              // Spots tab
                              SpotList(showSearchBar: true),
                            ],
                          ),
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
                                // Spot detail panel for desktop
                                Positioned(
                                  bottom: 16,
                                  right: 16,
                                  child: SpotDetailPanel(),
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

  // Mobile drawer containing the area list and spot controls
  Widget _buildMobileDrawer(OverpassMapNotifier notifier) {
    return Drawer(
      child: Column(
        children: [
          _buildAppHeader(),
          // Tab bar for Areas vs Spots
          Container(
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
            child: DefaultTabController(
              length: 2,
              child: TabBar(
                labelColor: AppTheme.primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppTheme.primaryColor,
                tabs: const [
                  Tab(icon: Icon(Icons.location_city), text: 'Areas'),
                  Tab(icon: Icon(Icons.place), text: 'Spots'),
                ],
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: TabBarView(
                children: [
                  // Areas tab
                  HierarchicalAreaList(
                    boundaryData: notifier.boundaryData,
                    notifier: notifier,
                    selectedArea: notifier.selectedDisplayArea?.geoArea,
                  ),
                  // Spots tab
                  Column(
                    children: [
                      // Spot list
                      Expanded(
                        child: SpotList(
                          showSearchBar: true,
                          onSpotTapped: (spot) {
                            // Close drawer when spot is tapped
                            Navigator.of(context).pop();
                          },
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
  }

  // Bottom sheet for details (areas or spots) on mobile
  void _showDetailsBottomSheet(
    BuildContext context,
    OverpassMapNotifier notifier,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent, // No darkening of background
      isDismissible: true, // Allow dismissing by tapping outside
      enableDrag: true, // Allow dragging to dismiss
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.35, // 35% of screen height
        minChildSize: 0.2, // Minimum 20% when collapsed
        maxChildSize: 0.8, // Maximum 80% when expanded
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusXl),
              topRight: Radius.circular(AppTheme.radiusXl),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag handle
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
                      notifier.selectedDisplaySpot != null ? Icons.place : Icons.info_outline,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    Expanded(
                      child: Text(
                        notifier.selectedDisplaySpot != null ? 'Spot Details' : 'Area Details',
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
              // Content (spot details or area status card)
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(
                    AppTheme.spacingLg,
                    0,
                    AppTheme.spacingLg,
                    AppTheme.spacingLg,
                  ),
                  child: notifier.selectedDisplaySpot != null ? SpotDetailPanel() : StatusCard(notifier: notifier),
                ),
              ),
            ],
          ),
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
              color: Colors.white.withValues(alpha: 0.2),
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
                    color: Colors.white.withValues(alpha: 0.8),
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
              border: Border.all(color: AppTheme.errorColor.withValues(alpha: 0.3)),
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
        // Add spot markers
        MarkerLayer(
          markers: [
            ...notifier.spotMarkers,
          ],
        ),
      ],
    );
  }

  void _handleMapTap(OverpassMapNotifier notifier, LatLng latLng) {
    if (notifier.boundaryData == null) return;

    // Only check stadtteile for map taps - most precise level
    final stadtteile = notifier.boundaryData!.stadtteile;

    GeographicArea? tappedArea;

    // Check if the tap point is inside any stadtteil polygon
    for (final area in stadtteile) {
      if (_isPointInArea(latLng, area)) {
        tappedArea = area;
        break; // Found the area, no need to check others
      }
    }

    // Select the exact area that was tapped
    if (tappedArea != null) {
      notifier.selectArea(tappedArea, moveCamera: false);
    }
  }

  /// Check if a point is inside a geographic area using point-in-polygon algorithm
  bool _isPointInArea(LatLng point, GeographicArea area) {
    if (area.coordinates.isEmpty) return false;

    // Check each ring (outer boundary and holes)
    for (int ringIndex = 0; ringIndex < area.coordinates.length; ringIndex++) {
      final ring = area.coordinates[ringIndex];
      if (ring.isEmpty) continue;

      final isInside = _isPointInPolygon(point, ring);

      if (ringIndex == 0) {
        // First ring is the outer boundary
        if (!isInside) return false; // Point must be inside outer boundary
      } else {
        // Subsequent rings are holes
        if (isInside) return false; // Point must NOT be inside holes
      }
    }

    return true; // Point is inside outer boundary and not in any holes
  }

  /// Point-in-polygon algorithm using ray casting
  bool _isPointInPolygon(LatLng point, List<List<double>> polygon) {
    if (polygon.length < 3) {
      return false; // Need at least 3 points for a polygon
    }

    bool inside = false;
    int j = polygon.length - 1;

    for (int i = 0; i < polygon.length; j = i++) {
      final xi = polygon[i][1]; // latitude
      final yi = polygon[i][0]; // longitude
      final xj = polygon[j][1]; // latitude
      final yj = polygon[j][0]; // longitude

      if (((yi > point.longitude) != (yj > point.longitude)) &&
          (point.latitude < (xj - xi) * (point.longitude - yi) / (yj - yi) + xi)) {
        inside = !inside;
      }
    }

    return inside;
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
