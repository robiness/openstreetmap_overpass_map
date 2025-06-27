import 'package:flutter/material.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/map_view.dart';

class MobileLayout extends StatelessWidget {
  final BoundaryData boundaryData;
  final List<Spot> spots;
  final GeographicArea? selectedArea;
  final Spot? selectedSpot;
  final Map<int, UserSpotData> userSpotVisitData;
  final Map<int, UserAreaData> userAreaVisitData;

  const MobileLayout({
    super.key,
    required this.boundaryData,
    required this.spots,
    this.selectedArea,
    this.selectedSpot,
    this.userSpotVisitData = const {},
    this.userAreaVisitData = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapView(
        boundaryData: boundaryData,
        spots: spots,
        selectedArea: selectedArea,
        selectedSpot: selectedSpot,
        userSpotVisitData: userSpotVisitData,
        userAreaVisitData: userAreaVisitData,
      ),
    );
  }
}
