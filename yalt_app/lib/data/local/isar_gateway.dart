import 'package:isar/isar.dart';
import 'package:yalt_app/core/entities/metric_entity.dart';

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
    }

    await _isar.writeTxn(() async {
      await _isar.metricEntryIsars.put(isarEntry);
    });
  }

  Future<List<MetricEntryIsar>> getAllEntries() async {
    return await _isar.metricEntryIsars.where().findAll();
  }
}
