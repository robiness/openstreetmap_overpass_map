import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // Fallback values for web builds when .env cannot be loaded
  static const String _fallbackSupabaseUrl = 'https://qltlkwnhhomfjdwosbhn.supabase.co';
  static const String _fallbackSupabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsdGxrd25oaG9tZmpkd29zYmhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMzc3NTEsImV4cCI6MjA2NjcxMzc1MX0.N0iIz79hGhlOth2jRTsUbrtrzp2M1pWjdi8nGwBfmMk';

  static String get supabaseUrl {
    if (kIsWeb) {
      // For web builds, use fallback values directly (no .env loading)
      return _fallbackSupabaseUrl;
    }
    // For native platforms, try .env first, then fallback
    return dotenv.env['SUPABASE_URL'] ?? _fallbackSupabaseUrl;
  }

  static String get supabaseAnonKey {
    if (kIsWeb) {
      // For web builds, use fallback values directly (no .env loading)
      return _fallbackSupabaseAnonKey;
    }
    // For native platforms, try .env first, then fallback
    return dotenv.env['SUPABASE_ANON_KEY'] ?? _fallbackSupabaseAnonKey;
  }
  
  static void validateConfig() {
    if (kIsWeb) {
      print('🌐 Web platform: Using built-in Supabase configuration');
    } else {
      print('📱 Native platform: Using .env configuration');
    }
    
    if (supabaseUrl.isEmpty) {
      print('❌ Error: SUPABASE_URL is empty');
    } else {
      print('✅ Using Supabase URL: $supabaseUrl');
    }
    
    if (supabaseAnonKey.isEmpty) {
      print('❌ Error: SUPABASE_ANON_KEY is empty');
    } else {
      print('✅ Supabase ANON_KEY configured');
    }
  }
}