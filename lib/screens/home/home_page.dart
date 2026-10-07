import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Design system

  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color background = Color(0xFFF8FAFC);
  static const Color darkText = Color(0xFF0F172A);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color mutedText = Color(0xFF94A3B8);
  static const Color borderColor = Color(0xFFE2E8F0);

  static const double cardRadius = 18;
  static const double sectionSpacing = 28;

  // ---------------------------------------------------------------------------
  // Dummy data
  // ---------------------------------------------------------------------------

  final int totalApplications = 12;
  final int totalInterviews = 4;
  final int totalAccepted = 2;
  final int totalPending = 6;

  String selectedPeriod = '7D';

  final List<UpcomingEvent> upcomingEvents = [
    const UpcomingEvent(
      type: EventType.interview,
      company: 'TechCorp Tunisia',
      position: 'Software Engineering Intern',
      time: 'Tomorrow · 10:00',
      color: Color(0xFF2563EB),
    ),
    const UpcomingEvent(
      type: EventType.followUp,
      company: 'ABC Technologies',
      position: 'Data Analyst Intern',
      time: 'Friday · 14:30',
      color: Color(0xFFF59E0B),
    ),
    const UpcomingEvent(
      type: EventType.deadline,
      company: 'ITGate Group',
      position: 'AI / Python Intern',
      time: 'Sunday · 23:59',
      color: Color(0xFF8B5CF6),
    ),
  ];

  final List<RecentApplication> recentApplications = [
    const RecentApplication(
      company: 'TechCorp',
      position: 'Software Engineering Intern',
      status: ApplicationStatus.interview,
      statusColor: Color(0xFF2563EB),
    ),
    const RecentApplication(
      company: 'ITGate Group',
      position: 'AI / Python Intern',
      status: ApplicationStatus.applied,
      statusColor: Color(0xFFF59E0B),
    ),
    const RecentApplication(
      company: 'DataVision',
      position: 'Business Intelligence Intern',
      status: ApplicationStatus.accepted,
      statusColor: Color(0xFF16A34A),
    ),
  ];

  // Chart data

  List<FlSpot> get chartSpots {
    if (selectedPeriod == '30D') {
      return const [
        FlSpot(0, 2),
        FlSpot(1, 4),
        FlSpot(2, 3),
        FlSpot(3, 6),
        FlSpot(4, 5),
        FlSpot(5, 8),
        FlSpot(6, 7),
        FlSpot(7, 10),
      ];
    }

    return const [
      FlSpot(0, 1),
      FlSpot(1, 3),
      FlSpot(2, 2),
      FlSpot(3, 5),
      FlSpot(4, 4),
      FlSpot(5, 7),
      FlSpot(6, 8),
    ];
  }

  List<String> get chartLabels {
    if (selectedPeriod == '30D') {
      return const ['1', '5', '10', '15', '20', '25', '28', '30'];
    }

    return const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  }

  double get chartMaxY {
    return selectedPeriod == '30D' ? 12 : 10;
  }

  // Build

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding =
                    constraints.maxWidth >= 900 ? 32.0 : 20.0;

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),
                      _buildWelcomeCard(),
                      const SizedBox(height: sectionSpacing),
                      _buildSectionHeader(
                        title: 'Overview',
                        subtitle: 'Your internship search at a glance',
                      ),
                      const SizedBox(height: 14),
                      _buildStatistics(constraints.maxWidth),
                      const SizedBox(height: sectionSpacing),
                      _buildQuickActions(constraints.maxWidth),
                      const SizedBox(height: sectionSpacing),
                      _buildApplicationProgress(),
                      const SizedBox(height: 16),
                      _buildSearchProgress(),
                      const SizedBox(height: sectionSpacing),
                      _buildUpcomingSection(),
                      const SizedBox(height: sectionSpacing),
                      _buildRecentApplicationsSection(),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Header

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 72,
      titleSpacing: 20,
      title: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.track_changes_rounded,
              color: Colors.white,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'InternTrack',
                style: TextStyle(
                  color: darkText,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Internship tracker',
                style: TextStyle(
                  color: mutedText,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          _HeaderIconButton(
            icon: Icons.notifications_none_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // Welcome card

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            top: -45,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -70,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Good morning',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Ready to find your\nnext opportunity?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Keep your applications organized and stay on top of every opportunity.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  _WelcomeMetric(
                    value: totalApplications.toString(),
                    label: 'Applications',
                  ),
                  const SizedBox(width: 28),
                  _WelcomeMetric(
                    value: totalInterviews.toString(),
                    label: 'Interviews',
                  ),
                  const SizedBox(width: 28),
                  _WelcomeMetric(
                    value: totalAccepted.toString(),
                    label: 'Accepted',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Section header

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: darkText,
            fontSize: 19,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: secondaryText,
            fontSize: 12.5,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  // Statistics

  Widget _buildStatistics(double width) {
    final crossAxisCount = width >= 900 ? 4 : 2;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: width >= 900 ? 1.45 : 1.25,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        StatisticCard(
          value: totalApplications,
          label: 'Applications',
          icon: Icons.description_outlined,
          progress: 0.75,
          accentColor: primaryBlue,
        ),
        StatisticCard(
          value: totalInterviews,
          label: 'Interviews',
          icon: Icons.calendar_month_outlined,
          progress: 0.50,
          accentColor: const Color(0xFF7C3AED),
        ),
        StatisticCard(
          value: totalAccepted,
          label: 'Accepted',
          icon: Icons.check_circle_outline_rounded,
          progress: 0.35,
          accentColor: const Color(0xFF16A34A),
        ),
        StatisticCard(
          value: totalPending,
          label: 'Pending',
          icon: Icons.hourglass_empty_rounded,
          progress: 0.60,
          accentColor: const Color(0xFFF59E0B),
        ),
      ],
    );
  }

  // Quick actions

  Widget _buildQuickActions(double width) {
    final isWide = width >= 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            color: darkText,
            fontSize: 19,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickAction(
                icon: Icons.add_rounded,
                title: 'Add Application',
                subtitle:
                    isWide ? 'Track a new opportunity' : 'New application',
                filled: true,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickAction(
                icon: Icons.event_available_outlined,
                title: 'Add Event',
                subtitle: isWide ? 'Schedule an important date' : 'New event',
                filled: false,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Application chart

  Widget _buildApplicationProgress() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Application Progress',
                      style: TextStyle(
                        color: darkText,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Applications submitted over time',
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _buildPeriodSelector(),
            ],
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 230,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: selectedPeriod == '30D' ? 7 : 6,
                minY: 0,
                maxY: chartMaxY,
                clipData: const FlClipData.all(),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: borderColor,
                      strokeWidth: 0.8,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: mutedText,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 26,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();

                        if (index < 0 || index >= chartLabels.length) {
                          return const SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            chartLabels[index],
                            style: const TextStyle(
                              color: mutedText,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: chartSpots,
                    isCurved: true,
                    curveSmoothness: 0.25,
                    color: primaryBlue,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: index == chartSpots.length - 1 ? 4 : 3,
                          color: primaryBlue,
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          primaryBlue.withValues(alpha: 0.16),
                          primaryBlue.withValues(alpha: 0.01),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PeriodButton(
            label: '7D',
            selected: selectedPeriod == '7D',
            onTap: () {
              setState(() {
                selectedPeriod = '7D';
              });
            },
          ),
          _PeriodButton(
            label: '30D',
            selected: selectedPeriod == '30D',
            onTap: () {
              setState(() {
                selectedPeriod = '30D';
              });
            },
          ),
        ],
      ),
    );
  }

  // Search progress

  Widget _buildSearchProgress() {
    const progress = 0.65;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: primaryBlue.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.flag_outlined,
                  color: primaryBlue,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Internship Search',
                      style: TextStyle(
                        color: darkText,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Keep going! You are making progress.',
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '65%',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFEFF3F8),
                  valueColor: const AlwaysStoppedAnimation(primaryBlue),
                );
              },
            ),
          ),
          const SizedBox(height: 9),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '12 applications tracked',
                style: TextStyle(
                  color: mutedText,
                  fontSize: 10.5,
                ),
              ),
              Text(
                'Goal: 20',
                style: TextStyle(
                  color: mutedText,
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Upcoming events

  Widget _buildUpcomingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitleWithAction(
          title: 'Upcoming',
          action: 'View all',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        ...upcomingEvents.map(
          (event) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: UpcomingEventCard(event: event),
          ),
        ),
      ],
    );
  }

  // Recent applications

  Widget _buildRecentApplicationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitleWithAction(
          title: 'Recent Applications',
          action: 'View all',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        ...recentApplications.map(
          (application) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: RecentApplicationCard(
              application: application,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitleWithAction({
    required String title,
    required String action,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: darkText,
            fontSize: 19,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: primaryBlue,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            minimumSize: const Size(0, 36),
          ),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // Helpers

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(cardRadius),
      border: Border.all(
        color: borderColor,
        width: 0.8,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.025),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

// Statistic Card

class StatisticCard extends StatefulWidget {
  final int value;
  final String label;
  final IconData icon;
  final double progress;
  final Color accentColor;

  const StatisticCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.progress,
    required this.accentColor,
  });

  @override
  State<StatisticCard> createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: pressed ? 0.98 : 1,
      duration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTapDown: (_) => setState(() => pressed = true),
        onTapUp: (_) => setState(() => pressed = false),
        onTapCancel: () => setState(() => pressed = false),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 0.8,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: widget.accentColor.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.accentColor,
                      size: 18,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_horiz_rounded,
                    color: Color(0xFFCBD5E1),
                    size: 18,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                widget.value.toString(),
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0,
                    end: widget.progress,
                  ),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      minHeight: 4,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: AlwaysStoppedAnimation(
                        widget.accentColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Quick Action

class _QuickAction extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool filled;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.filled,
    required this.onTap,
  });

  @override
  State<_QuickAction> createState() => _QuickActionState();
}

class _QuickActionState extends State<_QuickAction> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.filled ? const Color(0xFF2563EB) : Colors.white;

    final foregroundColor =
        widget.filled ? Colors.white : const Color(0xFF2563EB);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => pressed = true),
      onTapUp: (_) => setState(() => pressed = false),
      onTapCancel: () => setState(() => pressed = false),
      child: AnimatedScale(
        scale: pressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color:
                  widget.filled ? Colors.transparent : const Color(0xFFE2E8F0),
            ),
            boxShadow: widget.filled
                ? [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: widget.filled
                      ? Colors.white.withValues(alpha: 0.14)
                      : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  widget.icon,
                  color: foregroundColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: widget.filled
                            ? Colors.white.withValues(alpha: 0.72)
                            : const Color(0xFF94A3B8),
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: widget.filled
                    ? Colors.white.withValues(alpha: 0.75)
                    : const Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Upcoming Event Card

class UpcomingEventCard extends StatelessWidget {
  final UpcomingEvent event;

  const UpcomingEventCard({
    super.key,
    required this.event,
  });

  IconData get eventIcon {
    switch (event.type) {
      case EventType.interview:
        return Icons.video_call_outlined;
      case EventType.followUp:
        return Icons.mark_email_read_outlined;
      case EventType.deadline:
        return Icons.alarm_outlined;
      case EventType.response:
        return Icons.markunread_outlined;
      case EventType.internshipStart:
        return Icons.work_outline_rounded;
    }
  }

  String get eventTypeLabel {
    switch (event.type) {
      case EventType.interview:
        return 'Interview';
      case EventType.followUp:
        return 'Follow-up';
      case EventType.deadline:
        return 'Application deadline';
      case EventType.response:
        return 'Expected response';
      case EventType.internshipStart:
        return 'Internship starts';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 0.8,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: event.color.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  eventIcon,
                  color: event.color,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            eventTypeLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: event.color,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.company,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      event.position,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    event.time.split(' · ').first,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (event.time.contains(' · '))
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        event.time.split(' · ').last,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  const SizedBox(height: 5),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFCBD5E1),
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Recent Application Card

class RecentApplicationCard extends StatelessWidget {
  final RecentApplication application;

  const RecentApplicationCard({
    super.key,
    required this.application,
  });

  String get statusLabel {
    switch (application.status) {
      case ApplicationStatus.applied:
        return 'Applied';
      case ApplicationStatus.interview:
        return 'Interview';
      case ApplicationStatus.accepted:
        return 'Accepted';
      case ApplicationStatus.rejected:
        return 'Rejected';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 0.8,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.business_outlined,
                  color: Color(0xFF2563EB),
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.company,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      application.position,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: application.statusColor.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    color: application.statusColor,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFCBD5E1),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Period selector

class _PeriodButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PeriodButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF2563EB) : const Color(0xFF94A3B8),
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// Header icon button

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
            ),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF475569),
            size: 21,
          ),
        ),
      ),
    );
  }
}

// Welcome metric

class _WelcomeMetric extends StatelessWidget {
  final String value;
  final String label;

  const _WelcomeMetric({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.68),
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Models
// =============================================================================

enum EventType {
  interview,
  followUp,
  deadline,
  response,
  internshipStart,
}

enum ApplicationStatus {
  applied,
  interview,
  accepted,
  rejected,
}

class UpcomingEvent {
  final EventType type;
  final String company;
  final String position;
  final String time;
  final Color color;

  const UpcomingEvent({
    required this.type,
    required this.company,
    required this.position,
    required this.time,
    required this.color,
  });
}

class RecentApplication {
  final String company;
  final String position;
  final ApplicationStatus status;
  final Color statusColor;

  const RecentApplication({
    required this.company,
    required this.position,
    required this.status,
    required this.statusColor,
  });
}
