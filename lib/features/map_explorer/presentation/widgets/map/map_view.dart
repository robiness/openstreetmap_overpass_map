import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart' hide MapEvent;
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_area_layer.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_spot_layer.dart';

class MapView extends StatefulWidget {
  final BoundaryData boundaryData;
  final List<Spot> spots;
  final GeographicArea? selectedArea;
  final Spot? selectedSpot;
  final Map<int, UserSpotData>? userSpotVisitData;
  final Map<int, UserAreaData>? userAreaVisitData;

  const MapView({
    super.key,
    required this.boundaryData,
    required this.spots,
    this.selectedArea,
    this.selectedSpot,
    this.userSpotVisitData,
    this.userAreaVisitData,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Combine all boundaries into a single list to be drawn
    final allAreas = [
      ...widget.boundaryData.cities,
      ...widget.boundaryData.bezirke,
      ...widget.boundaryData.stadtteile,
    ];

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: const LatLng(50.9375, 6.9603), // Cologne
        initialZoom: 11,
        minZoom: 8,
        maxZoom: 18,
        onTap: (tapPosition, latLng) {
          // Deselect both area and spot if tapping on the map background
          final bloc = context.read<MapBloc>();
          bloc.add(const MapEvent.areaSelected(area: null));
          bloc.add(const MapEvent.spotSelected(spot: null));
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.overpass_map',
          tileProvider: CancellableNetworkTileProvider(),
        ),
        CustomAreaLayer(
          areas: allAreas,
          selectedArea: widget.selectedArea,
          userVisitData: widget.userAreaVisitData ?? {},
          onAreaTap: (area) {
            final bloc = context.read<MapBloc>();
            if (widget.selectedArea?.id == area.id) {
              // Deselect if tapped again
              bloc.add(const MapEvent.areaSelected(area: null));
            } else {
              bloc.add(MapEvent.areaSelected(area: area));
            }
            // Also deselect any selected spot when selecting an area
            bloc.add(const MapEvent.spotSelected(spot: null));
          },
        ),
        CustomSpotLayer(
          spots: widget.spots,
          selectedSpot: widget.selectedSpot,
          userSpotVisitData: widget.userSpotVisitData ?? {},
          onSpotTap: (spot) {
            final bloc = context.read<MapBloc>();
            if (widget.selectedSpot?.id == spot.id) {
              // Deselect if tapped again
              bloc.add(const MapEvent.spotSelected(spot: null));
            } else {
              // Select spot and automatically mark as visited
              bloc.add(MapEvent.spotSelected(spot: spot));
            }
            // Also deselect any selected area when selecting a spot
            bloc.add(const MapEvent.areaSelected(area: null));
          },
        ),
      ],
    );
  }
}
