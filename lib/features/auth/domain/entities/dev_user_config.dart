import 'package:flutter/foundation.dart';

/// Configuration for development/testing user
class DevUserConfig {
  static const String devEmail = 'dev@cologneexplorer.com';
  static const String devPassword = 'dev_password_123';
  static const String devUserId = 'dev-user-uuid-12345';
  static const String devUsername = 'DevExplorer';
  static const String devFullName = 'Development User';

  /// Mock user profile data for development
  static const Map<String, dynamic> devProfileData = {
    'id': devUserId,
    'email': devEmail,
    'username': devUsername,
    'full_name': devFullName,
    'avatar_url': null,
    'total_checkins': 42,
    'completed_stadtteile': 15,
    'created_at': '2024-01-01T00:00:00Z',
  };

  /// Check if we should use dev mode authentication
  static bool get shouldUseDevAuth => kDebugMode;

  /// Development check-ins data for testing
  static const List<Map<String, dynamic>> devCheckinsData = [
    {
      'id': 'checkin-1',
      'user_id': devUserId,
      'stadtteil_id': 1,
      'verified': true,
      'created_at': '2024-01-15T10:30:00Z',
    },
    {
      'id': 'checkin-2',
      'user_id': devUserId,
      'stadtteil_id': 5,
      'verified': true,
      'created_at': '2024-01-20T14:15:00Z',
    },
    // Add more mock data as needed
  ];
}
