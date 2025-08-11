abstract class MetricEntry {
  final int metricId;
  final DateTime timestamp;

  MetricEntry(this.metricId) : timestamp = DateTime.now();
}

class NumericMetricEntry extends MetricEntry {
  final double value;
  NumericMetricEntry(int metricId, this.value) : super(metricId);
}

class BooleanMetricEntry extends MetricEntry {
  final bool value;
  BooleanMetricEntry(int metricId, this.value) : super(metricId);
}
