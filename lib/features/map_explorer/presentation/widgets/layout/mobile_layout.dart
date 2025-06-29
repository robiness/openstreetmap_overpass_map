import 'package:flutter/material.dart';
import 'package:overpass_map/features/debug/presentation/widgets/debug_panel.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/map_view.dart';

class MobileLayout extends StatefulWidget {
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
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  bool _showLocationPanel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapView(
        boundaryData: widget.boundaryData,
        spots: widget.spots,
        selectedArea: widget.selectedArea,
        selectedSpot: widget.selectedSpot,
        userSpotVisitData: widget.userSpotVisitData,
        userAreaVisitData: widget.userAreaVisitData,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "location_fab",
            onPressed: () {
              setState(() {
                _showLocationPanel = !_showLocationPanel;
              });
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              _showLocationPanel ? Icons.close : Icons.location_on,
              color: Colors.white,
            ),
          ),
        ],
      ),
      bottomSheet: _showLocationPanel
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: const DebugPanel(),
            )
          : null,
    );
  }
}
