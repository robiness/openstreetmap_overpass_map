import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/models/osm_models.dart';
import 'package:overpass_map/overpass_api.dart'; // Import OverpassApi
import 'package:overpass_map/overpass_map_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => OverpassMapNotifier(OverpassApi()), // New: Provide real OverpassApi
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
          body: Column(
            children: [
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
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Text(
                  'Data from: ${notifier.dataSource}, Load time: ${notifier.dataLoadDuration}ms',
                  style: const TextStyle(fontSize: 10),
                ),
              ),
              // Selected Area Info and Visit Count Modifier
              if (notifier.selectedDisplayArea != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected: ${notifier.selectedDisplayArea!.name}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Visits: ${notifier.selectedDisplayArea!.visitCount}'),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                notifier.decrementVisitCount(notifier.selectedDisplayArea!.id);
                              },
                              tooltip: 'Decrement Visits',
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                notifier.incrementVisitCount(notifier.selectedDisplayArea!.id);
                              },
                              tooltip: 'Increment Visits',
                            ),
                          ],
                        ),
                      ],
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
                          _isMapReady = true;
                        });
                        _handleNotifierChanges();
                      },
                      onTap: (tapPosition, latLng) {
                        // Simple tap handling: find the closest area and select it
                        // This is a basic implementation. For more accuracy, you might need a point-in-polygon check.
                        if (notifier.boundaryData != null) {
                          final allGeoAreas = [
                            ...notifier.boundaryData!.cities,
                            ...notifier.boundaryData!.bezirke,
                            ...notifier.boundaryData!.stadtteile,
                          ];
                          GeographicArea? tappedArea;
                          double minDistance = double.infinity;

                          for (final area in allGeoAreas) {
                            // Calculate center of area (simplistic)
                            if (area.coordinates.isNotEmpty && area.coordinates.first.isNotEmpty) {
                              double areaLat = 0;
                              double areaLng = 0;
                              int pointCount = 0;
                              for (var ring in area.coordinates) {
                                for (var coord in ring) {
                                  areaLng += coord[0];
                                  areaLat += coord[1];
                                  pointCount++;
                                }
                              }
                              if (pointCount > 0) {
                                final center = LatLng(areaLat / pointCount, areaLng / pointCount);
                                final distance = const Distance().as(LengthUnit.Kilometer, center, latLng);
                                if (distance < minDistance) {
                                  minDistance = distance;
                                  // Heuristic: if tap is within a certain "radius" of the center.
                                  // This is very rough. A proper point-in-polygon test is needed for accuracy.
                                  // For simplicity, we'll use a generous threshold or select the closest one.
                                  // Let's consider a tap "close enough" if it's the closest and within a few km of its center.
                                  // This threshold would depend on zoom level and area sizes.
                                  // For now, just select the closest one found.
                                  tappedArea = area;
                                }
                              }
                            }
                          }
                          notifier.selectArea(tappedArea);
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                      ),
                      PolygonLayer(polygons: notifier.displayedPolygons),
                      // MarkerLayer(markers: notifier.nameMarkers),
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
