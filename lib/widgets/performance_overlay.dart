import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../models/osm_models.dart';

/// Performance monitoring overlay for debugging map rendering
class PerformanceOverlay extends StatefulWidget {
  final List<GeographicArea> areas;
  final bool showOverlay;

  const PerformanceOverlay({
    super.key,
    required this.areas,
    this.showOverlay = false,
  });

  @override
  State<PerformanceOverlay> createState() => _PerformanceOverlayState();
}

class _PerformanceOverlayState extends State<PerformanceOverlay> {
  Duration lastFrameDuration = Duration.zero;
  int frameCount = 0;
  DateTime lastUpdate = DateTime.now();
  double fps = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.showOverlay) {
      _startPerformanceMonitoring();
    }
  }

  void _startPerformanceMonitoring() {
    SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
      final now = DateTime.now();
      final timeDiff = now.difference(lastUpdate);

      frameCount++;

      // Update FPS every second
      if (timeDiff.inMilliseconds >= 1000) {
        setState(() {
          fps = frameCount / timeDiff.inSeconds;
          frameCount = 0;
          lastUpdate = now;
        });

        // Print performance stats to console for monitoring
        _logPerformanceStats();
      }
    });
  }

  Map<String, dynamic> _calculateStats() {
    int totalPoints = 0;
    int heavyAreas = 0;
    int totalRings = 0;

    for (final area in widget.areas) {
      int areaPoints = 0;
      for (final ring in area.coordinates) {
        areaPoints += ring.length;
        totalRings++;
      }
      totalPoints += areaPoints;

      if (areaPoints > 1000) heavyAreas++;
    }

    return {
      'areas': widget.areas.length,
      'totalPoints': totalPoints,
      'heavyAreas': heavyAreas,
      'avgPoints':
          widget.areas.isEmpty
              ? 0
              : (totalPoints / widget.areas.length).round(),
      'fps': fps.toStringAsFixed(1),
    };
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showOverlay) return const SizedBox.shrink();

    final stats = _calculateStats();

    return Positioned(
      top: 16,
      right: 16,
      child: Material(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Performance Stats',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              _buildStatRow('FPS', '${stats['fps']}', _getFpsColor(fps)),
              _buildStatRow('Areas', '${stats['areas']}', Colors.white70),
              _buildStatRow(
                'Points',
                '${stats['totalPoints']}',
                stats['totalPoints'] > 10000 ? Colors.orange : Colors.white70,
              ),
              _buildStatRow(
                'Heavy Areas',
                '${stats['heavyAreas']}',
                stats['heavyAreas'] > 0 ? Colors.red : Colors.green,
              ),
              _buildStatRow(
                'Avg Points',
                '${stats['avgPoints']}',
                Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(color: Colors.white54, fontSize: 11),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getFpsColor(double fps) {
    if (fps >= 55) return Colors.green;
    if (fps >= 30) return Colors.orange;
    return Colors.red;
  }

  /// Print performance stats to console for debugging
  void _logPerformanceStats() {
    final stats = _calculateStats();
    print('📊 PERFORMANCE STATS:');
    print('   FPS: ${stats['fps']} ${_getFpsIndicator(fps)}');
    print('   Areas: ${stats['areas']}');
    print(
      '   Total Points: ${stats['totalPoints']} ${stats['totalPoints'] > 10000 ? '⚠️' : '✅'}',
    );
    print(
      '   Heavy Areas: ${stats['heavyAreas']} ${stats['heavyAreas'] > 0 ? '🔴' : '🟢'}',
    );
    print('   Avg Points: ${stats['avgPoints']}');
    print('   ${'-' * 40}');
  }

  String _getFpsIndicator(double fps) {
    if (fps >= 55) return '🟢';
    if (fps >= 30) return '🟡';
    return '🔴';
  }
}
