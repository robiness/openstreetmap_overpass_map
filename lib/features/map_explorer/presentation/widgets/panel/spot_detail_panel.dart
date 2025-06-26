import 'package:flutter/material.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

class SpotDetailPanel extends StatelessWidget {
  final Spot? spot;

  const SpotDetailPanel({super.key, this.spot});

  @override
  Widget build(BuildContext context) {
    if (spot == null) {
      return const SizedBox.shrink();
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(spot!.name),
      ),
    );
  }
}
