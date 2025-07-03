import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart' hide MapEvent;
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_state.dart';
import 'package:overpass_map/features/debug/presentation/bloc/debug_bloc.dart';
import 'package:overpass_map/features/location/domain/entities/location_data.dart';
import 'package:overpass_map/features/location/presentation/bloc/location_bloc.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_area_layer.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_spot_layer.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_user_location_layer.dart';

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

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
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
          final debugBloc = context.read<DebugBloc>();

          // If in location picking mode, set the debug location
          if (debugBloc.state.isPickingLocation) {
            final locationBloc = context.read<LocationBloc>();
            final newLocation = LocationData(
              latitude: latLng.latitude,
              longitude: latLng.longitude,
              accuracy: 10.0,
              timestamp: DateTime.now(),
              isMocked: true,
            );
            locationBloc.add(
              LocationEvent.setDebugLocation(location: newLocation),
            );
            // Turn off picking mode
            debugBloc.add(const DebugEvent.pickLocationToggled());
          } else {
            // Default behavior: Deselect any selected area/spot
            context.read<MapBloc>().add(
              const MapEvent.areaSelected(area: null),
            );
          }
        },
      ),
      children: [
        // Base tile layer with grayscale filter
        ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            // Grayscale matrix
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0, 0, 0, 1, 0,
          ]),
          child: TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.overpass_map',
            tileProvider: CancellableNetworkTileProvider(),
          ),
        ),

        // Enhanced area layer
        CustomAreaLayer(
          areas: allAreas,
          selectedArea: widget.selectedArea,
          userVisitData: widget.userAreaVisitData ?? {},
          onAreaTap: (area, latLng) {
            final debugBloc = context.read<DebugBloc>();

            if (debugBloc.state.isPickingLocation) {
              // We are in picking mode. Set the location and turn off the mode.
              final locationBloc = context.read<LocationBloc>();
              final newLocation = LocationData(
                latitude: latLng.latitude,
                longitude: latLng.longitude,
                accuracy: 10.0,
                timestamp: DateTime.now(),
                isMocked: true,
              );
              locationBloc.add(
                LocationEvent.setDebugLocation(location: newLocation),
              );
              debugBloc.add(const DebugEvent.pickLocationToggled());
            } else {
              // We are in normal navigation mode. Handle area selection.
              final mapBloc = context.read<MapBloc>();
              if (widget.selectedArea?.id == area.id) {
                // Deselect if tapped again
                mapBloc.add(const MapEvent.areaSelected(area: null));
              } else {
                mapBloc.add(MapEvent.areaSelected(area: area));
              }
            }
          },
        ),

        // Enhanced spot layer with animation
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            final userId = authState.maybeWhen(
              authenticated: (user, profile) => user.id,
              orElse: () => 'test-user', // fallback for unauthenticated
            );

            return StreamBuilder<List<dynamic>>(
              stream: context.read<CheckInRepository>().watchUserCheckIns(
                userId,
              ),
              builder: (context, checkInSnapshot) {
                // Merge check-in data into UserSpotData
                final mergedUserSpotData = <int, UserSpotData>{};
                final baseUserSpotData = widget.userSpotVisitData ?? {};

                // Create a set of checked-in spot IDs
                final checkedInSpotIds = <int>{};
                if (checkInSnapshot.hasData) {
                  for (final checkIn in checkInSnapshot.data!) {
                    if (checkIn.spotId != null) {
                      checkedInSpotIds.add(checkIn.spotId!);
                    }
                  }
                }

                // Merge the data for all spots that appear in the map
                for (final spot in widget.spots) {
                  final baseData = baseUserSpotData[spot.id];
                  final isCheckedIn = checkedInSpotIds.contains(spot.id);

                  if (baseData != null) {
                    // Update existing data with check-in status
                    mergedUserSpotData[spot.id] = baseData.copyWith(
                      isCheckedIn: isCheckedIn,
                    );
                  } else if (isCheckedIn) {
                    // Create new data for checked-in spots that don't have user data yet
                    mergedUserSpotData[spot.id] = UserSpotData(
                      spotId: spot.id,
                      isCheckedIn: true,
                    );
                  }
                }

                return CustomSpotLayer(
                  spots: widget.spots,
                  selectedSpot: widget.selectedSpot,
                  userSpotVisitData: mergedUserSpotData,
                  onSpotTap: (spot) {
                    final bloc = context.read<MapBloc>();
                    if (widget.selectedSpot?.id == spot.id) {
                      // Deselect if tapped again
                      bloc.add(const MapEvent.spotSelected(spot: null));
                    } else {
                      // Select spot and automatically mark as visited
                      bloc.add(MapEvent.spotSelected(spot: spot));
                    }
                  },
                );
              },
            );
          },
        ),

        // Enhanced user location layer
        CustomUserLocationLayer(),
      ],
    );
  }
}
