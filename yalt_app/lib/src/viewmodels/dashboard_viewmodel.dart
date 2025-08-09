import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/daily_log.dart';
import '../models/custom_counter.dart';
import '../models/counter_event.dart';
import '../data/repository.dart';
import '../core/utils/date_utils.dart' as date_utils;
import '../core/utils/streak_calculator.dart';
import '../core/utils/fun_facts_generator.dart';

final dashboardViewModelProvider = AsyncNotifierProvider<DashboardViewModel, DashboardState>(
  () => DashboardViewModel(),
);

class DashboardViewModel extends AsyncNotifier<DashboardState> {
  late Repository _repository;
  late StreakCalculator _streakCalculator;
  late FunFactsGenerator _funFactsGenerator;
  
  @override
  Future<DashboardState> build() async {
    _repository = ref.read(repositoryProvider);
    _streakCalculator = StreakCalculator(_repository);
    _funFactsGenerator = FunFactsGenerator(_repository);
    
    return _loadDashboardData();
  }
  
  Future<DashboardState> _loadDashboardData() async {
    final today = DateTime.now();
    final todayLog = await _repository.getTodayLog();
    final counters = await _repository.getAllCounters();
    final recentLogs = await _getRecentLogs(7);
    
    // Calculate streaks
    final moodStreak = await _streakCalculator.computeCurrentStreak('mood');
    final sleepStreak = await _streakCalculator.computeCurrentStreak('sleep');
    final waterStreak = await _streakCalculator.computeCurrentStreak('water');
    
    // Generate fun fact
    final funFact = await _funFactsGenerator.generateRandomFact();
    
    // Calculate progress (how many metrics logged today)
    final progress = _calculateTodayProgress(todayLog);
    
    return DashboardState(
      todayLog: todayLog,
      customCounters: counters,
      recentLogs: recentLogs,
      moodStreak: moodStreak,
      sleepStreak: sleepStreak,
      waterStreak: waterStreak,
      funFact: funFact,
      todayProgress: progress,
    );
  }
  
  Future<List<DailyLog>> _getRecentLogs(int days) async {
    final allLogs = await _repository.getAllDailyLogs();
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    
    return allLogs
        .where((log) => log.date.isAfter(cutoffDate))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }
  
  double _calculateTodayProgress(DailyLog? todayLog) {
    if (todayLog == null) return 0.0;
    
    int loggedCount = 0;
    const totalMetrics = 4; // mood, energy, sleep, water
    
    if (todayLog.mood > 0) loggedCount++;
    if (todayLog.energy > 0) loggedCount++;
    if (todayLog.sleepHours > 0) loggedCount++;
    if (todayLog.waterCups > 0) loggedCount++;
    
    return loggedCount / totalMetrics;
  }
  
  Future<void> updateMood(int mood) async {
    await _updateTodayLog((log) => log.copyWith(mood: mood));
  }
  
  Future<void> updateEnergy(int energy) async {
    await _updateTodayLog((log) => log.copyWith(energy: energy));
  }
  
  Future<void> incrementWater() async {
    await _updateTodayLog((log) => log.copyWith(waterCups: log.waterCups + 1));
  }
  
  Future<void> decrementWater() async {
    await _updateTodayLog((log) => log.copyWith(
      waterCups: (log.waterCups - 1).clamp(0, 100),
    ));
  }
  
  Future<void> updateSleep(double hours) async {
    await _updateTodayLog((log) => log.copyWith(sleepHours: hours.clamp(0, 24)));
  }
  
  Future<void> incrementCustomCounter(String counterId) async {
    final counter = await _repository.getCounter(counterId);
    if (counter == null) return;
    
    // Create counter event
    final event = CounterEvent(
      id: const Uuid().v4(),
      counterId: counterId,
      timestamp: DateTime.now(),
      delta: counter.step,
    );
    
    await _repository.saveCounterEvent(event);
    
    // Update today's log if needed
    if (!counter.dailyReset) {
      await _updateTodayLog((log) {
        final updatedCounters = Map<String, double>.from(log.customCounters);
        updatedCounters[counterId] = (updatedCounters[counterId] ?? 0) + counter.step;
        return log.copyWith(customCounters: updatedCounters);
      });
    }
    
    // Refresh data
    state = AsyncValue.data(await _loadDashboardData());
  }
  
  Future<void> _updateTodayLog(DailyLog Function(DailyLog) updater) async {
    final today = date_utils.DateUtils.normalizeToLocalDate(DateTime.now());
    var todayLog = await _repository.getTodayLog();
    
    if (todayLog == null) {
      todayLog = DailyLog(
        id: const Uuid().v4(),
        date: today,
        mood: 0,
        energy: 0,
        sleepHours: 0,
        waterCups: 0,
        customCounters: {},
        updatedAt: DateTime.now(),
      );
    }
    
    final updatedLog = updater(todayLog).copyWith(updatedAt: DateTime.now());
    await _repository.saveDailyLog(updatedLog);
    
    // Refresh data
    state = AsyncValue.data(await _loadDashboardData());
  }
  
  Future<void> refresh() async {
    state = AsyncValue.data(await _loadDashboardData());
  }
}

class DashboardState {
  final DailyLog? todayLog;
  final List<CustomCounter> customCounters;
  final List<DailyLog> recentLogs;
  final int moodStreak;
  final int sleepStreak;
  final int waterStreak;
  final String funFact;
  final double todayProgress;
  
  DashboardState({
    this.todayLog,
    required this.customCounters,
    required this.recentLogs,
    required this.moodStreak,
    required this.sleepStreak,
    required this.waterStreak,
    required this.funFact,
    required this.todayProgress,
  });
}