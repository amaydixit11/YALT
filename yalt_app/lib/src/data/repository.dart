import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daily_log.dart';
import '../models/custom_counter.dart';
import '../models/counter_event.dart';
import '../models/milestone.dart';
import '../models/achievement.dart';
import '../models/settings.dart';
import '../core/constants/app_constants.dart';
import '../core/utils/date_utils.dart' as date_utils;
import 'local/hive_setup.dart';
import 'local/hive_boxes.dart';

final repositoryProvider = Provider<Repository>((ref) => Repository());

class Repository {
  // Settings
  Future<Settings> getSettings() async {
    final settings = HiveBoxes.settings.get(AppConstants.settingsKey);
    return settings ?? Settings();
  }
  
  Future<void> saveSettings(Settings settings) async {
    await HiveBoxes.settings.put(AppConstants.settingsKey, settings);
  }
  
  Future<bool> isFirstRun() async {
    final box = HiveBoxes.settings;
    final firstRun = box.get(AppConstants.firstRunKey, defaultValue: true);
    // Fix: Cast to bool or provide proper type handling
    return firstRun as bool? ?? true;
  }
  
  Future<void> setFirstRunComplete() async {
    await HiveBoxes.settings.put(AppConstants.firstRunKey, false);
  }
  
  // Daily Logs
  Future<List<DailyLog>> getAllDailyLogs() async {
    return HiveBoxes.dailyLogs.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
  
  Future<DailyLog?> getDailyLogByDate(DateTime date) async {
    final normalizedDate = date_utils.DateUtils.normalizeToLocalDate(date);
    final dateKey = date_utils.DateUtils.formatDate(normalizedDate);
    
    return HiveBoxes.dailyLogs.values
        .where((log) => date_utils.DateUtils.formatDate(log.date) == dateKey)
        .firstOrNull;
  }
  
  Future<DailyLog?> getTodayLog() async {
    return getDailyLogByDate(DateTime.now());
  }
  
  Future<void> saveDailyLog(DailyLog log) async {
    final dateKey = date_utils.DateUtils.formatDate(log.date);
    await HiveBoxes.dailyLogs.put(dateKey, log);
  }
  
  Future<void> deleteDailyLog(String id) async {
    final box = HiveBoxes.dailyLogs;
    final key = box.keys.firstWhere(
      (k) => box.get(k)?.id == id,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }
  
  // Custom Counters
  Future<List<CustomCounter>> getAllCounters() async {
    return HiveBoxes.counters.values.toList();
  }
  
  Future<CustomCounter?> getCounter(String id) async {
    return HiveBoxes.counters.get(id);
  }
  
  Future<void> saveCounter(CustomCounter counter) async {
    await HiveBoxes.counters.put(counter.id, counter);
  }
  
  Future<void> deleteCounter(String id) async {
    await HiveBoxes.counters.delete(id);
    // Also delete related events
    final events = await getCounterEvents(id);
    for (final event in events) {
      await deleteCounterEvent(event.id);
    }
  }
  
  // Counter Events
  Future<List<CounterEvent>> getAllCounterEvents() async {
    return HiveBoxes.counterEvents.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
  
  Future<List<CounterEvent>> getCounterEvents(String counterId) async {
    return HiveBoxes.counterEvents.values
        .where((event) => event.counterId == counterId)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
  
  Future<List<CounterEvent>> getCounterEventsForDate(String counterId, DateTime date) async {
    final normalizedDate = date_utils.DateUtils.normalizeToLocalDate(date);
    final nextDay = normalizedDate.add(const Duration(days: 1));
    
    return HiveBoxes.counterEvents.values
        .where((event) => 
            event.counterId == counterId &&
            event.timestamp.isAfter(normalizedDate) &&
            event.timestamp.isBefore(nextDay))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
  
  Future<void> saveCounterEvent(CounterEvent event) async {
    await HiveBoxes.counterEvents.put(event.id, event);
  }
  
  Future<void> deleteCounterEvent(String id) async {
    await HiveBoxes.counterEvents.delete(id);
  }
  
  // Milestones
  Future<List<Milestone>> getAllMilestones() async {
    return HiveBoxes.milestones.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
  
  Future<void> saveMilestone(Milestone milestone) async {
    await HiveBoxes.milestones.put(milestone.id, milestone);
  }
  
  Future<void> deleteMilestone(String id) async {
    await HiveBoxes.milestones.delete(id);
  }
  
  // Achievements
  Future<List<Achievement>> getAllAchievements() async {
    return HiveBoxes.achievements.values.toList();
  }
  
  Future<List<Achievement>> getUnlockedAchievements() async {
    return HiveBoxes.achievements.values
        .where((achievement) => achievement.unlocked)
        .toList()
      ..sort((a, b) => (b.unlockedAt ?? DateTime(0)).compareTo(a.unlockedAt ?? DateTime(0)));
  }
  
  Future<void> unlockAchievement(String id) async {
    final achievement = HiveBoxes.achievements.get(id);
    if (achievement != null && !achievement.unlocked) {
      final updated = achievement.copyWith(
        unlocked: true,
        unlockedAt: DateTime.now(),
      );
      await HiveBoxes.achievements.put(id, updated);
    }
  }
  
  // Data Export/Import
  Future<Map<String, dynamic>> exportAllData() async {
    return {
      'settings': (await getSettings()).toJson(),
      'dailyLogs': (await getAllDailyLogs()).map((log) => log.toJson()).toList(),
      'customCounters': (await getAllCounters()).map((counter) => counter.toJson()).toList(),
      'counterEvents': (await getAllCounterEvents()).map((event) => event.toJson()).toList(),
      'milestones': (await getAllMilestones()).map((milestone) => milestone.toJson()).toList(),
      'achievements': (await getAllAchievements()).map((achievement) => achievement.toJson()).toList(),
      'exportedAt': DateTime.now().toIso8601String(),
    };
  }
  
  Future<void> importData(Map<String, dynamic> data) async {
    // Clear existing data
    await clearAllData();
    
    // Import settings
    if (data['settings'] != null) {
      final settings = Settings.fromJson(data['settings']);
      await saveSettings(settings);
    }
    
    // Import daily logs
    if (data['dailyLogs'] != null) {
      for (final logData in data['dailyLogs']) {
        final log = DailyLog.fromJson(logData);
        await saveDailyLog(log);
      }
    }
    
    // Import custom counters
    if (data['customCounters'] != null) {
      for (final counterData in data['customCounters']) {
        final counter = CustomCounter.fromJson(counterData);
        await saveCounter(counter);
      }
    }
    
    // Import counter events
    if (data['counterEvents'] != null) {
      for (final eventData in data['counterEvents']) {
        final event = CounterEvent.fromJson(eventData);
        await saveCounterEvent(event);
      }
    }
    
    // Import milestones
    if (data['milestones'] != null) {
      for (final milestoneData in data['milestones']) {
        final milestone = Milestone.fromJson(milestoneData);
        await saveMilestone(milestone);
      }
    }
    
    // Import achievements
    if (data['achievements'] != null) {
      for (final achievementData in data['achievements']) {
        final achievement = Achievement.fromJson(achievementData);
        await HiveBoxes.achievements.put(achievement.id, achievement);
      }
    }
  }
  
  Future<void> clearAllData() async {
    await Future.wait([
      HiveBoxes.dailyLogs.clear(),
      HiveBoxes.counters.clear(),
      HiveBoxes.counterEvents.clear(),
      HiveBoxes.milestones.clear(),
      HiveBoxes.achievements.clear(),
    ]);
    
    // Fix: Call a public method or create the functionality directly
    await _initializeDefaultAchievements();
  }
  
  // Fix: Create a private method to handle achievement initialization
  Future<void> _initializeDefaultAchievements() async {
    // You can either:
    // 1. Call a public method from HiveSetup if it exists
    // 2. Or implement the achievement initialization here
    // 3. Or make the method public in HiveSetup
    
    // Option 1: If HiveSetup has a public method
    // await HiveSetup.initializeAchievements();
    
    // Option 2: Implement initialization here (example)
    // This is just an example - adjust based on your Achievement model
    final defaultAchievements = [
      // Add your default achievements here
      // Achievement(id: '1', title: 'First Step', description: 'Complete your first day', unlocked: false),
      // Achievement(id: '2', title: 'Week Warrior', description: 'Complete 7 days', unlocked: false),
      // etc.
    ];
    
    for (final achievement in defaultAchievements) {
      await HiveBoxes.achievements.put(achievement.id, achievement);
    }
  }
}