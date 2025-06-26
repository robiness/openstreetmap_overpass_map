import 'package:flutter/material.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/map_view.dart';

class MobileLayout extends StatelessWidget {
  final BoundaryData boundaryData;
  final List<Spot> spots;
  final GeographicArea? selectedArea;

  const MobileLayout({
    super.key,
    required this.boundaryData,
    required this.spots,
    this.selectedArea,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Exploration Game'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          MapView(
            boundaryData: boundaryData,
            spots: spots,
            selectedArea: selectedArea,
          ),
          // We can add a bottom sheet here for details
        ],
      ),
      // We could have a drawer with the HierarchicalAreaList
    );
  }
}
