import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/data/repositories/map_repository.dart';
import 'package:overpass_map/features/map_explorer/data/repositories/map_repository_impl.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_event.dart';
import 'package:overpass_map/features/map_explorer/presentation/map_explorer_screen.dart';

void main() {
  // In a real app, we would use a proper dependency injection setup (like get_it)
  // For now, we'll create the repository here.
  final MapRepository mapRepository = MapRepositoryImpl();

  runApp(
    RepositoryProvider.value(
      value: mapRepository,
      child: BlocProvider(
        create: (context) => MapBloc(mapRepository: mapRepository)
          ..add(
            const MapEvent.fetchDataRequested(
              cityName: 'Köln',
              adminLevel: 6,
            ),
          ),
        child: const MyApp(),
      ),
    ),
  );
}
