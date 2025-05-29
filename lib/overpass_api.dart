import 'dart:convert';
import 'dart:ui'; // Für Color

// Importiere Polygon direkt von flutter_map
import 'package:flutter_map/flutter_map.dart' show Polygon;
import 'package:http/http.dart' as http;
// LatLng kommt von latlong2
import 'package:latlong2/latlong.dart';

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
  OverpassApi({String baseUrl = 'https://overpass-api.de/api/interpreter'}) : _baseUrl = baseUrl;

  /// Ruft die geometrischen Umrisse einer Stadt und ihrer nächstkleineren Bezirke ab.
  ///
  /// Sucht nach einer administrativen Grenze mit dem angegebenen [cityName]
  /// und dem [adminLevel] der Stadt. Anschließend werden Unterbezirke mit
  /// `admin_level = cityAdminLevel + 1` und `admin_level = cityAdminLevel + 2`
  /// innerhalb des Stadtgebiets gesucht.
  ///
  /// Gibt eine [Future] zurück, die mit einer Map abgeschlossen wird.
  /// Die Map enthält:
  ///   - 'query': Die gesendeten Overpass QL-Abfragen (String).
  ///   - 'result': Die rohen JSON-Strings der API-Antworten (String).
  ///   - 'polygons': Eine Liste von [Polygon]-Objekten für flutter_map (List<Polygon>).
  /// Wirft eine [Exception], wenn die HTTP-Anfrage fehlschlägt oder die API
  /// einen Fehler zurückgibt.
  Future<Map<String, dynamic>> getCityOutline(String cityName, {int adminLevel = 8}) async {
    String cityQuery =
        '[out:json][timeout:25];relation["boundary"="administrative"]["type"="boundary"]["admin_level"="$adminLevel"]["name"="$cityName"];out geom;';
    String cityQueryResult = "";
    List<Polygon> cityPolygons = []; // Separate Liste für Stadtpolygone
    List<Polygon> subDistrictPolygons = []; // Separate Liste für Bezirkspolygone
    int? cityRelationId;
    String combinedQuery = cityQuery;
    String combinedResult = "";

    try {
      print("Abfrage für Stadt: $cityName (Admin Level: $adminLevel)");
      final cityResponse = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'data': cityQuery},
      );

      if (cityResponse.statusCode == 200) {
        cityQueryResult = cityResponse.body;
        combinedResult = cityQueryResult;
        final cityDecodedBody = json.decode(cityQueryResult);

        if (cityDecodedBody['remark'] != null && cityDecodedBody['remark'].toString().contains('Error')) {
          throw Exception('Overpass API error for city query: ${cityDecodedBody['remark']}');
        }

        // Stadtpolygone parsen und speichern
        cityPolygons.addAll(_parseGeometriesToPolygons(cityQueryResult, isSubDistrict: false));

        if (cityDecodedBody['elements'] != null && cityDecodedBody['elements'] is List) {
          for (var element in cityDecodedBody['elements']) {
            if (element is Map && element['type'] == 'relation' && element['id'] != null) {
              cityRelationId = element['id'];
              print("Stadt ${element['tags']?['name'] ?? cityName} (ID: $cityRelationId) gefunden.");
              break;
            }
          }
        }
      } else {
        throw Exception(
          'Failed to load city outline for $cityName. Status: ${cityResponse.statusCode}, Reason: ${cityResponse.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Error fetching city outline for $cityName: $e');
      rethrow;
    }

    if (cityRelationId != null) {
      final areaId = 3600000000 + cityRelationId;
      String subDistrictLevelPattern;
      String subDistrictLevelsForLogging;
      int subQueryTimeout = 35; // Default timeout

      if (adminLevel == 4) {
        // Spezifische Logik für Berlin
        subDistrictLevelPattern = "6|9";
        subDistrictLevelsForLogging = "6 und 9";
        subQueryTimeout = 45; // Increased timeout for Berlin
        print(
          'Unterbezirke für Berlin (Stadt ID $cityRelationId, Area ID: $areaId): Levels $subDistrictLevelsForLogging, Timeout: $subQueryTimeout s',
        );
      } else {
        List<String> levels = [];
        if (adminLevel + 1 <= 15) levels.add((adminLevel + 1).toString());
        if (adminLevel + 2 <= 15) levels.add((adminLevel + 2).toString());
        if (adminLevel + 3 <= 15) levels.add((adminLevel + 3).toString());

        if (levels.isEmpty) {
          print(
            "Keine gültigen Sub-District-Level zum Abfragen für Stadt ID $cityRelationId (Admin-Level der Stadt: $adminLevel).",
          );
          // Gebe die bereits gesammelten Stadtpolygone zurück
          return {'query': combinedQuery, 'result': combinedResult, 'cityPolygons': cityPolygons, 'subDistrictPolygons': subDistrictPolygons};
        }
        subDistrictLevelPattern = levels.join("|");
        subDistrictLevelsForLogging = levels.join(", ");
        print(
          'Unterbezirke für Stadt ID $cityRelationId (Area ID: $areaId): Levels $subDistrictLevelsForLogging, Timeout: $subQueryTimeout s',
        );
      }

      final subDistrictQuery =
          """
[out:json][timeout:$subQueryTimeout];
(
  relation(area:$areaId)["boundary"="administrative"]["type"="boundary"]["admin_level"~"^(${subDistrictLevelPattern})\$"];
  way(area:$areaId)["boundary"="administrative"]["type"="boundary"]["admin_level"~"^(${subDistrictLevelPattern})\$"];
);
out geom;
""";

      combinedQuery += "\\n\\n---\\n\\n$subDistrictQuery";

      try {
        final subdistrictResponse = await http.post(
          Uri.parse(_baseUrl),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'data': subDistrictQuery},
        );

        if (subdistrictResponse.statusCode == 200) {
          final subdistrictResultBody = subdistrictResponse.body;
          combinedResult += "\\n\\n---\\n\\n$subdistrictResultBody";
          final subdistrictDecodedBody = json.decode(subdistrictResultBody);

          if (subdistrictDecodedBody['remark'] != null &&
              subdistrictDecodedBody['remark'].toString().contains('Error')) {
            print('Overpass API error for subdistrict query: ${subdistrictDecodedBody['remark']}');
          }
          
          // Bezirkspolygone parsen und speichern
          subDistrictPolygons.addAll(_parseGeometriesToPolygons(subdistrictResultBody, isSubDistrict: true));
          print("Anzahl gefundener Polygone für Unterbezirke: ${subDistrictPolygons.length}");
        } else {
          print(
            'Failed to load subdistricts for city ID $cityRelationId. Status: ${subdistrictResponse.statusCode}, Reason: ${subdistrictResponse.reasonPhrase}',
          );
        }
      } catch (e) {
        print('Error fetching subdistricts for city ID $cityRelationId: $e');
      }
    } else {
      print("Keine Stadt-Relation-ID für $cityName gefunden, überspringe Bezirksabfrage.");
    }

    // Gebe die getrennten Listen zurück
    return {'query': combinedQuery, 'result': combinedResult, 'cityPolygons': cityPolygons, 'subDistrictPolygons': subDistrictPolygons};
  }

  /// Parst den JSON-String einer Overpass API-Antwort und extrahiert Polygone.
  /// Diese Implementierung ist vereinfacht und behandelt jeden 'outer' Way einer Relation
  /// als separates Polygon. Für komplexe Multipolygone ist eine erweiterte Logik nötig.
  List<Polygon> _parseGeometriesToPolygons(String jsonResponse, {bool isSubDistrict = false}) {
    final List<Polygon> polygons = [];
    final data = json.decode(jsonResponse);

    if (data['elements'] == null || data['elements'] is! List) return polygons;

    final List elements = data['elements'];
    print("Anzahl der Elemente von der API für ${isSubDistrict ? 'Bezirke' : 'Stadt'}: ${elements.length}");

    for (var element in elements) {
      if (element is! Map) continue;

      String? elementName = element['tags']?['name']; // Namen extrahieren

      if (element['type'] == 'relation') {
        List<List<LatLng>> outerWaySegments = [];
        if (element['members'] != null && element['members'] is List) {
          for (var member in element['members']) {
            if (member is! Map) continue;

            if (member['type'] == 'way' &&
                (member['role'] == 'outer' || member['role'] == '') &&
                member['geometry'] != null &&
                member['geometry'] is List) {
              List<LatLng> memberPoints = [];
              for (var pt in member['geometry']) {
                if (pt is Map && pt['lat'] != null && pt['lon'] != null) {
                  try {
                    memberPoints.add(LatLng(pt['lat'].toDouble(), pt['lon'].toDouble()));
                  } catch (e) {
                    print(
                      "Fehler beim Konvertieren von Lat/Lng für Relation-Member-Way: $e, Punkt: $pt, Member-Ref: ${member['ref']}",
                    );
                  }
                }
              }
              if (memberPoints.isNotEmpty) {
                outerWaySegments.add(memberPoints);
              }
            }
          }
        }

        if (outerWaySegments.isNotEmpty) {
          List<List<LatLng>> connectedPolygonsPoints = _connectWaySegments(outerWaySegments);
          for (var polygonPoints in connectedPolygonsPoints) {
            if (polygonPoints.length > 1) {
              bool isNaturallyClosed = false;
              if (polygonPoints.length > 2) {
                final first = polygonPoints.first;
                final last = polygonPoints.last;
                isNaturallyClosed = (first.latitude == last.latitude && first.longitude == last.longitude);
              }

              polygons.add(
                Polygon(
                  points: polygonPoints,
                  borderColor: isSubDistrict
                      ? (isNaturallyClosed
                            ? const Color(0xFF008800)
                            : const Color(0xFF4CAF50)) // Dunkelgrün / Grün für Bezirke
                      : (isNaturallyClosed ? const Color(0xFFDD0000) : const Color(0xFF0077FF)), // Rot / Blau für Stadt
                  borderStrokeWidth: isSubDistrict
                      ? (isNaturallyClosed ? 1.5 : 1.0) // Dünner für Bezirke
                      : (isNaturallyClosed ? 3.0 : 2.0),
                  isFilled: isNaturallyClosed,
                  color: isNaturallyClosed
                      ? (isSubDistrict ? const Color(0x3300AA00) : const Color(0x44DD0000))
                      : const Color(0x00000000),
                  label: elementName, // Namen dem Polygon-Label zuweisen
                  // Optional: labelStyle für die Darstellung des Labels direkt auf dem Polygon (kann überladen wirken)
                  // labelStyle: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              );
            }
          }
        }
      } else if (element['type'] == 'way' && element['geometry'] != null && element['geometry'] is List) {
        // Für einzelne Ways, die nicht Teil einer Relation sind, könnten wir auch Namen anzeigen,
        // aber typischerweise sind administrative Grenzen Relationen.
        // Hier könnte man entscheiden, ob für diese auch Labels generiert werden sollen.
        // Vorerst lassen wir es für Ways ohne Label, da sie meist nur Segmente sind.
        List<LatLng> currentWayPoints = [];
        for (var pt in element['geometry']) {
          if (pt is Map && pt['lat'] != null && pt['lon'] != null) {
            try {
              currentWayPoints.add(LatLng(pt['lat'].toDouble(), pt['lon'].toDouble()));
            } catch (e) {
              print("Fehler beim Konvertieren von Lat/Lng für Top-Level Way: $e, Punkt: $pt, Way-ID: ${element['id']}");
            }
          }
        }
        if (currentWayPoints.length > 1) {
          polygons.add(
            Polygon(
              points: currentWayPoints,
              borderColor: isSubDistrict
                  ? const Color(0xFF8BC34A)
                  : const Color(0xFF00AAFF), // Hellgrün für Bezirks-Ways / Blau für Stadt-Ways
              borderStrokeWidth: isSubDistrict ? 1.0 : 1.5,
              isFilled: false,
              label: elementName, // Auch hier den Namen zuweisen, falls vorhanden
            ),
          );
        }
      }
    }
    print("Geparste Polygone (${isSubDistrict ? 'Bezirke' : 'Stadt'}) insgesamt: ${polygons.length}");
    return polygons;
  }

  // Hilfsmethode zum Verbinden von Way-Segmenten
  // Gibt eine Liste von Polygonpunktlisten zurück (da eine Relation mehrere disjunkte äußere Ringe haben kann)
  List<List<LatLng>> _connectWaySegments(List<List<LatLng>> segments) {
    if (segments.isEmpty) return [];

    List<List<LatLng>> connectedPolygons = [];
    List<List<LatLng>> remainingSegments = List.from(segments);

    while (remainingSegments.isNotEmpty) {
      List<LatLng> currentChain = List.from(remainingSegments.removeAt(0));
      if (currentChain.isEmpty) continue;

      bool segmentAddedInIteration;
      do {
        segmentAddedInIteration = false;
        LatLng firstPoint = currentChain.first;
        LatLng lastPoint = currentChain.last;
        int foundAtIndex = -1;

        for (int i = 0; i < remainingSegments.length; i++) {
          List<LatLng> nextSegment = remainingSegments[i];
          if (nextSegment.isEmpty) continue;

          // Versuche, am Ende der Kette anzufügen
          if (nextSegment.first.latitude == lastPoint.latitude && nextSegment.first.longitude == lastPoint.longitude) {
            currentChain.addAll(nextSegment.sublist(1));
            foundAtIndex = i;
            break;
          } else if (nextSegment.last.latitude == lastPoint.latitude &&
              nextSegment.last.longitude == lastPoint.longitude) {
            currentChain.addAll(nextSegment.reversed.toList().sublist(1));
            foundAtIndex = i;
            break;
          }
          // Versuche, am Anfang der Kette anzufügen
          else if (nextSegment.last.latitude == firstPoint.latitude &&
              nextSegment.last.longitude == firstPoint.longitude) {
            currentChain.insertAll(0, nextSegment.sublist(0, nextSegment.length - 1));
            foundAtIndex = i;
            break;
          } else if (nextSegment.first.latitude == firstPoint.latitude &&
              nextSegment.first.longitude == firstPoint.longitude) {
            currentChain.insertAll(0, nextSegment.reversed.toList().sublist(0, nextSegment.length - 1));
            foundAtIndex = i;
            break;
          }
        }

        if (foundAtIndex != -1) {
          remainingSegments.removeAt(foundAtIndex);
          segmentAddedInIteration = true;
        }
      } while (segmentAddedInIteration && remainingSegments.isNotEmpty);

      // Schließe das Polygon, wenn der erste und letzte Punkt nicht identisch sind und es mehr als 2 Punkte gibt
      // OSM-Daten für geschlossene Wege haben oft identische Start- und Endknoten.
      // Wenn sie nicht identisch sind nach dem Verbinden, und es ein Polygon sein soll,
      // könnte man sie hier verbinden, aber flutter_map macht das implizit, wenn isFilled=true.
      // if (currentChain.length > 2 && (currentChain.first.latitude != currentChain.last.latitude || currentChain.first.longitude != currentChain.last.longitude)) {
      //   // currentChain.add(currentChain.first); // Explizit schließen, oft nicht nötig für flutter_map Polygon
      // }
      connectedPolygons.add(currentChain);
      print("  _connectWaySegments: Einen verbundenen Pfad mit ${currentChain.length} Punkten erstellt.");
    }

    if (remainingSegments.isNotEmpty) {
      print("  _connectWaySegments: Warnung - ${remainingSegments.length} Segmente konnten nicht verbunden werden.");
      // Füge die verbleibenden, nicht verbundenen Segmente als einzelne Polygone/Linien hinzu,
      // damit sie nicht verloren gehen.
      // connectedPolygons.addAll(remainingSegments.where((seg) => seg.length > 1));
    }

    return connectedPolygons;
  }

  /// Sendet eine benutzerdefinierte Overpass QL-Abfrage an die API.
  ///
  /// [query] Die vollständige Overpass QL-Abfrage als String.
  ///
  /// Gibt eine [Future] zurück, die mit einer Map abgeschlossen wird.
  /// Die Map enthält 'query', 'result' (JSON-String) und 'polygons' (List<Polygon>).
  /// Wirft eine [Exception], wenn die HTTP-Anfrage fehlschlägt.
  Future<Map<String, dynamic>> customQuery(String query) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'data': query},
      );

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        if (decodedBody['remark'] != null && decodedBody['remark'].toString().contains('Error')) {
          throw Exception('Overpass API error: ${decodedBody['remark']}');
        }
        List<Polygon> polygons = _parseGeometriesToPolygons(response.body);
        return {'query': query, 'result': response.body, 'polygons': polygons};
      } else {
        throw Exception(
          'Failed to execute custom query. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}',
        );
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
    // Für eine Stadt wie "München" wäre admin_level=6 passender.
    // Die Methode holt jetzt auch die Bezirke für admin_level 7 und 8 dazu.
    final cityData = await api.getCityOutline("München", adminLevel: 6); 
    print("München Outline und Bezirke (${cityData['polygons'].length} Polygone) Abfrage: ${cityData['query']}");
    // print("Result: ${cityData['result']}"); // Kann sehr lang sein

    // Beispiel für Köln
    // final cologneData = await api.getCityOutline("Köln", adminLevel: 6);
    // print("Köln Outline und Bezirke (${cologneData['polygons'].length} Polygone) Abfrage: ${cologneData['query']}");

  } catch (e) {
    print("Ein Fehler ist aufgetreten: $e");
  }
}
*/
