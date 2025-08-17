import 'package:flutter/material.dart';
import 'package:yalt_app/core/entities/time_tracker_entity.dart';
import 'package:yalt_app/data/local/isar_gateway.dart';

class TimeTrackerService {
  final IsarGateway _gateway;
  
  TimeTrackerService(this._gateway);

  Future<void> addTimeEntry({
    required DateTime startTime,
    required DateTime endTime,
    required String activity,
    String? subActivity,
    String? groupInvolved,
    String? peopleInvolved,
    int? mood,
  }) async {
    // Validate time entry
    final validation = await validateTimeEntry(startTime, endTime);
    if (!validation.isValid) {
      throw Exception(validation.errorMessage);
    }

    final entry = TimeTrackerEntry(
      timestamp: DateTime.now(),
      startTime: startTime,
      endTime: endTime,
      activity: activity,
      subActivity: subActivity,
      groupInvolved: groupInvolved,
      peopleInvolved: peopleInvolved,
      mood: mood,
    );

    await _gateway.saveTimeTrackerEntry(entry);
    
    // Fill gaps after adding the entry
    await fillGaps(startTime.copyWith(
      year: startTime.year,
      month: startTime.month,
      day: startTime.day,
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    ));
  }

  Future<List<TimeTrackerEntry>> getTimeEntriesForDate(DateTime date) async {
    return await _gateway.getTimeEntriesForDate(date);
  }

  Future<ValidationResult> validateTimeEntry(DateTime startTime, DateTime endTime, {int? excludeId}) async {
    // Check if end time is after start time
    if (endTime.isBefore(startTime) || endTime.isAtSameMomentAs(startTime)) {
      return ValidationResult(false, "End time must be after start time");
    }

    // Check for overlapping entries
    final hasOverlap = await _gateway.hasOverlappingTimeEntry(startTime, endTime, excludeId: excludeId);
    if (hasOverlap) {
      return ValidationResult(false, "Time entry overlaps with existing entry");
    }

    return ValidationResult(true, null);
  }

  Future<void> fillGaps(DateTime date) async {
    final entries = await getTimeEntriesForDate(date);
    if (entries.isEmpty) return;

    final gaps = <TimeTrackerEntry>[];
    final sortedEntries = List<TimeTrackerEntry>.from(entries)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    for (int i = 0; i < sortedEntries.length - 1; i++) {
      final currentEnd = sortedEntries[i].endTime;
      final nextStart = sortedEntries[i + 1].startTime;

      if (nextStart.isAfter(currentEnd)) {
        // There's a gap, create a blank entry
        final gap = TimeTrackerEntry(
          timestamp: DateTime.now(),
          startTime: currentEnd,
          endTime: nextStart,
          activity: "blank",
          subActivity: null,
          groupInvolved: null,
          peopleInvolved: null,
          mood: null,
        );
        gaps.add(gap);
      }
    }

    // Save all gap entries
    for (final gap in gaps) {
      await _gateway.saveTimeTrackerEntry(gap);
    }
  }

  Future<TimeTrackerEntry?> getLastTimeEntry() async {
    return await _gateway.getLastTimeEntry();
  }

  String formatTimeOfDay(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String formatDuration(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  ValidationResult(this.isValid, this.errorMessage);
}