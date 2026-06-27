import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/responsive.dart';
import '../models/dashboard_data.dart';
import '../widgets/sidebar.dart';
import '../widgets/top_bar.dart';
import '../widgets/banner_card.dart';
import '../widgets/project_list.dart';
import '../widgets/top_team_card.dart';
import '../widgets/performance_chart_card.dart';
import '../widgets/office_schedule_card.dart';
import '../widgets/celebration_card.dart';
import 'campaigns_screen.dart';

const _navTitles = [
  'Home',
  'Campaigns',
  'Employees',
  'Attendance',
  'Summary',
  'Information',
];

String _titleFor(int index) =>
    index >= 0 && index < _navTitles.length ? _navTitles[index] : 'Home';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNav = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final showRightRail = Responsive.showRightRail(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.scaffold,
      drawer: isMobile
          ? Drawer(
              child: Sidebar(
                selectedIndex: _selectedNav,
                onSelect: (i) {
                  setState(() => _selectedNav = i);
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDesktop)
              Sidebar(
                selectedIndex: _selectedNav,
                onSelect: (i) => setState(() => _selectedNav = i),
                collapsed: !Responsive.showRightRail(context) &&
                    MediaQuery.of(context).size.width < 1300,
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 16 : 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(
                      title: _titleFor(_selectedNav),
                      onMenuTap: () =>
                          _scaffoldKey.currentState?.openDrawer(),
                    ),
                    const SizedBox(height: 24),
                    _selectedNav == 1
                        ? const CampaignsScreen()
                        : _selectedNav == 0
                            ? _MainContent(
                                showRightRailInline: !showRightRail)
                            : const _ComingSoon(),
                  ],
                ),
              ),
            ),
            if (showRightRail)
              Container(
                width: 300,
                padding: const EdgeInsets.fromLTRB(0, 28, 28, 28),
                child: const _RightRail(),
              ),
          ],
        ),
      ),
    );
  }
}

/// Center column: banner, projects, team, performance chart.
/// On screens too narrow for the right rail, the schedule/celebration
/// widgets are appended below as a responsive fallback.
class _MainContent extends StatelessWidget {
  final bool showRightRailInline;
  const _MainContent({required this.showRightRailInline});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final twoCol = !isMobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BannerCard(),
        const SizedBox(height: 20),
        twoCol
            ? IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex: isTablet ? 1 : 3, child: const ProjectList()),
                    const SizedBox(width: 20),
                    Expanded(flex: isTablet ? 1 : 2, child: const TopTeamCard()),
                  ],
                ),
              )
            : Column(
                children: const [
                  ProjectList(),
                  SizedBox(height: 20),
                  TopTeamCard(),
                ],
              ),
        const SizedBox(height: 20),
        const PerformanceChartCard(),
        if (showRightRailInline) ...[
          const SizedBox(height: 20),
          twoCol
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: OfficeScheduleCard()),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          CelebrationCard(
                            title: 'Today Birthday',
                            people: DashboardData.birthdays,
                            ctaLabel: 'Birthday Wishing',
                            accent: AppColors.brandPink,
                          ),
                          const SizedBox(height: 16),
                          CelebrationCard(
                            title: 'Anniversary',
                            people: DashboardData.anniversaries,
                            ctaLabel: 'Anniversary Wishing',
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const OfficeScheduleCard(),
                    const SizedBox(height: 16),
                    CelebrationCard(
                      title: 'Today Birthday',
                      people: DashboardData.birthdays,
                      ctaLabel: 'Birthday Wishing',
                      accent: AppColors.brandPink,
                    ),
                    const SizedBox(height: 16),
                    CelebrationCard(
                      title: 'Anniversary',
                      people: DashboardData.anniversaries,
                      ctaLabel: 'Anniversary Wishing',
                    ),
                  ],
                ),
        ],
      ],
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(Icons.construction_rounded,
              size: 40, color: AppColors.textSecondary.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          const Text(
            'This section is coming soon',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _RightRail extends StatelessWidget {
  const _RightRail();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const OfficeScheduleCard(),
          const SizedBox(height: 16),
          CelebrationCard(
            title: 'Today Birthday',
            people: DashboardData.birthdays,
            ctaLabel: 'Birthday Wishing',
            accent: AppColors.brandPink,
          ),
          const SizedBox(height: 16),
          CelebrationCard(
            title: 'Anniversary',
            people: DashboardData.anniversaries,
            ctaLabel: 'Anniversary Wishing',
          ),
        ],
      ),
    );
  }
}
