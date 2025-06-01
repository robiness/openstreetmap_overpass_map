import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:overpass_map/models/boundary_data.dart'; // For BoundaryData
import 'package:overpass_map/models/user_area_data.dart';
import 'package:overpass_map/overpass_api.dart'; // For CityDataResult
import 'package:overpass_map/overpass_map_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a Fake OverpassApi for testing
class FakeOverpassApi implements OverpassApi {
  // You can add properties to this fake to control its behavior in tests
  CityDataResult Function(String cityName, {int cityAdminLevel})? getCityDataHandler;

  @override
  Future<CityDataResult> getCityData(String cityName, {int cityAdminLevel = 6}) async {
    if (getCityDataHandler != null) {
      return getCityDataHandler!(cityName, cityAdminLevel: cityAdminLevel);
    }
    // Default behavior if no handler is set for a specific test
    return CityDataResult(
      data: BoundaryData({}), // Empty but valid BoundaryData
      source: 'fake_test_source',
      duration: 0,
      query: 'fake_query',
    );
  }

  // Add other methods from OverpassApi if your notifier uses them,
  // otherwise, this single method might be enough for current tests.
}

void main() {
  late OverpassMapNotifier notifier;
  late FakeOverpassApi fakeOverpassApi;
  const String userVisitDataKey = 'user_visit_data';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    fakeOverpassApi = FakeOverpassApi();

    // Configure the default handler for getCityData for most tests
    fakeOverpassApi.getCityDataHandler = (city, {int? cityAdminLevel}) => CityDataResult(
      data: BoundaryData({}), // Empty BoundaryData
      source: 'fake',
      duration: 0,
      query: 'test_query',
    );

    notifier = OverpassMapNotifier(fakeOverpassApi); // Inject the fake API
    await Future.delayed(Duration.zero); // Allow async init operations to complete
  });

  group('OverpassMapNotifier - User Visit Data', () {
    test('_loadUserVisitData loads and decodes data from SharedPreferences', () async {
      // Arrange
      final Map<int, UserAreaData> testVisitData = {
        1: UserAreaData(areaId: 1, visitCount: 5),
        2: UserAreaData(areaId: 2, visitCount: 10),
      };
      final String jsonString = json.encode(
        testVisitData.map((key, value) => MapEntry(key.toString(), value.toJson())),
      );
      SharedPreferences.setMockInitialValues({userVisitDataKey: jsonString});

      // Act: Re-initialize notifier with the same fake API but new SharedPreferences state
      notifier = OverpassMapNotifier(fakeOverpassApi);
      await Future.delayed(Duration.zero);

      // Assert
      expect(notifier.getUserAreaData(1)?.visitCount, 5); // Adjusted expectation
      expect(notifier.getUserAreaData(2)?.visitCount, 10); // Adjusted expectation
    });

    test('_saveUserVisitData saves data to SharedPreferences', () async {
      // Arrange
      const int areaId1 = 100;
      const int areaId2 = 200;

      // Act
      notifier.incrementVisitCount(areaId1);
      notifier.incrementVisitCount(areaId1);
      notifier.incrementVisitCount(areaId2);
      await Future.delayed(Duration.zero);

      // Assert
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(userVisitDataKey);
      expect(jsonString, isNotNull);

      final Map<String, dynamic> savedMap = json.decode(jsonString!);
      expect(savedMap[areaId1.toString()]['visitCount'], 2);
      expect(savedMap[areaId2.toString()]['visitCount'], 1);
    });

    test('incrementVisitCount updates visit count and saves data', () async {
      // Arrange
      const int areaId = 300;
      expect(notifier.getUserAreaData(areaId)?.visitCount ?? 0, 0);

      // Act
      notifier.incrementVisitCount(areaId);
      expect(notifier.getUserAreaData(areaId)?.visitCount, 1);

      notifier.incrementVisitCount(areaId);
      expect(notifier.getUserAreaData(areaId)?.visitCount, 2);

      await Future.delayed(Duration.zero);
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(userVisitDataKey);
      final Map<String, dynamic> savedMap = json.decode(jsonString!);
      expect(savedMap[areaId.toString()]['visitCount'], 2);
    });

    test('_loadUserVisitData handles missing or corrupted data gracefully', () async {
      SharedPreferences.setMockInitialValues({userVisitDataKey: "this is not json"});
      notifier = OverpassMapNotifier(fakeOverpassApi);
      await Future.delayed(Duration.zero);

      notifier.incrementVisitCount(999);
      expect(notifier.getUserAreaData(999)?.visitCount, 1);
    });
  });
}

// Helper extension to access notifier's internal state for testing
extension OverpassMapNotifierTestAccess on OverpassMapNotifier {
  UserAreaData? getUserAreaData(int areaId) {
    // Access the now package-private userAreaVisitData field
    return userAreaVisitData[areaId];
  }
}
