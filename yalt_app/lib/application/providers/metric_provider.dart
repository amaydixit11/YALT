import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/services/time_tracker_service.dart';
import 'package:yalt_app/core/entities/time_tracker_entity.dart';
import '../services/log_service.dart';

final logServiceProvider = Provider<LogService>((ref) {
  throw UnimplementedError(); // injected in main
});

final timeTrackerServiceProvider = Provider<TimeTrackerService>((ref) {
  throw UnimplementedError(); // injected in main
});

final booleanLoggedTodayProvider = FutureProvider.family<bool, int>((ref, metricId) async {
  final logService = ref.watch(logServiceProvider);
  // Replace this with your real method to check if the metric is logged today
  return await logService.isBooleanLoggedToday(metricId);
});

final booleanLoggerProvider = Provider((ref) {
  final logService = ref.watch(logServiceProvider);
  return (int metricId) {
    logService.logBoolean(metricId, true);
  };
});

final counterLoggerProvider = Provider((ref) {
  final logService = ref.watch(logServiceProvider);
  return (int metricId) {
    logService.logNumeric(metricId, 1);
  };
});

final incrementalLoggerProvider = Provider((ref) {
  final logService = ref.watch(logServiceProvider);
  return (int metricId, double value) {
    logService.logNumeric(metricId, value);
  };
});

final valueLoggerProvider = Provider((ref) {
  final logService = ref.watch(logServiceProvider);
  return (int metricId, String value) {
    logService.logText(metricId, value);
  };
});

// Time Tracker providers
final timeEntriesProvider = FutureProvider.family<List<TimeTrackerEntry>, DateTime>((ref, date) async {
  final timeTrackerService = ref.watch(timeTrackerServiceProvider);
  return await timeTrackerService.getTimeEntriesForDate(date);
});

final timeTrackerFormProvider = StateNotifierProvider<TimeTrackerFormNotifier, TimeTrackerFormState>((ref) {
  final timeTrackerService = ref.watch(timeTrackerServiceProvider);
  return TimeTrackerFormNotifier(timeTrackerService);
});

// Time Tracker Form State
class TimeTrackerFormState {
  final DateTime? startTime;
  final DateTime? endTime;
  final String activity;
  final String subActivity;
  final String groupInvolved;
  final String peopleInvolved;
  final int mood;
  final bool isLoading;
  final String? errorMessage;

  TimeTrackerFormState({
    this.startTime,
    this.endTime,
    this.activity = '',
    this.subActivity = '',
    this.groupInvolved = '',
    this.peopleInvolved = '',
    this.mood = 50,
    this.isLoading = false,
    this.errorMessage,
  });

  TimeTrackerFormState copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? activity,
    String? subActivity,
    String? groupInvolved,
    String? peopleInvolved,
    int? mood,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TimeTrackerFormState(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      activity: activity ?? this.activity,
      subActivity: subActivity ?? this.subActivity,
      groupInvolved: groupInvolved ?? this.groupInvolved,
      peopleInvolved: peopleInvolved ?? this.peopleInvolved,
      mood: mood ?? this.mood,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// Time Tracker Form Notifier
class TimeTrackerFormNotifier extends StateNotifier<TimeTrackerFormState> {
  final TimeTrackerService _timeTrackerService;

  TimeTrackerFormNotifier(this._timeTrackerService) : super(TimeTrackerFormState()) {
    _initializeWithLastEntry();
  }

  Future<void> _initializeWithLastEntry() async {
    try {
      final lastEntry = await _timeTrackerService.getLastTimeEntry();
      if (lastEntry != null) {
        // Set start time to the last entry's end time
        state = state.copyWith(startTime: lastEntry.endTime);
      }
    } catch (e) {
      // Ignore errors during initialization
    }
  }

  void setStartTime(DateTime time) {
    state = state.copyWith(startTime: time, errorMessage: null);
  }

  void setEndTime(DateTime time) {
    state = state.copyWith(endTime: time, errorMessage: null);
  }

  void setActivity(String activity) {
    state = state.copyWith(activity: activity, errorMessage: null);
  }

  void setSubActivity(String subActivity) {
    state = state.copyWith(subActivity: subActivity, errorMessage: null);
  }

  void setGroupInvolved(String groupInvolved) {
    state = state.copyWith(groupInvolved: groupInvolved, errorMessage: null);
  }

  void setPeopleInvolved(String peopleInvolved) {
    state = state.copyWith(peopleInvolved: peopleInvolved, errorMessage: null);
  }

  void setMood(int mood) {
    state = state.copyWith(mood: mood, errorMessage: null);
  }

  Future<bool> submitEntry() async {
    if (state.startTime == null || state.endTime == null || state.activity.trim().isEmpty) {
      state = state.copyWith(errorMessage: "Please fill in all required fields");
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _timeTrackerService.addTimeEntry(
        startTime: state.startTime!,
        endTime: state.endTime!,
        activity: state.activity.trim(),
        subActivity: state.subActivity.trim().isNotEmpty ? state.subActivity.trim() : null,
        groupInvolved: state.groupInvolved.trim().isNotEmpty ? state.groupInvolved.trim() : null,
        peopleInvolved: state.peopleInvolved.trim().isNotEmpty ? state.peopleInvolved.trim() : null,
        mood: state.mood,
      );

      // Reset form and set start time to the end time of the just-added entry
      state = TimeTrackerFormState(startTime: state.endTime);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}