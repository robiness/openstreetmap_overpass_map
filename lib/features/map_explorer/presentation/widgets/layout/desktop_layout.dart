import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/lists/hierarchical_area_list.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/map_view.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/shared/app_header.dart';

class DesktopLayout extends StatelessWidget {
  final BoundaryData boundaryData;
  final List<Spot> spots;
  final GeographicArea? selectedArea;
  final Map<int, UserAreaData> userVisitData;

  const DesktopLayout({
    super.key,
    required this.boundaryData,
    required this.spots,
    this.selectedArea,
    required this.userVisitData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 400,
          color: AppTheme.cardColor,
          child: Column(
            children: [
              const AppHeader(),
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
        Expanded(
          child: MapView(
            boundaryData: boundaryData,
            spots: spots,
            selectedArea: selectedArea,
          ),
        ),
      ],
    );
  }
}
