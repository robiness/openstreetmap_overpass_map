import 'package:flutter/material.dart';
import 'package:overpass_map/app/theme/app_theme.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget sidebar;
  final Widget mapView;
  final List<Widget> topControls;
  final List<Widget> bottomControls;

  const ResponsiveLayout({
    super.key,
    required this.sidebar,
    required this.mapView,
    this.topControls = const [],
    this.bottomControls = const [],
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    final isMobile = screenWidth <= 768;

    if (isMobile) {
      return _buildMobileLayout(context);
    } else if (isTablet) {
      return _buildTabletLayout(context);
    } else {
      return _buildDesktopLayout(context);
    }
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 400,
            decoration: const BoxDecoration(
              color: AppTheme.cardColor,
              border: Border(
                right: BorderSide(color: AppTheme.borderColor),
              ),
            ),
            child: Column(
              children: [
                // App header
                _buildAppHeader(context),

                // Sidebar content
                Expanded(child: sidebar),
              ],
            ),
          ),

          // Main content area
          Expanded(
            child: Column(
              children: [
                // Top controls
                if (topControls.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingLg),
                    decoration: const BoxDecoration(
                      color: AppTheme.cardColor,
                      border: Border(
                        bottom: BorderSide(color: AppTheme.borderColor),
                      ),
                    ),
                    child: Row(
                      children: topControls
                          .expand(
                            (widget) => [
                              widget,
                              const SizedBox(width: AppTheme.spacingLg),
                            ],
                          )
                          .take(topControls.length * 2 - 1)
                          .toList(),
                    ),
                  ),

                // Map view
                Expanded(child: mapView),

                // Bottom controls
                if (bottomControls.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingLg),
                    decoration: const BoxDecoration(
                      color: AppTheme.cardColor,
                      border: Border(
                        top: BorderSide(color: AppTheme.borderColor),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: bottomControls
                          .expand(
                            (widget) => [
                              widget,
                              const SizedBox(width: AppTheme.spacingLg),
                            ],
                          )
                          .take(bottomControls.length * 2 - 1)
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: Row(
        children: [
          // Collapsible sidebar
          Container(
            width: 320,
            decoration: const BoxDecoration(
              color: AppTheme.cardColor,
              border: Border(
                right: BorderSide(color: AppTheme.borderColor),
              ),
            ),
            child: Column(
              children: [
                _buildAppHeader(context, compact: true),
                Expanded(child: sidebar),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Column(
              children: [
                if (topControls.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    child: Wrap(
                      spacing: AppTheme.spacingMd,
                      runSpacing: AppTheme.spacingMd,
                      children: topControls,
                    ),
                  ),

                Expanded(child: mapView),

                if (bottomControls.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    child: Wrap(
                      spacing: AppTheme.spacingMd,
                      children: bottomControls,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      appBar: _buildMobileAppBar(context),
      drawer: Drawer(
        backgroundColor: AppTheme.cardColor,
        child: sidebar,
      ),
      body: Column(
        children: [
          if (topControls.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: topControls
                      .expand(
                        (widget) => [
                          widget,
                          const SizedBox(width: AppTheme.spacingSm),
                        ],
                      )
                      .take(topControls.length * 2 - 1)
                      .toList(),
                ),
              ),
            ),

          Expanded(child: mapView),

          if (bottomControls.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: bottomControls
                      .expand(
                        (widget) => [
                          widget,
                          const SizedBox(width: AppTheme.spacingSm),
                        ],
                      )
                      .take(bottomControls.length * 2 - 1)
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAppHeader(BuildContext context, {bool compact = false}) {
    return Container(
      padding: EdgeInsets.all(
        compact ? AppTheme.spacingMd : AppTheme.spacingLg,
      ),
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            decoration: BoxDecoration(
              color: Colors.white..withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: const Icon(
              Icons.map,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: AppTheme.spacingMd),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overpass Map',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (!compact)
                  Text(
                    'Geographic Boundary Explorer',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingXs),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(
              Icons.map,
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: AppTheme.spacingSm),
          const Text('Overpass Map'),
        ],
      ),
      backgroundColor: AppTheme.cardColor,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
    );
  }
}
