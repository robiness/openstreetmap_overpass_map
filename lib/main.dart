import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/overpass_map_notifier.dart'; // Importiere den Notifier
import 'package:provider/provider.dart'; // Importiere Provider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => OverpassMapNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Optional, für modernen Look
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MapController _mapController = MapController();
  late OverpassMapNotifier _mapNotifier; // Für den Zugriff im initState/didChangeDependencies
  bool _isMapReady = false; // Flag für den Kartenstatus

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Notifier initialisieren und Listener hinzufügen
    // Dies wird nach initState und wenn sich Dependencies ändern aufgerufen
    _mapNotifier = Provider.of<OverpassMapNotifier>(context, listen: false);
    _mapNotifier.addListener(_handleNotifierChanges);
  }

  void _handleNotifierChanges() {
    // Prüfen, ob die Kamera angepasst werden muss
    final boundsToFit = _mapNotifier.consumeBoundsToFit();
    if (boundsToFit != null && mounted && _isMapReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isMapReady) {
          // Korrektur: _isMapReady verwenden
          _mapController.fitCamera(CameraFit.bounds(bounds: boundsToFit, padding: const EdgeInsets.all(50.0)));
        }
      });
    }
  }

  @override
  void dispose() {
    _mapNotifier.removeListener(_handleNotifierChanges);
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Consumer verwenden, um auf Änderungen im Notifier zu reagieren und die UI neu zu erstellen
    return Consumer<OverpassMapNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Overpass Map Explorer"),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => notifier.fetchCityData("Berlin", 4),
                      child: const Text('Berlin (4)'),
                    ),
                    ElevatedButton(onPressed: () => notifier.fetchCityData("Köln", 6), child: const Text('Köln (6)')),
                    ElevatedButton(
                      onPressed: () => notifier.fetchCityData("Bonn", 6),
                      child: const Text('Bonn (6)'),
                    ),
                    ElevatedButton(
                      onPressed: () => notifier.fetchCityData("Bornheim", 8),
                      child: const Text('Bornheim (8)'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: notifier.showCityOutline,
                      onChanged: (bool? value) {
                        notifier.toggleCityOutline(value ?? false);
                      },
                    ),
                    const Text('Stadtumriss'),
                    const SizedBox(width: 20),
                    Checkbox(
                      value: notifier.showBezirke,
                      onChanged: (bool? value) {
                        notifier.toggleBezirke(value ?? false);
                      },
                    ),
                    const Text('Bezirke'),
                    const SizedBox(width: 20),
                    Checkbox(
                      value: notifier.showStadtteile,
                      onChanged: (bool? value) {
                        notifier.toggleStadtteile(value ?? false);
                      },
                    ),
                    const Text('Stadtteile'),
                  ],
                ),
              ),
              // Debug Info Area
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'Data from: ${notifier.dataSource}, Load time: ${notifier.dataLoadDuration}ms',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              if (notifier.isLoading)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else if (notifier.error != null)
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        notifier.error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: const LatLng(50.9375, 6.9603), // Default to Cologne
                      initialZoom: 10.0,
                      onMapReady: () {
                        setState(() {
                          _isMapReady = true; // Map ist bereit
                        });
                        // Trigger bounds fit if available after map is ready
                        _handleNotifierChanges();
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                      ),
                      PolygonLayer(polygons: notifier.displayedPolygons),
                      MarkerLayer(markers: notifier.nameMarkers),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
