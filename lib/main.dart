import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/config/app_config.dart';
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

  // Load environment variables from .env file (only for non-web platforms)
  if (!kIsWeb) {
    try {
      await dotenv.load(fileName: ".env");
      print('✅ Loaded .env file for native platform');
    } catch (e) {
      print('Warning: Could not load .env file: $e');
    }
  } else {
    print('🌐 Web platform detected - using built-in configuration');
  }

  // Initialize ThemeProvider
  final themeProvider = ThemeProvider();
  await themeProvider.initialize();

  // Validate configuration before initializing Supabase
  AppConfig.validateConfig();
  
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );

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
    db: database,
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
