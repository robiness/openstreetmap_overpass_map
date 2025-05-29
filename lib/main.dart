import 'package:flutter/material.dart';
import 'package:overpass_map/overpass_api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final OverpassApi _api = OverpassApi();
  String? _cityData;
  String? _sentQuery;
  List<Polygon> _polygons = []; // Zum Speichern der geparsten Polygone
  bool _isLoading = false;
  String? _error;
  MapController _mapController = MapController(); // Für die Kartensteuerung

  // Stelle sicher, dass _cityData und _sentQuery im State vorhanden sind und verwendet werden
  // (sollten bereits aus vorherigen Schritten vorhanden sein)

  Future<void> _fetchCityData(String cityName, int adminLevel) async {
    setState(() {
      _isLoading = true;
      _error = null;
      // _cityData und _sentQuery werden hier explizit auf null gesetzt, um alte Daten zu löschen
      _cityData = null; 
      _sentQuery = null;
      _polygons = []; // Polygone zurücksetzen
    });
    try {
      final responseMap = await _api.getCityOutline(cityName, adminLevel: adminLevel);
      setState(() {
        // Stelle sicher, dass die Typzuweisungen korrekt sind
        _cityData = responseMap['result'] as String?;
        _sentQuery = responseMap['query'] as String?;
        _polygons = responseMap['polygons'] as List<Polygon>? ?? [];
        _isLoading = false;

        if (_polygons.isNotEmpty && _polygons.first.points.isNotEmpty) {
          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(_polygons.first.points),
              padding: const EdgeInsets.all(50.0),
            ),
          );
        }
      });
    } catch (e) {
      setState(() {
        _error = "Fehler beim Abrufen der Daten: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _fetchCityData("Berlin", 4),
                  child: const Text('Berlin (4)'),
                ),
                ElevatedButton(
                  onPressed: () => _fetchCityData("Köln", 6),
                  child: const Text('Köln (6)'),
                ),
                ElevatedButton(
                  onPressed: () => _fetchCityData("Bonn", 6),
                  child: const Text('Bonn (6)'),
                ),
                ElevatedButton(
                  onPressed: () => _fetchCityData("Bornheim", 8),
                  child: const Text('Bornheim (8)'),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_error != null)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _error!,
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
                  initialCenter: _polygons.isNotEmpty && _polygons.first.points.isNotEmpty 
                               ? _polygons.first.points.first 
                               : const LatLng(51.5, -0.09), // Standard-Fallback
                  initialZoom: _polygons.isNotEmpty ? 10.0 : 6.0, // Zoom anpassen, wenn Polygone da sind
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example', // Wichtig für OSM Tile Usage Policy
                  ),
                  if (_polygons.isNotEmpty)
                    PolygonLayer(
                      polygons: _polygons,
                    ),
                ],
              ),
            ),
          // Optional: Bereich für Query und JSON-Antwort (wieder einkommentiert)
          if (!_isLoading && _error == null && (_sentQuery != null || _cityData != null))
            Container(
              height: MediaQuery.of(context).size.height * 0.25, // Höhe angepasst auf 25%
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
                    if (_sentQuery != null)
                      Column(
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
                            child: SelectableText( // Geändert zu SelectableText
                              _sentQuery!,
                              style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    if (_cityData != null)
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
                            child: SelectableText( // Geändert zu SelectableText
                              _cityData!,
                              style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
                              maxLines: 10, // Begrenzt die angezeigte Höhe, aber scrollbar durch SingleChildScrollView
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
  }
}
