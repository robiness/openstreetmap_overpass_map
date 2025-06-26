import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_state.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/layout/desktop_layout.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/layout/mobile_layout.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/shared/status_card.dart';

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
                return MobileLayout(
                  boundaryData: boundaryData,
                  spots: spots,
                  selectedArea: selectedArea,
                );
              } else {
                return DesktopLayout(
                  boundaryData: boundaryData,
                  spots: spots,
                  selectedArea: selectedArea,
                  userVisitData: userVisitData,
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
}
