import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'LifeStats';
  static const String appVersion = '1.0.0';
  
  // Hive Box Names
  static const String dailyLogsBox = 'box_daily_logs';
  static const String countersBox = 'box_counters';
  static const String counterEventsBox = 'box_counter_events';
  static const String milestonesBox = 'box_milestones';
  static const String achievementsBox = 'box_achievements';
  static const String settingsBox = 'box_settings';
  static const String simpleStorageBox = 'simple_storage'; // Add this
  
  // Hive Type IDs
  static const int dailyLogTypeId = 0;
  static const int customCounterTypeId = 1;
  static const int counterEventTypeId = 2;
  static const int milestoneTypeId = 3;
  static const int achievementTypeId = 4;
  static const int settingsTypeId = 5;
  
  // Settings Keys
  static const String settingsKey = 'app_settings';
  static const String firstRunKey = 'first_run';
  
  // Mood Emojis
  static const List<String> moodEmojis = ['😢', '😕', '😐', '😊', '😄'];
  static const List<String> moodLabels = [
    'Very Sad',
    'Sad',
    'Neutral',
    'Happy',
    'Very Happy'
  ];
  
  // Energy Labels
  static const List<String> energyLabels = [
    'Exhausted',
    'Tired',
    'Okay',
    'Energetic',
    'Very Energetic'
  ];
  
  // Default counter colors
  static const List<Color> counterColors = [
    Color(0xFF0891B2), // Cyan
    Color(0xFF8B5CF6), // Violet
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFFEF4444), // Red
    Color(0xFF6366F1), // Indigo
    Color(0xFFEC4899), // Pink
    Color(0xFF84CC16), // Lime
  ];
}