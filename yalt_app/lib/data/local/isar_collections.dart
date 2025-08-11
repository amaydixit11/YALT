import 'package:isar/isar.dart';

part 'isar_collections.g.dart';

@collection
class MetricEntryIsar {
  Id id = Isar.autoIncrement;
  late int metricId;
  late DateTime timestamp;
  double? numericValue;
  bool? booleanValue;
}
