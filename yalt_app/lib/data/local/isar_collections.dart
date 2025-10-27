import 'package:isar/isar.dart';
import 'package:yalt_app/core/entities/time_tracker_entity.dart';

part 'isar_collections.g.dart';

@collection
class MetricEntryIsar {
  Id id = Isar.autoIncrement;
  late int metricId;
  late DateTime timestamp;
  double? numericValue;
  bool? booleanValue;
  String? textValue;
}

@collection
class TimeTrackerEntryIsar {
  Id id = Isar.autoIncrement;
  late DateTime timestamp;
  late DateTime startTime;
  late DateTime endTime;
  late String activity;
  String? subActivity;
  String? groupInvolved;
  String? peopleInvolved;
  int? mood;

  TimeTrackerEntryIsar();

  TimeTrackerEntryIsar.fromEntity(TimeTrackerEntry entry) {
    timestamp = entry.timestamp;
    startTime = entry.startTime;
    endTime = entry.endTime;
    activity = entry.activity;
    subActivity = entry.subActivity;
    groupInvolved = entry.groupInvolved;
    peopleInvolved = entry.peopleInvolved;
    mood = entry.mood;
  }

  TimeTrackerEntry toEntity() {
    return TimeTrackerEntry(
      timestamp: timestamp,
      startTime: startTime,
      endTime: endTime,
      activity: activity,
      subActivity: subActivity,
      groupInvolved: groupInvolved,
      peopleInvolved: peopleInvolved,
      mood: mood,
    );
  }
}