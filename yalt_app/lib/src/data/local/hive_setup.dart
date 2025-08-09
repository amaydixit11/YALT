import 'package:hive_flutter/hive_flutter.dart';
import '../../models/daily_log.dart';
import '../../models/custom_counter.dart';
import '../../models/counter_event.dart';
import '../../models/milestone.dart';
import '../../models/achievement.dart';
import '../../models/settings.dart';
import '../../core/constants/app_constants.dart';

class HiveSetup {
  static Future<void> initialize() async {
    // Register adapters
    Hive.registerAdapter(DailyLogAdapter());
    Hive.registerAdapter(CustomCounterAdapter());
    Hive.registerAdapter(CounterEventAdapter());
    Hive.registerAdapter(MilestoneAdapter());
    Hive.registerAdapter(AchievementAdapter());
    Hive.registerAdapter(SettingsAdapter());
    
    // Open boxes
    await Future.wait([
      Hive.openBox<DailyLog>(AppConstants.dailyLogsBox),
      Hive.openBox<CustomCounter>(AppConstants.countersBox),
      Hive.openBox<CounterEvent>(AppConstants.counterEventsBox),
      Hive.openBox<Milestone>(AppConstants.milestonesBox),
      Hive.openBox<Achievement>(AppConstants.achievementsBox),
      Hive.openBox<Settings>(AppConstants.settingsBox),
    ]);
    
    // Initialize default data if needed
    await _initializeDefaultData();
  }
  
  static Future<void> _initializeDefaultData() async {
    final settingsBox = Hive.box<Settings>(AppConstants.settingsBox);
    final achievementsBox = Hive.box<Achievement>(AppConstants.achievementsBox);
    
    // Initialize settings if not exists
    if (settingsBox.get(AppConstants.settingsKey) == null) {
      await settingsBox.put(AppConstants.settingsKey, Settings());
    }
    
    // Initialize achievements if empty
    if (achievementsBox.isEmpty) {
      await _initializeAchievements();
    }
  }
  
  static Future<void> _initializeAchievements() async {
    final achievementsBox = Hive.box<Achievement>(AppConstants.achievementsBox);
    
    final achievements = [
      Achievement(
        id: 'first_log',
        title: 'First Steps',
        description: 'Log your first day',
        iconName: 'star',
      ),
      Achievement(
        id: 'week_streak',
        title: 'Week Warrior',
        description: 'Log for 7 consecutive days',
        iconName: 'calendar',
      ),
      Achievement(
        id: 'month_streak',
        title: 'Monthly Master',
        description: 'Log for 30 consecutive days',
        iconName: 'trophy',
      ),
      Achievement(
        id: 'hydration_hero',
        title: 'Hydration Hero',
        description: 'Drink 8+ cups of water in a day',
        iconName: 'water_drop',
      ),
      Achievement(
        id: 'sleep_champion',
        title: 'Sleep Champion',
        description: 'Get 8+ hours of sleep',
        iconName: 'bed',
      ),
      Achievement(
        id: 'mood_master',
        title: 'Mood Master',
        description: 'Stay happy for 7 consecutive days',
        iconName: 'emoji_emotions',
      ),
    ];
    
    for (final achievement in achievements) {
      await achievementsBox.put(achievement.id, achievement);
    }
  }
}