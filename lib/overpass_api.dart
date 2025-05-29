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

  /// Ruft die geometrischen Umrisse einer Stadt ab.
  ///
  /// Sucht nach einer administrativen Grenze mit dem angegebenen [cityName]
  /// und dem optionalen [adminLevel]. Der `admin_level` kann je nach Land
  /// und Stadt variieren (z.B. 6 für größere Städte, 8 für kleinere Gemeinden in Deutschland).
  ///
  /// Gibt eine [Future] zurück, die mit einer Map abgeschlossen wird.
  /// Die Map enthält:
  ///   - 'query': Die gesendete Overpass QL-Abfrage (String).
  ///   - 'result': Der rohe JSON-String der API-Antwort (String).
  ///   - 'polygons': Eine Liste von [Polygon]-Objekten für flutter_map (List<Polygon>).
  /// Wirft eine [Exception], wenn die HTTP-Anfrage fehlschlägt oder die API
  /// einen Fehler zurückgibt.
  ///
  /// Beispiel-Abfrage an die Overpass API:
  /// ```ql
  /// [out:json][timeout:25];
  /// relation["boundary"="administrative"]["admin_level"="8"]["name"="Berlin"];
  /// out geom;
  /// ```
  Future<Map<String, dynamic>> getCityOutline(String cityName, {int adminLevel = 8}) async {
    // Overpass QL-Abfrage, um die Relation für die Stadtgrenze zu finden
    // und deren Geometrie auszugeben.
    // Hinzugefügt: ["type"="boundary"] um die Abfrage spezifischer zu machen.
    final String query =
        '''[out:json][timeout:25];
(
  relation["boundary"="administrative"]["type"="boundary"]["admin_level"="$adminLevel"]["name"="$cityName"];
  // Optional: Falls Relationen nicht ausreichen, könnte man auch Ways mit type=boundary suchen:
  // way["boundary"="administrative"]["type"="boundary"]["admin_level"="$adminLevel"]["name"="$cityName"];
);
out geom;
''';

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
          'Failed to load city outline. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Error fetching city outline: $e');
      rethrow;
    }
  }

  /// Parst den JSON-String einer Overpass API-Antwort und extrahiert Polygone.
  /// Diese Implementierung ist vereinfacht und behandelt jeden 'outer' Way einer Relation
  /// als separates Polygon. Für komplexe Multipolygone ist eine erweiterte Logik nötig.
  List<Polygon> _parseGeometriesToPolygons(String jsonResponse) {
    final List<Polygon> polygons = [];
    final data = json.decode(jsonResponse);

    if (data['elements'] == null || data['elements'] is! List) return polygons;

    final List elements = data['elements'];
    // Eine Map, um Way-Geometrien über ihre ID schnell nachschlagen zu können,
    // falls sie nicht direkt in den Relation-Membern eingebettet sind (obwohl out geom dies tun sollte).
    // Für den Moment gehen wir davon aus, dass 'geometry' in den Membern oder den Top-Level Ways vorhanden ist.
    // Map<int, List<LatLng>> wayGeometries = {};
    // for (var el in elements) {
    //   if (el is Map && el['type'] == 'way' && el['id'] != null && el['geometry'] != null) {
    //     List<LatLng> pts = [];
    //     for (var geoPoint in el['geometry']) {
    //       if (geoPoint is Map && geoPoint['lat'] != null && geoPoint['lon'] != null) {
    //         pts.add(LatLng(geoPoint['lat'].toDouble(), geoPoint['lon'].toDouble()));
    //       }
    //     }
    //     if (pts.isNotEmpty) {
    //       wayGeometries[el['id']] = pts;
    //     }
    //   }
    // }


    print("Anzahl der Elemente von der API: ${elements.length}");

    for (var element in elements) {
      if (element is! Map) continue;

      print("Verarbeite Element: Typ=${element['type']}, ID=${element['id']}");

      if (element['type'] == 'relation') {
        List<List<LatLng>> outerWaySegments = [];
        if (element['members'] != null && element['members'] is List) {
          for (var member in element['members']) {
            if (member is! Map) continue;

            if (member['type'] == 'way' &&
                (member['role'] == 'outer' || member['role'] == '') && // Leere Rolle auch oft für äußere Ringe
                member['geometry'] != null &&
                member['geometry'] is List) {
              
              List<LatLng> memberPoints = [];
              for (var pt in member['geometry']) {
                if (pt is Map && pt['lat'] != null && pt['lon'] != null) {
                  try {
                    memberPoints.add(LatLng(pt['lat'].toDouble(), pt['lon'].toDouble()));
                  } catch (e) {
                    print("Fehler beim Konvertieren von Lat/Lng für Relation-Member-Way: $e, Punkt: $pt, Member-Ref: ${member['ref']}");
                  }
                }
              }
              if (memberPoints.isNotEmpty) {
                outerWaySegments.add(memberPoints);
                print("  Relation ${element['id']}: Outer-Way-Segment (Ref: ${member['ref']}) mit ${memberPoints.length} Punkten hinzugefügt.");
              }
            }
          }
        }

        if (outerWaySegments.isNotEmpty) {
          print("  Relation ${element['id']}: Versuche ${outerWaySegments.length} Outer-Way-Segmente zu verbinden.");
          List<List<LatLng>> connectedPolygonsPoints = _connectWaySegments(outerWaySegments);
          for (var polygonPoints in connectedPolygonsPoints) {
            if (polygonPoints.length > 1) { // Ein Polygon braucht mindestens 2 Punkte für eine Linie, 3 für eine Fläche
               polygons.add(
                Polygon(
                  points: polygonPoints,
                  borderColor: const Color(0xFFDD0000), // Dunkelrot für verbundene Relationspolygone
                  borderStrokeWidth: 3.0,
                  isFilled: true, // Ändere dies zu true, um den Effekt besser zu sehen
                  color: const Color(0x44DD0000), // Leicht gefüllt
                ),
              );
              print("  Relation ${element['id']}: Verbundenes Polygon mit ${polygonPoints.length} Punkten erstellt.");
            } else {
              print("  Relation ${element['id']}: Konnte kein valides Polygon aus Segmenten erstellen (zu wenige Punkte nach Verbindung: ${polygonPoints.length}).");
            }
          }
        } else {
           print("  Relation ${element['id']}: Keine Outer-Way-Segmente mit Geometrie gefunden.");
        }

      } else if (element['type'] == 'way' && element['geometry'] != null && element['geometry'] is List) {
        // Direkte Ways (nicht Teil einer Relation, die wir hier speziell behandeln)
        // werden weiterhin als einzelne Polygone/Linien gezeichnet.
        // Dies ist nützlich, wenn die Abfrage auch einzelne Ways zurückgibt.
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
        if (currentWayPoints.length > 1) { // Eine Linie braucht mindestens 2 Punkte
          polygons.add(
            Polygon(
              points: currentWayPoints,
              borderColor: const Color(0xFF00AAFF), 
              borderStrokeWidth: 1.5, // Dünner für einzelne Ways
              isFilled: false, // Normalerweise nicht gefüllt
              // color: const Color(0x5500AAFF), // Optional füllen
            ),
          );
          print("Top-Level Way ${element['id']}: Polygon/Linie mit ${currentWayPoints.length} Punkten erstellt.");
        }
      }
    }
    print("Geparste Polygone insgesamt: ${polygons.length}");
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
          } else if (nextSegment.last.latitude == lastPoint.latitude && nextSegment.last.longitude == lastPoint.longitude) {
            currentChain.addAll(nextSegment.reversed.toList().sublist(1));
            foundAtIndex = i;
            break;
          }
          // Versuche, am Anfang der Kette anzufügen
          else if (nextSegment.last.latitude == firstPoint.latitude && nextSegment.last.longitude == firstPoint.longitude) {
            currentChain.insertAll(0, nextSegment.sublist(0, nextSegment.length -1));
            foundAtIndex = i;
            break;
          } else if (nextSegment.first.latitude == firstPoint.latitude && nextSegment.first.longitude == firstPoint.longitude) {
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
