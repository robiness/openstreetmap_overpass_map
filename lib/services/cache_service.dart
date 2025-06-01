import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  String _generateKey(String requestIdentifier) {
    return sha256.convert(utf8.encode(requestIdentifier)).toString();
  }

  Future<Map<String, dynamic>?> get(String requestIdentifier) async {
    final stopwatch = Stopwatch()..start();
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _generateKey(requestIdentifier);
      final content = prefs.getString(key);

      if (content != null) {
        final Map<String, dynamic> cachedData = json.decode(content);
        final expiresAt = cachedData['expiresAt'] as int?;

        if (expiresAt != null &&
            DateTime.now().millisecondsSinceEpoch > expiresAt) {
          // Cache expired
          await prefs.remove(key);
          stopwatch.stop();
          return {
            'data': null,
            'source': 'cache_expired',
            'duration': stopwatch.elapsedMilliseconds,
          };
        }
        stopwatch.stop();
        return {
          'data': cachedData['data'],
          'source': 'cache',
          'duration': stopwatch.elapsedMilliseconds,
        };
      }
    } catch (e) {
      // Log error or handle
      print('Cache get error: \$e');
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
      final key = _generateKey(requestIdentifier);
      final expiresAt = DateTime.now().add(ttl).millisecondsSinceEpoch;
      final cacheContent = json.encode({
        'expiresAt': expiresAt,
        'data': data,
      });
      await prefs.setString(key, cacheContent);
    } catch (e) {
      // Log error or handle
      print('Cache put error: \$e');
    }
  }

  Future<void> invalidate(String requestIdentifier) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _generateKey(requestIdentifier);
      await prefs.remove(key);
    } catch (e) {
      // Log error or handle
      print('Cache invalidate error: \$e');
    }
  }

  Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clears all data in shared preferences
    } catch (e) {
      // Log error or handle
      print('Cache clearAll error: \$e');
    }
  }

  Future<void> cleanExpired() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();

      for (final key in keys) {
        // We need to check if the key is one of our cache keys.
        // This simple check assumes cache keys don't collide with other shared_preferences.
        // A more robust solution might involve prefixing cache keys.
        final content = prefs.getString(key);
        if (content != null) {
          try {
            final Map<String, dynamic> cachedData = json.decode(content);
            final expiresAt = cachedData['expiresAt'] as int?;
            if (expiresAt != null &&
                DateTime.now().millisecondsSinceEpoch > expiresAt) {
              await prefs.remove(key);
            }
          } catch (e) {
            // Corrupted data or not a cache entry, optionally remove
            print('Error processing cache entry for key \$key: \$e. Deleting.');
            await prefs.remove(key);
          }
        }
      }
    } catch (e) {
      print('Cache cleanExpired error: \$e');
    }
  }
}
