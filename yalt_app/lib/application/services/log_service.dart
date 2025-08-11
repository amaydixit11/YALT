import 'package:flutter/material.dart';
import 'package:yalt_app/core/entities/metric_entity.dart';

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

  Future<void> printAllEntries() async {
    final entries = await _gateway.getAllEntries();
    for (var e in entries) {
      debugPrint(
        'Entry: id=${e.id}, metricId=${e.metricId}, timestamp=${e.timestamp}',
      );
    }
  }
}
