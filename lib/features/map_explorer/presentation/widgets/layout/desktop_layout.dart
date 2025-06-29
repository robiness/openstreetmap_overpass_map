import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/lists/hierarchical_area_list.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/map_view.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/shared/app_header.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/shared/status_card.dart';
import 'package:overpass_map/features/debug/presentation/widgets/debug_panel.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_state.dart';

class DesktopLayout extends StatelessWidget {
  final BoundaryData boundaryData;
  final List<Spot> spots;
  final GeographicArea? selectedArea;
  final Spot? selectedSpot;
  final Map<int, UserAreaData> userVisitData;
  final Map<int, UserSpotData> userSpotVisitData;

  const DesktopLayout({
    super.key,
    required this.boundaryData,
    required this.spots,
    this.selectedArea,
    this.selectedSpot,
    required this.userVisitData,
    this.userSpotVisitData = const {},
  });

  @override
  Widget build(BuildContext context) {
    final checkInRepository = context.read<CheckInRepository>();

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
                ),
              ),
              // --- Proof of Concept Sync UI ---
              StatusCard(
                color: Colors.amber,
                icon: Icons.sync,
                message: 'Data Sync Controls',
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    final userId = authState.maybeWhen(
                      authenticated: (user, profile) => user.id,
                      orElse: () => 'test-user', // fallback for unauthenticated
                    );

                    return StreamBuilder<List<dynamic>>(
                      stream: checkInRepository.watchUserCheckIns(userId),
                      builder: (context, snapshot) {
                        final count = snapshot.data?.length ?? 0;
                        return Column(
                          children: [
                            Text('Local Check-Ins: $count'),
                            Text('User: $userId'),
                            const SizedBox(height: 8),
                            const DebugPanel(),
                          ],
                        );
                      },
                    );
                  },
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
            selectedSpot: selectedSpot,
            userSpotVisitData: userSpotVisitData,
            userAreaVisitData: userVisitData,
          ),
        ),
      ],
    );
  }
}
