import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/debug/presentation/bloc/debug_bloc.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      padding: EdgeInsets.all(appTheme.spacing.medium),
      color: appTheme.navigation,
      child: Row(
        children: [
          const Icon(Icons.map, color: Colors.white, size: 32),
          SizedBox(width: appTheme.spacing.medium),
          Expanded(
            child: Text(
              'Social Exploration Game',
              style: appTheme.typography.titleLarge.copyWith(
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
                          color: appTheme.warning.withAlpha(
                            (255 * 0.2).round(),
                          ),
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radiusSmall,
                          ),
                          border: Border.all(
                            color: appTheme.warning.withAlpha(
                              (255 * 0.5).round(),
                            ),
                          ),
                        ),
                        child: Text(
                          'DEBUG',
                          style: appTheme.typography.labelSmall.copyWith(
                            color: appTheme.warning,
                            fontWeight: FontWeight.bold,
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
                        color: isDebugMode ? appTheme.warning : Colors.white,
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
