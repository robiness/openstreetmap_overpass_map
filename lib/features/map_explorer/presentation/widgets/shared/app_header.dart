import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/debug/presentation/bloc/debug_bloc.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      color: AppTheme.primaryColor,
      child: Row(
        children: [
          const Icon(Icons.map, color: Colors.white, size: 32),
          const SizedBox(width: AppTheme.spacingMd),
          const Expanded(
            child: Text(
              'Social Exploration Game',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Debug mode toggle (only visible in debug builds)
          if (kDebugMode)
            BlocBuilder<DebugBloc, DebugState>(
              builder: (context, state) {
                final isDebugMode = state.isDebugModeEnabled;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isDebugMode)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.orange.withOpacity(0.5),
                          ),
                        ),
                        child: const Text(
                          'DEBUG',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        context.read<DebugBloc>().add(
                          const DebugEvent.toggleDebugMode(),
                        );
                      },
                      icon: Icon(
                        isDebugMode
                            ? Icons.bug_report
                            : Icons.bug_report_outlined,
                        color: isDebugMode ? Colors.orange : Colors.white,
                      ),
                      tooltip: isDebugMode
                          ? 'Disable Debug Mode'
                          : 'Enable Debug Mode',
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
