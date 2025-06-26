import 'package:flutter/material.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/map_explorer/presentation/map_explorer_screen.dart';

class SocialExplorationApp extends StatelessWidget {
  const SocialExplorationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Exploration Game',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MapExplorerScreen(),
    );
  }
}
