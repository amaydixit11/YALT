import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/log_service.dart';

final logServiceProvider = Provider<LogService>((ref) {
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