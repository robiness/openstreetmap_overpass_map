import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/core/responsive_layout.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_state.dart';
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
    final appTheme = context.appTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.background,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: UserProfileButton(),
          ),
        ],
      ),
      backgroundColor: appTheme.background,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          // When user authenticates, reload map data with user ID
          authState.whenOrNull(
            authenticated: (user, profile) {
              context.read<MapBloc>().add(
                MapEvent.fetchDataRequested(
                  cityName: 'Köln',
                  adminLevel: 6,
                  userId: user.id,
                ),
              );
            },
            unauthenticated: () {
              // When user logs out, reload map data without user ID
              context.read<MapBloc>().add(
                const MapEvent.fetchDataRequested(
                  cityName: 'Köln',
                  adminLevel: 6,
                ),
              );
            },
          );
        },
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('Initializing BLoC...')),
              loadInProgress: () => const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    Text('WE LOADING? WHY!'),
                  ],
                ),
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
                        userAreaData: userVisitData,
                        userSpotVisitData: userSpotVisitData,
                        onAreaTapped: (area) {
                          print('Area tapped in DesktopLayout: ${area.name}');
                          context.read<MapBloc>().add(
                            MapEvent.areaSelected(area: area),
                          );
                        },
                        onSpotTapped: (spot) => context.read<MapBloc>().add(
                          MapEvent.spotSelected(spot: spot),
                        ),
                      ),
                    );
                  },
              loadFailure: (error) => Center(
                child: StatusCard(
                  message: 'Failed to load map data:\n$error',
                  color: appTheme.error,
                  icon: Icons.error_outline,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
