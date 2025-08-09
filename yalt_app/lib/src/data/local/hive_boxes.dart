import 'package:hive/hive.dart';
import '../../models/daily_log.dart';
import '../../models/custom_counter.dart';
import '../../models/counter_event.dart';
import '../../models/milestone.dart';
import '../../models/achievement.dart';
import '../../models/settings.dart';
import '../../core/constants/app_constants.dart';

class HiveBoxes {
  // Typed boxes with null safety and error handling
  static Box<DailyLog>? _dailyLogsBox;
  static Box<CustomCounter>? _countersBox;
  static Box<CounterEvent>? _counterEventsBox;
  static Box<Milestone>? _milestonesBox;
  static Box<Achievement>? _achievementsBox;
  static Box<Settings>? _settingsBox;
  static Box? _simpleStorageBox;

  // Getters with safe access
  static Box<DailyLog> get dailyLogs {
    _dailyLogsBox ??= Hive.box<DailyLog>(AppConstants.dailyLogsBox);
    return _dailyLogsBox!;
  }

  static Box<CustomCounter> get counters {
    _countersBox ??= Hive.box<CustomCounter>(AppConstants.countersBox);
    return _countersBox!;
  }

  static Box<CounterEvent> get counterEvents {
    _counterEventsBox ??= Hive.box<CounterEvent>(AppConstants.counterEventsBox);
    return _counterEventsBox!;
  }

  static Box<Milestone> get milestones {
    _milestonesBox ??= Hive.box<Milestone>(AppConstants.milestonesBox);
    return _milestonesBox!;
  }

  static Box<Achievement> get achievements {
    _achievementsBox ??= Hive.box<Achievement>(AppConstants.achievementsBox);
    return _achievementsBox!;
  }

  static Box<Settings> get settings {
    _settingsBox ??= Hive.box<Settings>(AppConstants.settingsBox);
    return _settingsBox!;
  }

  static Box get simpleStorage {
    _simpleStorageBox ??= Hive.box('simple_storage');
    return _simpleStorageBox!;
  }

  // Helper method to check if all boxes are open
  static bool get areAllBoxesOpen {
    try {
      return Hive.isBoxOpen(AppConstants.dailyLogsBox) &&
             Hive.isBoxOpen(AppConstants.countersBox) &&
             Hive.isBoxOpen(AppConstants.counterEventsBox) &&
             Hive.isBoxOpen(AppConstants.milestonesBox) &&
             Hive.isBoxOpen(AppConstants.achievementsBox) &&
             Hive.isBoxOpen(AppConstants.settingsBox) &&
             Hive.isBoxOpen('simple_storage');
    } catch (e) {
      return false;
    }
  }

  // Helper method to safely get a box
  static Box<T>? tryGetBox<T>(String boxName) {
    try {
      if (Hive.isBoxOpen(boxName)) {
        return Hive.box<T>(boxName);
      }
    } catch (e) {
      print('Error accessing box $boxName: $e');
    }
    return null;
  }

  // Clear cached references (useful for testing)
  static void clearCache() {
    _dailyLogsBox = null;
    _countersBox = null;
    _counterEventsBox = null;
    _milestonesBox = null;
    _achievementsBox = null;
    _settingsBox = null;
    _simpleStorageBox = null;
  }
}