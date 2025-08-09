import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../widgets/mood_selector.dart';
import '../../widgets/quick_counter.dart';
import '../../widgets/streak_card.dart';
import '../../widgets/mini_chart.dart';
import '../../widgets/fun_fact_card.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardViewModelProvider);

    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await ref.read(dashboardViewModelProvider.notifier).refresh();
            },
            child: dashboardState.when(
              data: (state) => _buildDashboard(context, state),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error loading dashboard: $error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(dashboardViewModelProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 3.14 / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, DashboardState state) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date_utils.DateUtils.formatDateLong(DateTime.now()),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: state.todayProgress,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
            titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildQuickLogSection(context, state),
              const SizedBox(height: 24),
              _buildStreaksSection(context, state),
              const SizedBox(height: 24),
              _buildChartsSection(context, state),
              const SizedBox(height: 24),
              _buildCustomCountersSection(context, state),
              const SizedBox(height: 24),
              FunFactCard(funFact: state.funFact),
              const SizedBox(height: 100), // Space for FAB
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLogSection(BuildContext context, DashboardState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Log',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Mood selector
            MoodSelector(
              selectedMood: state.todayLog?.mood ?? 0,
              onMoodSelected: (mood) {
                ref.read(dashboardViewModelProvider.notifier).updateMood(mood);
                if (mood >= 4) _confettiController.play();
              },
            ),
            
            const SizedBox(height: 16),
            
            // Water and sleep counters
            Row(
              children: [
                Expanded(
                  child: QuickCounter(
                    icon: Icons.local_drink,
                    label: 'Water',
                    value: '${state.todayLog?.waterCups ?? 0}',
                    unit: 'cups',
                    onIncrement: () {
                      ref.read(dashboardViewModelProvider.notifier).incrementWater();
                    },
                    onDecrement: () {
                      ref.read(dashboardViewModelProvider.notifier).decrementWater();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: QuickCounter(
                    icon: Icons.bedtime,
                    label: 'Sleep',
                    value: '${state.todayLog?.sleepHours.toStringAsFixed(1) ?? '0.0'}',
                    unit: 'hrs',
                    onIncrement: () {
                      final current = state.todayLog?.sleepHours ?? 0;
                      ref.read(dashboardViewModelProvider.notifier).updateSleep(current + 0.5);
                    },
                    onDecrement: () {
                      final current = state.todayLog?.sleepHours ?? 0;
                      ref.read(dashboardViewModelProvider.notifier).updateSleep(current - 0.5);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildStreaksSection(BuildContext context, DashboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Streaks',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StreakCard(
                icon: Icons.mood,
                label: 'Mood',
                streak: state.moodStreak,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StreakCard(
                icon: Icons.bedtime,
                label: 'Sleep',
                streak: state.sleepStreak,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StreakCard(
                icon: Icons.local_drink,
                label: 'Water',
                streak: state.waterStreak,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildChartsSection(BuildContext context, DashboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last 7 Days',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: MiniChart(logs: state.recentLogs),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildCustomCountersSection(BuildContext context, DashboardState state) {
    if (state.customCounters.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Counters',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...state.customCounters.map((counter) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppConstants.counterColors[counter.colorIndex % AppConstants.counterColors.length],
                child: Text(
                  counter.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(counter.name),
              subtitle: Text('${counter.unit} • Step: ${counter.step}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      ref.read(dashboardViewModelProvider.notifier).incrementCustomCounter(counter.id);
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
          ),
        )),
      ],
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0);
  }
}