import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/core/responsive_layout.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/auth/presentation/widgets/user_profile_button.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/layout/desktop_layout.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/layout/mobile_layout.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/shared/status_card.dart';

// The main screen for the map explorer feature
class MapExplorerScreen extends StatelessWidget {
  const MapExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: UserProfileButton(),
          ),
        ],
      ),
      backgroundColor: AppTheme.surfaceColor,
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Initializing BLoC...')),
            loadInProgress: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loadSuccess:
                (
                  boundaryData,
                  spots,
                  selectedArea,
                  selectedSpot,
                  userVisitData,
                  userSpotVisitData,
                ) {
                  return ResponsiveLayout(
                    mobile: MobileLayout(
                      boundaryData: boundaryData,
                      spots: spots,
                      selectedArea: selectedArea,
                      selectedSpot: selectedSpot,
                      userSpotVisitData: userSpotVisitData,
                      userAreaVisitData: userVisitData,
                    ),
                    tablet: MobileLayout(
                      boundaryData: boundaryData,
                      spots: spots,
                      selectedArea: selectedArea,
                      selectedSpot: selectedSpot,
                      userSpotVisitData: userSpotVisitData,
                      userAreaVisitData: userVisitData,
                    ),
                    desktop: DesktopLayout(
                      boundaryData: boundaryData,
                      spots: spots,
                      selectedArea: selectedArea,
                      selectedSpot: selectedSpot,
                      userVisitData: userVisitData,
                      userSpotVisitData: userSpotVisitData,
                    ),
                  );
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
