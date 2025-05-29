import 'dart:convert';
import 'package:http/http.dart' as http;

/// {@template overpass_api}
/// Eine Dart-Klasse für die Interaktion mit der Overpass API.
///
/// Diese Klasse stellt Methoden zur Verfügung, um Daten von OpenStreetMap
/// über die Overpass API abzurufen.
/// {@endtemplate}
class OverpassApi {
  /// Die Basis-URL für den Overpass API Interpreter.
  final String _baseUrl;

  /// Erstellt eine Instanz von [OverpassApi].
  ///
  /// Standardmäßig wird der öffentliche Endpunkt `https://overpass-api.de/api/interpreter` verwendet.
  /// Ein anderer [baseUrl] kann für alternative Instanzen angegeben werden.
  OverpassApi({String baseUrl = 'https://overpass-api.de/api/interpreter'})
      : _baseUrl = baseUrl;

  /// Ruft die geometrischen Umrisse einer Stadt ab.
  ///
  /// Sucht nach einer administrativen Grenze mit dem angegebenen [cityName]
  /// und dem optionalen [adminLevel]. Der `admin_level` kann je nach Land
  /// und Stadt variieren (z.B. 6 für größere Städte, 8 für kleinere Gemeinden in Deutschland).
  ///
  /// Gibt eine [Future] zurück, die mit einer Map abgeschlossen wird.
  /// Die Map enthält den Schlüssel 'query' für die gesendete Abfrage und
  /// 'result' für den rohen JSON-String der API-Antwort, wenn die Anfrage erfolgreich ist.
  /// Wirft eine [Exception], wenn die HTTP-Anfrage fehlschlägt oder die API
  /// einen Fehler zurückgibt.
  ///
  /// Beispiel-Abfrage an die Overpass API:
  /// ```ql
  /// [out:json][timeout:25];
  /// relation["boundary"="administrative"]["admin_level"="8"]["name"="Berlin"];
  /// out geom;
  /// ```
  Future<Map<String, String>> getCityOutline(String cityName, {int adminLevel = 8}) async {
    // Overpass QL-Abfrage, um die Relation für die Stadtgrenze zu finden
    // und deren Geometrie auszugeben.
    final String query = '''
[out:json][timeout:25];
(
  relation["boundary"="administrative"]["admin_level"="$adminLevel"]["name"="$cityName"];
);
out geom;
''';

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'data': query},
      );

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        if (decodedBody['remark'] != null && decodedBody['remark'].toString().contains('Error')) {
          throw Exception('Overpass API error: ${decodedBody['remark']}');
        }
        return {'query': query, 'result': response.body};
      } else {
        throw Exception(
            'Failed to load city outline. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching city outline: $e');
      rethrow;
    }
  }

  /// Sendet eine benutzerdefinierte Overpass QL-Abfrage an die API.
  ///
  /// [query] Die vollständige Overpass QL-Abfrage als String.
  ///
  /// Gibt eine [Future] zurück, die mit einer Map abgeschlossen wird.
  /// Die Map enthält den Schlüssel 'query' für die gesendete Abfrage und
  /// 'result' für den rohen JSON-String der API-Antwort.
  /// Wirft eine [Exception], wenn die HTTP-Anfrage fehlschlägt.
  Future<Map<String, String>> customQuery(String query) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'data': query},
      );

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        if (decodedBody['remark'] != null && decodedBody['remark'].toString().contains('Error')) {
          throw Exception('Overpass API error: ${decodedBody['remark']}');
        }
        return {'query': query, 'result': response.body};
      } else {
        throw Exception(
            'Failed to execute custom query. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error executing custom query: $e');
      rethrow;
    }
  }
}

// Beispielhafte Verwendung (kann in deiner main.dart oder einer Testdatei platziert werden):
/*
void main() async {
  final api = OverpassApi();
  try {
    // Umrisse für Berlin (admin_level 8 ist typisch für Bezirke,
    // für die gesamte Stadt Berlin wäre es eher admin_level=4 oder admin_level=2 und name="Berlin"
    // oder man sucht nach der Relation mit der ID für Berlin)
    // Für eine Stadt wie "München" wäre admin_level=6 passender.
    // Dies erfordert oft spezifisches Wissen oder eine flexiblere Abfrage.
    final berlinOutlineJson = await api.getCityOutline("Berlin", adminLevel: 4); // Beispiel für Gesamt-Berlin
    print("Berlin Outline JSON: ${berlinOutlineJson['result'].substring(0, 300)}..."); // Nur die ersten 300 Zeichen

    // Beispiel für eine kleinere Stadt/Gemeinde
    // final smallTownOutlineJson = await api.getCityOutline("Grünwald", adminLevel: 8);
    // print("Grünwald Outline JSON: ${smallTownOutlineJson['result']}");

  } catch (e) {
    print("Ein Fehler ist aufgetreten: $e");
  }
}
*/
