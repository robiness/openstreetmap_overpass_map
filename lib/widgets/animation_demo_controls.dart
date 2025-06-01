import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/osm_models.dart';
import '../widgets/animated_area_layer.dart';
import '../examples/area_animation_examples.dart';

/// A demo widget showcasing various area animation effects
class AnimationDemoControls extends StatefulWidget {
  final List<GeographicArea> areas;
  final Function(List<GeographicArea>, {Duration duration, String effect}) onApplyAnimation;

  const AnimationDemoControls({
    super.key,
    required this.areas,
    required this.onApplyAnimation,
  });

  @override
  State<AnimationDemoControls> createState() => _AnimationDemoControlsState();
}

class _AnimationDemoControlsState extends State<AnimationDemoControls>
    with TickerProviderStateMixin {
  
  late AnimationController _rainbowController;
  late AnimationController _pulseController;
  late AnimationController _breatheController;
  
  String _selectedEffect = 'fade_in';
  Duration _animationDuration = const Duration(milliseconds: 1000);

  final Map<String, String> _effects = {
    'fade_in': 'Fade In',
    'slide_up': 'Slide Up',
    'pulse': 'Pulse',
    'rainbow': 'Rainbow Sweep',
    'breathe': 'Breathing',
    'wave': 'Wave Effect',
    'metallic': 'Metallic Shine',
    'fire': 'Fire Effect',
  };

  final Map<Duration, String> _durations = {
    const Duration(milliseconds: 500): '0.5s',
    const Duration(milliseconds: 1000): '1.0s',
    const Duration(milliseconds: 2000): '2.0s',
    const Duration(milliseconds: 3000): '3.0s',
  };

  @override
  void initState() {
    super.initState();
    
    _rainbowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _breatheController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _rainbowController.dispose();
    _pulseController.dispose();
    _breatheController.dispose();
    super.dispose();
  }

  void _startContinuousAnimation(String effect) {
    switch (effect) {
      case 'rainbow':
        _rainbowController.repeat();
        break;
      case 'pulse':
        _pulseController.repeat(reverse: true);
        break;
      case 'breathe':
        _breatheController.repeat(reverse: true);
        break;
    }
  }

  void _stopAllAnimations() {
    _rainbowController.stop();
    _pulseController.stop();
    _breatheController.stop();
  }

  void _applySelectedAnimation() {
    _stopAllAnimations();
    
    switch (_selectedEffect) {
      case 'rainbow':
      case 'pulse':
      case 'breathe':
        _startContinuousAnimation(_selectedEffect);
        break;
      default:
        widget.onApplyAnimation(
          widget.areas,
          duration: _animationDuration,
          effect: _selectedEffect,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Animation Controls',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Effect Selection
            Row(
              children: [
                const Text('Effect: '),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedEffect,
                    isExpanded: true,
                    items: _effects.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedEffect = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Duration Selection
            Row(
              children: [
                const Text('Duration: '),
                Expanded(
                  child: DropdownButton<Duration>(
                    value: _animationDuration,
                    isExpanded: true,
                    items: _durations.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _animationDuration = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _applySelectedAnimation,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Apply'),
                ),
                ElevatedButton.icon(
                  onPressed: _stopAllAnimations,
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Quick Animation Buttons
            const Text(
              'Quick Effects:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildQuickButton('Pulse', Icons.favorite, () {
                  _selectedEffect = 'pulse';
                  _applySelectedAnimation();
                }),
                _buildQuickButton('Rainbow', Icons.color_lens, () {
                  _selectedEffect = 'rainbow';
                  _applySelectedAnimation();
                }),
                _buildQuickButton('Fire', Icons.local_fire_department, () {
                  _selectedEffect = 'fire';
                  _applySelectedAnimation();
                }),
                _buildQuickButton('Reset', Icons.refresh, () {
                  _stopAllAnimations();
                  _selectedEffect = 'fade_in';
                  _applySelectedAnimation();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: const TextStyle(fontSize: 12),
      ),
    );
  }
}
