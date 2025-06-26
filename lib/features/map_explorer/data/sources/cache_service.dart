import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  // Made public and static for easier testing and utility access
  static String generateKey(String requestIdentifier) {
    return sha256.convert(utf8.encode(requestIdentifier)).toString();
  }

  Future<Map<String, dynamic>?> get(String requestIdentifier) async {
    final stopwatch = Stopwatch()..start();
    final prefs = await SharedPreferences.getInstance();
    final key = CacheService.generateKey(requestIdentifier);
    
    try {
      final content = prefs.getString(key);

      if (content != null) {
        final Map<String, dynamic> cachedData = json.decode(content);
        
        // Check if 'expiresAt' exists and is an int before trying to use it
        if (cachedData['expiresAt'] is! int) {
          print('Cache entry for key $key is malformed (missing/invalid expiresAt). Deleting.');
          await prefs.remove(key);
          // Fall through to cache_miss logic by not returning here
        } else {
          // Now it's safe to assume expiresAt is an int
          final expiresAt = cachedData['expiresAt'] as int;
          if (DateTime.now().millisecondsSinceEpoch > expiresAt) {
            await prefs.remove(key);
            stopwatch.stop();
            return {
              'data': null,
              'source': 'cache_expired',
              'duration': stopwatch.elapsedMilliseconds,
            };
          }
          // Valid cache entry
          stopwatch.stop();
          return {
            'data': cachedData['data'], // Corrected: Added comma if it was missing, ensure map is valid
            'source': 'cache',
            'duration': stopwatch.elapsedMilliseconds,
          }; // Ensure this map is correctly structured
        }
      }
    } catch (e) {
      print('Cache get error for key $key: $e. Deleting.');
      await prefs.remove(key);
    }
    
    stopwatch.stop();
    return {
      'data': null,
      'source': 'cache_miss',
      'duration': stopwatch.elapsedMilliseconds,
    };
  }

  Future<void> put(
    String requestIdentifier,
    dynamic data, {
    Duration ttl = const Duration(hours: 1),
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Use the static method
      final key = CacheService.generateKey(requestIdentifier);
      final expiresAt = DateTime.now().add(ttl).millisecondsSinceEpoch;
      final cacheContent = json.encode({
        'expiresAt': expiresAt,
        'data': data,
      });
      await prefs.setString(key, cacheContent);
    } catch (e) {
      // Log error or handle
      print('Cache put error: $e');
    }
  }

  Future<void> invalidate(String requestIdentifier) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Use the static method
      final key = CacheService.generateKey(requestIdentifier);
      await prefs.remove(key);
    } catch (e) {
      // Log error or handle
      print('Cache invalidate error: $e');
    }
  }

  Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clears all data in shared preferences
    } catch (e) {
      // Log error or handle
      print('Cache clearAll error: $e');
    }
  }

  Future<void> cleanExpired() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();

      for (final key in keys) {
        final content = prefs.getString(key);
        if (content != null) {
          try {
            final Map<String, dynamic> cachedData = json.decode(content);
            if (cachedData['expiresAt'] is! int) {
              print('Cache entry for key $key is malformed (missing/invalid expiresAt). Deleting.');
              await prefs.remove(key);
              continue; 
            }
            final expiresAt = cachedData['expiresAt'] as int;
            if (DateTime.now().millisecondsSinceEpoch > expiresAt) {
              await prefs.remove(key);
            }
          } catch (e) {
            print('Error processing cache entry for key $key: $e. Deleting.');
            await prefs.remove(key);
          }
        }
      }
    } catch (e) {
      print('Cache cleanExpired error: $e');
    }
  }
}
