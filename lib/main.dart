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
          appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
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
                    ), // Geändert von Bonn zu Buenos Aires, Admin-Level vorerst auf 4 gesetzt
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
                      value: notifier.showSubDistricts,
                      onChanged: (bool? value) {
                        notifier.toggleSubDistricts(value ?? false);
                      },
                    ),
                    const Text('Bezirke'),
                  ],
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
                      onMapReady: () {
                        // Callback für Kartenbereitschaft
                        setState(() {
                          _isMapReady = true;
                        });
                        // Wenn es ausstehende boundsToFit gibt, jetzt anwenden
                        // Dies ist nützlich, wenn der Notifier die Daten bereits geladen hat,
                        // bevor die Karte initialisiert wurde.
                        final initialBounds = _mapNotifier.consumeBoundsToFit();
                        if (initialBounds != null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted && _isMapReady) {
                              _mapController.fitCamera(
                                CameraFit.bounds(bounds: initialBounds, padding: const EdgeInsets.all(50.0)),
                              );
                            }
                          });
                        }
                      },
                      initialCenter:
                          notifier.displayedPolygons.isNotEmpty && notifier.displayedPolygons.first.points.isNotEmpty
                          ? LatLngBounds.fromPoints(notifier.displayedPolygons.expand((p) => p.points).toList())
                                .center // Zentriere auf alle angezeigten Polygone
                          : const LatLng(51.5, -0.09),
                      initialZoom: notifier.displayedPolygons.isNotEmpty ? 10.0 : 6.0,
                      // Die Kamera wird jetzt durch _handleNotifierChanges angepasst
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                      ),
                      if (notifier.displayedPolygons.isNotEmpty) PolygonLayer(polygons: notifier.displayedPolygons),
                      if (notifier.nameMarkers.isNotEmpty) MarkerLayer(markers: notifier.nameMarkers),
                    ],
                  ),
                ),
              if (!notifier.isLoading &&
                  notifier.error == null &&
                  (notifier.sentQuery != null || notifier.cityDataResponse != null))
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  // Höhe etwas reduziert
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (notifier.sentQuery != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Gesendete Abfrage:",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  child: SelectableText(
                                    notifier.sentQuery!,
                                    style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (notifier.cityDataResponse != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Rohe JSON Antwort:",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: SelectableText(
                                  notifier.cityDataResponse!,
                                  style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
