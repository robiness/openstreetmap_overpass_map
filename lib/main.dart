import 'package:flutter/material.dart';
import 'package:overpass_map/overpass_api.dart'; // Import der OverpassApi Klasse

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
  String? _sentQuery; // Hinzugefügt, um die gesendete Abfrage zu speichern
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchCityData(String cityName, int adminLevel) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _cityData = null;
      _sentQuery = null; // Zurücksetzen beim neuen Laden
    });
    try {
      final responseMap = await _api.getCityOutline(cityName, adminLevel: adminLevel);
      setState(() {
        _cityData = responseMap['result'];
        _sentQuery = responseMap['query']; // Die Abfrage speichern
        _isLoading = false;
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _fetchCityData("Berlin", 4), // Beispiel: Berlin, admin_level 4
                child: const Text('Lade Umrisse für Berlin (Lvl 4)'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _fetchCityData("München", 6), // Beispiel: München, admin_level 6
                child: const Text('Lade Umrisse für München (Lvl 6)'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _fetchCityData("Grünwald", 8), // Beispiel: Grünwald, admin_level 8
                child: const Text('Lade Umrisse für Grünwald (Lvl 8)'),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                )
              else if (_cityData != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Gesendete Abfrage:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey[200],
                          child: Text(
                            _sentQuery ?? "Keine Abfrage gesendet",
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Antwort:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(_cityData!),
                      ],
                    ),
                  ),
                )
              else
                const Text('Drücke einen Button, um Daten zu laden.'),
            ],
          ),
        ),
      ),
    );
  }
}
