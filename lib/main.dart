import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/data/repositories/map_repository.dart';
import 'package:overpass_map/features/location/data/repositories/location_repository_impl.dart';
import 'package:overpass_map/features/location/domain/repositories/location_repository.dart';
import 'package:overpass_map/features/location/presentation/bloc/location_bloc.dart';
import 'package:overpass_map/features/map_explorer/data/repositories/check_in_repository_impl.dart';
import 'package:overpass_map/features/map_explorer/data/repositories/map_repository_impl.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/map_explorer_screen.dart';
import 'package:overpass_map/services/supabase_api_client.dart';
import 'package:overpass_map/services/sync_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qltlkwnhhomfjdwosbhn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsdGxrd25oaG9tZmpkd29zYmhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI0NDI3MDMsImV4cCI6MjAzODAxODcwM30.sb_publishable_z51aCYNKlxOqpicZFlnfsg_DRLb4CW2',
  );

  // --- Data Layer Setup ---
  final database = AppDatabase();
  final apiClient = SupabaseApiClient(Supabase.instance.client);
  final checkInRepository = CheckInRepositoryImpl(
    database: database,
    uuid: const Uuid(),
  );
  final syncService = SyncService(database: database, apiClient: apiClient);

  // --- Legacy Repository Setup ---
  final mapRepository = MapRepositoryImpl();
  final locationRepository = LocationRepositoryImpl();

  // Perform an initial pull to get the latest data.
  await syncService.pull();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CheckInRepository>.value(value: checkInRepository),
        RepositoryProvider<SyncService>.value(value: syncService),
        RepositoryProvider<MapRepository>.value(value: mapRepository),
        RepositoryProvider<LocationRepository>.value(value: locationRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MapBloc(mapRepository: mapRepository)
              ..add(
                const MapEvent.fetchDataRequested(
                  cityName: 'Köln',
                  adminLevel: 6,
                ),
              ),
          ),
          BlocProvider(
            create: (context) =>
                LocationBloc(locationRepository: locationRepository),
          ),
        ],
        child: const SocialExplorationApp(),
      ),
    ),
  );
}

class SocialExplorationApp extends StatelessWidget {
  const SocialExplorationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapExplorerScreen(),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // ignore: avoid_print
    print(event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // ignore: avoid_print
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
