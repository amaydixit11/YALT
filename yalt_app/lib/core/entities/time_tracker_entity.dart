class TimeTrackerEntry {
  final DateTime timestamp;
  final DateTime startTime;
  final DateTime endTime;
  final String activity;
  final String? subActivity;
  final String? groupInvolved;
  final String? peopleInvolved;
  final int? mood;

  TimeTrackerEntry({
    required this.timestamp,
    required this.startTime,
    required this.endTime,
    required this.activity,
    this.subActivity,
    this.groupInvolved,
    this.peopleInvolved,
    this.mood,
  });

  TimeTrackerEntry copyWith({
    DateTime? timestamp,
    DateTime? startTime,
    DateTime? endTime,
    String? activity,
    String? subActivity,
    String? groupInvolved,
    String? peopleInvolved,
    int? mood,
  }) {
    return TimeTrackerEntry(
      timestamp: timestamp ?? this.timestamp,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      activity: activity ?? this.activity,
      subActivity: subActivity ?? this.subActivity,
      groupInvolved: groupInvolved ?? this.groupInvolved,
      peopleInvolved: peopleInvolved ?? this.peopleInvolved,
      mood: mood ?? this.mood,
    );
  }
}