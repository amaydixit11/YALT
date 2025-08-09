import 'package:hive/hive.dart';
import '../../models/daily_log.dart';
import '../../models/custom_counter.dart';
import '../../models/counter_event.dart';
import '../../models/milestone.dart';
import '../../models/achievement.dart';
import '../../models/settings.dart';
import '../../core/constants/app_constants.dart';

class HiveBoxes {
  static Box<DailyLog> get dailyLogs => Hive.box<DailyLog>(AppConstants.dailyLogsBox);
  static Box<CustomCounter> get counters => Hive.box<CustomCounter>(AppConstants.countersBox);
  static Box<CounterEvent> get counterEvents => Hive.box<CounterEvent>(AppConstants.counterEventsBox);
  static Box<Milestone> get milestones => Hive.box<Milestone>(AppConstants.milestonesBox);
  static Box<Achievement> get achievements => Hive.box<Achievement>(AppConstants.achievementsBox);
  static Box<Settings> get settings => Hive.box<Settings>(AppConstants.settingsBox);
}