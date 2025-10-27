import 'package:isar/isar.dart';
import 'package:yalt_app/core/entities/metric_entity.dart';
import 'package:yalt_app/core/entities/time_tracker_entity.dart';

import 'isar_collections.dart';

class IsarGateway {
  final Isar _isar;

  IsarGateway(this._isar);

  Future<void> saveEntry(MetricEntry entry) async {
    final isarEntry = MetricEntryIsar()
      ..metricId = entry.metricId
      ..timestamp = entry.timestamp;

    if (entry is NumericMetricEntry) {
      isarEntry.numericValue = entry.value;
    } else if (entry is BooleanMetricEntry) {
      isarEntry.booleanValue = entry.value;
    } else if (entry is TextMetricEntry) {
      isarEntry.textValue = entry.value;
    }

    await _isar.writeTxn(() async {
      await _isar.metricEntryIsars.put(isarEntry);
    });
  }

  Future<List<MetricEntryIsar>> getAllEntries() async {
    return await _isar.metricEntryIsars.where().findAll();
  }

  Future<List<MetricEntryIsar>> getBooleanEntriesInRange(
    int metricId,
    DateTime start,
    DateTime end,
  ) {
    return _isar.metricEntryIsars
        .filter()
        .metricIdEqualTo(metricId)
        .booleanValueEqualTo(true)
        .timestampBetween(start, end, includeLower: true, includeUpper: false)
        .findAll();
  }

    // Time Tracker methods
  Future<void> saveTimeTrackerEntry(TimeTrackerEntry entry) async {
    final isarEntry = TimeTrackerEntryIsar.fromEntity(entry);
    await _isar.writeTxn(() async {
      await _isar.timeTrackerEntryIsars.put(isarEntry);
    });
  }

  Future<List<TimeTrackerEntry>> getTimeEntriesForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final isarEntries = await _isar.timeTrackerEntryIsars
        .filter()
        .startTimeBetween(startOfDay, endOfDay)
        .sortByStartTime()
        .findAll();

    return isarEntries.map((e) => e.toEntity()).toList();
  }

  Future<List<TimeTrackerEntry>> getAllTimeEntries() async {
    final isarEntries = await _isar.timeTrackerEntryIsars
        .where()
        .sortByStartTime()
        .findAll();

    return isarEntries.map((e) => e.toEntity()).toList();
  }

  Future<TimeTrackerEntry?> getLastTimeEntry() async {
    final isarEntry = await _isar.timeTrackerEntryIsars
        .where()
        .sortByStartTimeDesc()
        .findFirst();

    return isarEntry?.toEntity();
  }

  Future<bool> hasOverlappingTimeEntry(DateTime startTime, DateTime endTime, {int? excludeId}) async {
    var query = _isar.timeTrackerEntryIsars
        .filter()
        .startTimeLessThan(endTime)
        .and()
        .endTimeGreaterThan(startTime);

    if (excludeId != null) {
      query = query.and().not().idEqualTo(excludeId);
    }

    final overlapping = await query.findFirst();
    return overlapping != null;
  }
}
