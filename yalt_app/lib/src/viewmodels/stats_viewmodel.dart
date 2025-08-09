import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/daily_log.dart';
import '../data/repository.dart';
import '../core/utils/date_utils.dart' as date_utils;
import '../core/utils/fun_facts_generator.dart';

final statsViewModelProvider = AsyncNotifierProvider<StatsViewModel, StatsState>(
  () => StatsViewModel(),
);

class StatsViewModel extends AsyncNotifier<StatsState> {
  late Repository _repository;
  late FunFactsGenerator _funFactsGenerator;
  
  @override
  Future<StatsState> build() async {
    _repository = ref.read(repositoryProvider);
    _funFactsGenerator = FunFactsGenerator(_repository);
    
    return _loadStatsData('mood', 30);
  }
  
  Future<StatsState> _loadStatsData(String metric, int days) async {
    final allLogs = await _repository.getAllDailyLogs();
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    
    final filteredLogs = allLogs
        .where((log) => log.date.isAfter(cutoffDate) || log.date.isAtSameMomentAs(cutoffDate))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    
    final chartData = filteredLogs.map((log) => ChartDataPoint(
      date: log.date,
      value: _getMetricValue(log, metric),
    )).toList();
    
    final values = chartData.map((point) => point.value).where((v) => v > 0).toList();
    
    final average = values.isEmpty ? 0.0 : values.reduce((a, b) => a + b) / values.length;
    final bestValue = values.isEmpty ? 0.0 : values.reduce((a, b) => a > b ? a : b);
    
    return StatsState(
      metric: metric,
      days: days,
      chartData: chartData,
      average: average,
      bestValue: bestValue,
      totalDays: days,
      loggedDays: values.length,
    );
  }
  
  double _getMetricValue(DailyLog log, String metric) {
    switch (metric) {
      case 'mood':
        return log.mood.toDouble();
      case 'energy':
        return log.energy.toDouble();
      case 'sleep':
        return log.sleepHours;
      case 'water':
        return log.waterCups.toDouble();
      default:
        return 0.0;
    }
  }
  
  Future<void> updateMetric(String metric, int days) async {
    state = const AsyncValue.loading();
    try {
      final newState = await _loadStatsData(metric, days);
      state = AsyncValue.data(newState);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  Future<void> exportCSV(String metric) async {
    try {
      final allLogs = await _repository.getAllDailyLogs();
      final csvData = <List<String>>[];
      
      // Header
      csvData.add(['Date', metric.toUpperCase(), 'Note']);
      
      // Data rows
      for (final log in allLogs) {
        csvData.add([
          date_utils.DateUtils.formatDate(log.date),
          _getMetricValue(log, metric).toString(),
          log.note ?? '',
        ]);
      }
      
      final csvString = const ListToCsvConverter().convert(csvData);
      
      // Save to temporary file
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/lifestats_${metric}_export.csv');
      await file.writeAsString(csvString);
      
      // Share the file
      await Share.shareXFiles([XFile(file.path)], text: 'LifeStats $metric data export');
      
    } catch (error) {
      // Handle error
      print('Export error: $error');
    }
  }
  
  Future<void> generateFunFact() async {
    try {
      final fact = await _funFactsGenerator.generateRandomFact();
      // You could show this in a dialog or snackbar
      // For now, we'll just print it
      print('Fun fact: $fact');
    } catch (error) {
      print('Fun fact error: $error');
    }
  }
}

class StatsState {
  final String metric;
  final int days;
  final List<ChartDataPoint> chartData;
  final double average;
  final double bestValue;
  final int totalDays;
  final int loggedDays;
  
  StatsState({
    required this.metric,
    required this.days,
    required this.chartData,
    required this.average,
    required this.bestValue,
    required this.totalDays,
    required this.loggedDays,
  });
}

class ChartDataPoint {
  final DateTime date;
  final double value;
  
  ChartDataPoint({
    required this.date,
    required this.value,
  });
}