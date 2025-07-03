import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/data/repositories/map_repository.dart';
import 'package:overpass_map/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:overpass_map/features/auth/domain/repositories/auth_repository.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/debug/presentation/bloc/debug_bloc.dart';
import 'package:overpass_map/features/location/data/repositories/location_repository_impl.dart';
import 'package:overpass_map/features/location/domain/repositories/location_repository.dart';
import 'package:overpass_map/features/location/presentation/bloc/location_bloc.dart';
import 'package:overpass_map/features/map_explorer/data/repositories/check_in_repository_impl.dart';
import 'package:overpass_map/features/map_explorer/data/repositories/supabase_map_repository_impl.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/map_explorer_screen.dart';
import 'package:overpass_map/services/supabase_api_client.dart';
import 'package:overpass_map/services/sync_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ThemeProvider
  final themeProvider = ThemeProvider();
  await themeProvider.initialize();

  await Supabase.initialize(
    url: 'https://qltlkwnhhomfjdwosbhn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsdGxrd25oaG9tZmpkd29zYmhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMzc3NTEsImV4cCI6MjA2NjcxMzc1MX0.N0iIz79hGhlOth2jRTsUbrtrzp2M1pWjdi8nGwBfmMk',
  );
  // It's important to wait for the Supabase client to be fully initialized
  // and for the session to be restored.
  await Future.delayed(const Duration(milliseconds: 200));

  // --- Data Layer Setup ---
  final database = AppDatabase();
  final apiClient = SupabaseApiClient(Supabase.instance.client);
  final authRepository = AuthRepositoryImpl(
    supabaseClient: Supabase.instance.client,
  );
  final checkInRepository = CheckInRepositoryImpl(
    database: database,
    uuid: const Uuid(),
  );
  final syncService = SyncService(
    database: database,
    apiClient: apiClient,
    checkInRepository: checkInRepository,
    authRepository: authRepository,
  );

  // --- Repository Setup ---
  final mapRepository = SupabaseMapRepositoryImpl(
    supabaseClient: Supabase.instance.client,
  );
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
        RepositoryProvider<AuthRepository>.value(value: authRepository),
      ],
      child: AppThemeProvider(
        provider: themeProvider,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) =>
                  LocationBloc(locationRepository: locationRepository),
            ),
            BlocProvider(
              create: (context) =>
                  MapBloc(
                    mapRepository: mapRepository,
                    database: database,
                    checkInRepository: context.read<CheckInRepository>(),
                  )..add(
                    const MapEvent.fetchDataRequested(
                      cityName: 'Köln',
                      adminLevel: 6,
                    ),
                  ),
            ),
            BlocProvider(
              create: (context) => DebugBloc(
                checkInRepository: context.read<CheckInRepository>(),
                syncService: context.read<SyncService>(),
              ),
            ),
          ],
          child: const AppView(),
        ),
      ),
    ),
  );
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.themeProvider.toMaterialTheme(),
      home: const MapExplorerScreen(),
      debugShowCheckedModeBanner: false,
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
