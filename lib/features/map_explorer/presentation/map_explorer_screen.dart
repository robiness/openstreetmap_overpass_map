import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart' hide MapEvent;
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_event.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_state.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/lists/hierarchical_area_list.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/shared/status_card.dart';

// The root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Exploration Game',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MapExplorerScreen(),
    );
  }
}

// The main screen for the map explorer feature
class MapExplorerScreen extends StatelessWidget {
  const MapExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Initializing BLoC...')),
            loadInProgress: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loadSuccess: (boundaryData, spots, selectedArea, userVisitData) {
              final screenWidth = MediaQuery.of(context).size.width;
              final isMobile = screenWidth < 768;

              if (isMobile) {
                return _buildMobileLayout(
                  context,
                  boundaryData,
                  spots,
                  selectedArea,
                  userVisitData,
                );
              } else {
                return _buildDesktopLayout(
                  context,
                  boundaryData,
                  spots,
                  selectedArea,
                  userVisitData,
                );
              }
            },
            loadFailure: (error) => Center(
              child: StatusCard(
                message: 'Failed to load map data:\n$error',
                color: Colors.red,
                icon: Icons.error_outline,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    BoundaryData boundaryData,
    List<Spot> spots,
    GeographicArea? selectedArea,
    Map<int, UserAreaData> userVisitData,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Exploration Game'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          _buildMapView(boundaryData, spots, selectedArea),
          // We can add a bottom sheet here for details
        ],
      ),
      // We could have a drawer with the HierarchicalAreaList
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    BoundaryData boundaryData,
    List<Spot> spots,
    GeographicArea? selectedArea,
    Map<int, UserAreaData> userVisitData,
  ) {
    return Row(
      children: [
        Container(
          width: 400,
          color: AppTheme.cardColor,
          child: Column(
            children: [
              _buildAppHeader(),
              Expanded(
                child: HierarchicalAreaList(
                  boundaryData: boundaryData,
                  selectedArea: selectedArea,
                  userVisitData: userVisitData,
                  onAreaTapped: (area) => context.read<MapBloc>().add(
                    MapEvent.areaSelected(area: area),
                  ),
                  onIncrementVisit: (areaId) => context.read<MapBloc>().add(
                    MapEvent.incrementAreaVisit(areaId: areaId),
                  ),
                  onDecrementVisit: (areaId) => context.read<MapBloc>().add(
                    MapEvent.decrementAreaVisit(areaId: areaId),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: _buildMapView(boundaryData, spots, selectedArea)),
      ],
    );
  }

  Widget _buildMapView(
    BoundaryData boundaryData,
    List<Spot> spots,
    GeographicArea? selectedArea,
  ) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(50.9375, 6.9603), // Cologne
        initialZoom: 10,
        onTap: (tapPosition, latLng) {
          // TODO: Add tap handling event to BLoC
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.overpass_map',
          tileProvider: CancellableNetworkTileProvider(),
        ),
        // Here we'd add PolygonLayers and MarkerLayers based on the data
      ],
    );
  }

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      color: AppTheme.primaryColor,
      child: const Row(
        children: [
          Icon(Icons.map, color: Colors.white, size: 32),
          SizedBox(width: AppTheme.spacingMd),
          Text(
            'Social Exploration Game',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
