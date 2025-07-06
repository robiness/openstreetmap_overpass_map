import 'package:flutter/material.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/debug/presentation/widgets/debug_panel.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/lists/hierarchical_area_list.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/map_view.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/panel/spot_detail_panel.dart';

class DesktopLayout extends StatefulWidget {
  final BoundaryData boundaryData;
  final List<Spot> spots;
  final GeographicArea? selectedArea;
  final Spot? selectedSpot;
  final Map<String, UserAreaData> userAreaData;
  final Map<String, UserSpotData> userSpotVisitData;
  final Function(GeographicArea) onAreaTapped;
  final Function(Spot) onSpotTapped;

  const DesktopLayout({
    super.key,
    required this.boundaryData,
    required this.spots,
    required this.selectedArea,
    required this.selectedSpot,
    required this.userAreaData,
    required this.userSpotVisitData,
    required this.onAreaTapped,
    required this.onSpotTapped,
  });

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    print(widget.selectedArea?.name);
    return Row(
      children: [
        // Sidebar with tabs
        Container(
          width: 400,
          decoration: BoxDecoration(
            color: appTheme.surface,
            border: Border(
              right: BorderSide(color: appTheme.outline),
            ),
          ),
          child: Column(
            children: [
              // Tab Bar
              Container(
                decoration: BoxDecoration(
                  color: appTheme.surface,
                  border: Border(
                    bottom: BorderSide(color: appTheme.outline),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.location_city,
                        color: appTheme.navigation,
                        size: 20,
                      ),
                      text: 'Areas',
                    ),
                    Tab(
                      icon: Icon(
                        Icons.bug_report,
                        color: appTheme.currentState,
                        size: 20,
                      ),
                      text: 'Debug',
                    ),
                  ],
                  labelColor: appTheme.onSurface,
                  unselectedLabelColor: appTheme.onSurfaceVariant,
                  indicatorColor: appTheme.navigation,
                  indicatorWeight: 3.0,
                  labelStyle: appTheme.typography.labelLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: appTheme.typography.labelLarge.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Tab Content - Full Height
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Areas Tab - Full height for areas list
                    Container(
                      color: appTheme.surface,
                      child: HierarchicalAreaList(
                        boundaryData: widget.boundaryData,
                        selectedArea: widget.selectedArea,
                        userVisitData: widget.userAreaData,
                        onAreaTapped: widget.onAreaTapped,
                      ),
                    ),

                    // Debug Tab - Full height for debug panel
                    Container(
                      color: appTheme.surface,
                      padding: EdgeInsets.all(appTheme.spacing.medium),
                      child: const DebugPanelView(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Main Map Area
        Expanded(
          child: Stack(
            children: [
              MapView(
                boundaryData: widget.boundaryData,
                spots: widget.spots,
                selectedArea: widget.selectedArea,
                selectedSpot: widget.selectedSpot,
                userAreaVisitData: widget.userAreaData,
                userSpotVisitData: widget.userSpotVisitData,
              ),

              // Spot Detail Panel (overlay)
              if (widget.selectedSpot != null)
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    width: 320,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: SpotDetailPanel(
                      spot: widget.selectedSpot!,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
