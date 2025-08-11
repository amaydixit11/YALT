import 'package:flutter/material.dart';
import 'package:yalt_app/core/entities/metric_entity.dart';
import 'package:yalt_app/data/local/isar_collections.dart';
import '../../data/local/isar_gateway.dart';

class LogService {
  final IsarGateway _gateway;
  LogService(this._gateway);

  Future<void> logNumeric(int metricId, double value) {
    final entry = NumericMetricEntry(metricId, value);
    return _gateway.saveEntry(entry);
  }

  Future<void> logBoolean(int metricId, bool value) {
    final entry = BooleanMetricEntry(metricId, value);
    return _gateway.saveEntry(entry);
  }

  Future<void> logText(int metricId, String value) {
    final entry = TextMetricEntry(metricId, value);
    return _gateway.saveEntry(entry);
  }

  Future<void> printAllEntries() async {
    final entries = await _gateway.getAllEntries();
    for (var e in entries) {
      debugPrint(
        'Entry: id=${e.id}, metricId=${e.metricId}, timestamp=${e.timestamp}, boolean=${e.booleanValue}, numeric=${e.numericValue}',
      );
    }
  }

  Future<List<MetricEntryIsar>> getAllEntries() async {
    return await _gateway.getAllEntries();
  }


  Future<bool> isBooleanLoggedToday(int metricId) async {
    final now = DateTime.now();

    // Calculate start of today (midnight)
    final startOfDay = DateTime(now.year, now.month, now.day);

    // Calculate start of next day (to make an exclusive range)
    final startOfNextDay = startOfDay.add(const Duration(days: 1));

    // Query Isar for boolean entries with the metricId and timestamp between startOfDay and startOfNextDay
    final entries = await _gateway.getBooleanEntriesInRange(
      metricId,
      startOfDay,
      startOfNextDay,
    );

    // Return true if at least one entry exists
    return entries.isNotEmpty;
  }
}
