import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/features/location/presentation/bloc/location_bloc.dart';
import 'package:overpass_map/features/location/domain/entities/location_data.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_user_location_painter.dart';

class CustomUserLocationLayer extends StatelessWidget {
  const CustomUserLocationLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          permissionGranted: () => const SizedBox.shrink(),
          permissionDenied: () => const SizedBox.shrink(),
          locationReceived: (location) =>
              _buildLocationIndicator(context, location),
          error: (message) => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildLocationIndicator(BuildContext context, LocationData location) {
    final camera = MapCamera.of(context);

    return IgnorePointer(
      child: CustomPaint(
        painter: CustomUserLocationPainter(
          location: location,
          camera: camera,
        ),
        size: Size.infinite,
      ),
    );
  }
}
