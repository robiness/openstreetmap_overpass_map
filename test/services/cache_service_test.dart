import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overpass_map/services/cache_service.dart';

void main() {
  late CacheService cacheService;
  const String testRequestIdentifier = 'test_request';
  final Map<String, dynamic> testData = {'key': 'value', 'number': 123};

  // Use the public static method directly
  String generateTestKey(String requestIdentifier) {
    return CacheService.generateKey(requestIdentifier);
  }

  setUp(() {
    cacheService = CacheService();
    SharedPreferences.setMockInitialValues({});
  });

  group('CacheService - get', () {
    test('should return data from cache if valid and not expired (cache hit)', () async {
      // Arrange
      final String key = generateTestKey(testRequestIdentifier);
      final int futureTime = DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch;
      final Map<String, dynamic> cacheContent = {
        'expiresAt': futureTime,
        'data': testData,
      };
      SharedPreferences.setMockInitialValues({key: json.encode(cacheContent)});
      cacheService = CacheService(); // Reinitialize to pick up mock values

      // Act
      final result = await cacheService.get(testRequestIdentifier);

      // Assert
      expect(result?['data'], testData);
      expect(result?['source'], 'cache');
      expect(result?['duration'], isA<int>());
    });

    test('should return cache_miss if data is not in cache', () async {
      // Arrange
      // SharedPreferences is empty by default due to setUp

      // Act
      final result = await cacheService.get(testRequestIdentifier);

      // Assert
      expect(result?['data'], null);
      expect(result?['source'], 'cache_miss');
      expect(result?['duration'], isA<int>());
    });

    test('should return cache_expired if data is expired and remove it', () async {
      // Arrange
      final String key = generateTestKey(testRequestIdentifier);
      final int pastTime = DateTime.now().subtract(const Duration(hours: 1)).millisecondsSinceEpoch;
      final Map<String, dynamic> cacheContent = {
        'expiresAt': pastTime,
        'data': testData,
      };
      SharedPreferences.setMockInitialValues({key: json.encode(cacheContent)});
      cacheService = CacheService(); // Reinitialize to pick up mock values

      // Act
      final result = await cacheService.get(testRequestIdentifier);

      // Assert
      expect(result?['data'], null);
      expect(result?['source'], 'cache_expired');
      expect(result?['duration'], isA<int>());

      // Verify it was removed
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(key), null);
    });
  });

  group('CacheService - put and get', () {
    test('should store data with put and retrieve it with get', () async {
      // Act
      await cacheService.put(testRequestIdentifier, testData, ttl: const Duration(hours: 1));
      final result = await cacheService.get(testRequestIdentifier);

      // Assert
      expect(result?['data'], testData);
      expect(result?['source'], 'cache');
    });

    test('data should expire after TTL', () async {
      // Arrange
      const shortTTL = Duration(milliseconds: 50);
      await cacheService.put(testRequestIdentifier, testData, ttl: shortTTL);

      // Act
      // Wait for longer than the TTL
      await Future.delayed(const Duration(milliseconds: 100));
      final result = await cacheService.get(testRequestIdentifier);

      // Assert
      expect(result?['data'], null);
      expect(result?['source'], 'cache_expired');
    });
  });

  group('CacheService - invalidate', () {
    test('should remove an item from cache', () async {
      // Arrange
      await cacheService.put(testRequestIdentifier, testData);
      
      // Act
      await cacheService.invalidate(testRequestIdentifier);
      final result = await cacheService.get(testRequestIdentifier);

      // Assert
      expect(result?['source'], 'cache_miss');
    });

    test('invalidate on a non-existent key should not throw', () async {
      // Act & Assert
      expect(() async => await cacheService.invalidate('non_existent_key'), returnsNormally);
    });
  });

  group('CacheService - clearAll', () {
    test('should remove all items from cache', () async {
      // Arrange
      await cacheService.put('req1', {'data': 1});
      await cacheService.put('req2', {'data': 2});

      // Act
      await cacheService.clearAll();
      final result1 = await cacheService.get('req1');
      final result2 = await cacheService.get('req2');

      // Assert
      expect(result1?['source'], 'cache_miss');
      expect(result2?['source'], 'cache_miss');
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getKeys().isEmpty, isTrue); // Assuming CacheService is the only user or keys are prefixed
    });
  });

  group('CacheService - cleanExpired', () {
    test('should remove expired items but keep valid ones', () async {
      // Arrange
      final String validKeyId = 'valid_item';
      final String expiredKeyId = 'expired_item';
      
      await cacheService.put(validKeyId, {'info': 'i am valid'}, ttl: const Duration(hours: 1));
      await cacheService.put(expiredKeyId, {'info': 'i am expired'}, ttl: const Duration(milliseconds: 1));

      // Wait for the short TTL item to expire
      await Future.delayed(const Duration(milliseconds: 50));

      // Act
      await cacheService.cleanExpired();

      // Assert
      final validResult = await cacheService.get(validKeyId);
      final expiredResult = await cacheService.get(expiredKeyId);

      expect(validResult?['source'], 'cache');
      expect(validResult?['data'], {'info': 'i am valid'});
      expect(expiredResult?['source'], 'cache_miss'); // cleanExpired should have removed it, so it's a miss
    });

    test('should handle corrupted cache entries during cleanExpired gracefully', () async {
      // Arrange
      final String corruptedKey = generateTestKey("corrupted_entry_clean_test");
      final String validKeyId = 'valid_clean_test'; // This ID does not need to be hashed by generateTestKey if it's a direct requestIdentifier
      await cacheService.put(validKeyId, {'info': 'valid'}, ttl: const Duration(hours: 1));
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(corruptedKey, "this is not valid json");
      
      final String missingExpiresAtKey = generateTestKey("missing_expires_at_key_clean");
      await prefs.setString(missingExpiresAtKey, json.encode({'data': 'some data'}));


      // Act & Assert
      // Expect cleanExpired to run without throwing an error
      await expectLater(cacheService.cleanExpired(), completes);

      // Corrupted and malformed entries should be removed
      expect(prefs.getString(corruptedKey), null, reason: "Corrupted key should be removed by cleanExpired");
      expect(prefs.getString(missingExpiresAtKey), null, reason: "Key missing expiresAt should be removed by cleanExpired");
      
      // Valid entry should still exist
      final validResult = await cacheService.get(validKeyId);
      expect(validResult?['source'], 'cache');
    });
  });

  test('get should handle corrupted cache entry gracefully and remove it', () async {
    // Arrange
    final String corruptedKeyId = 'corrupted_entry_get_test';
    final String key = generateTestKey(corruptedKeyId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, "this is not valid json {{{{ ");
    cacheService = CacheService(); // Reinitialize with the corrupted data

    // Act
    final result = await cacheService.get(corruptedKeyId);

    // Assert
    expect(result?['data'], null);
    expect(result?['source'], 'cache_miss'); // Or could be 'cache_error', depending on desired behavior
    
    // Verify it was removed
    final currentPrefs = await SharedPreferences.getInstance();
    expect(currentPrefs.getString(key), null);
  });

}
