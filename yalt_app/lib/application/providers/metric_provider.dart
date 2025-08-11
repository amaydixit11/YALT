import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/core/constants/metricIds.dart';
import '../services/log_service.dart';

final logServiceProvider = Provider<LogService>((ref) {
  throw UnimplementedError(); // injected in main
});


final booleanLoggerProvider = Provider((ref) {
  final logService = ref.watch(logServiceProvider);
  // Return a function that accepts a metricId and logs it
  return (int metricId) => logService.logBoolean(metricId, true);
});
