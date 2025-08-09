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
    try {
      // Register adapters
      Hive.registerAdapter(DailyLogAdapter());
      Hive.registerAdapter(CustomCounterAdapter());
      Hive.registerAdapter(CounterEventAdapter());
      Hive.registerAdapter(MilestoneAdapter());
      Hive.registerAdapter(AchievementAdapter());
      Hive.registerAdapter(SettingsAdapter());
      
      // Open boxes with error handling
      await Future.wait([
        _openBoxSafely<DailyLog>(AppConstants.dailyLogsBox),
        _openBoxSafely<CustomCounter>(AppConstants.countersBox),
        _openBoxSafely<CounterEvent>(AppConstants.counterEventsBox),
        _openBoxSafely<Milestone>(AppConstants.milestonesBox),
        _openBoxSafely<Achievement>(AppConstants.achievementsBox),
        _openBoxSafely<Settings>(AppConstants.settingsBox),
        _openBoxSafely('simple_storage'), // For simple storage
      ]);
      
      // Initialize default data if needed
      await _initializeDefaultData();
      
      print('Hive initialization completed successfully');
    } catch (e) {
      print('Error initializing Hive: $e');
      rethrow;
    }
  }
  
  static Future<Box<T>> _openBoxSafely<T>(String boxName) async {
    try {
      return await Hive.openBox<T>(boxName);
    } catch (e) {
      print('Error opening box $boxName: $e');
      // Try to delete and recreate the box if it's corrupted
      try {
        await Hive.deleteBoxFromDisk(boxName);
        return await Hive.openBox<T>(boxName);
      } catch (deleteError) {
        print('Error recreating box $boxName: $deleteError');
        rethrow;
      }
    }
  }
  
  static Future<void> _initializeDefaultData() async {
    try {
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
    } catch (e) {
      print('Error initializing default data: $e');
      rethrow;
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
  
  // Helper method to close all boxes (useful for cleanup)
  static Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}