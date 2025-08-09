import 'dart:math';
import '../../models/daily_log.dart';
import '../../data/repository.dart';
import 'date_utils.dart' as date_utils;

class FunFactsGenerator {
  final Repository repository;
  
  FunFactsGenerator(this.repository);
  
  Future<String> generateRandomFact() async {
    final facts = await _getAllFacts();
    if (facts.isEmpty) return "Start logging to see fun facts!";
    
    final random = Random();
    return facts[random.nextInt(facts.length)];
  }
  
  Future<List<String>> _getAllFacts() async {
    final facts = <String>[];
    
    // Water facts
    final waterFact = await _generateWaterFact();
    if (waterFact != null) facts.add(waterFact);
    
    // Sleep facts
    final sleepFact = await _generateSleepFact();
    if (sleepFact != null) facts.add(sleepFact);
    
    // Mood facts
    final moodFact = await _generateMoodFact();
    if (moodFact != null) facts.add(moodFact);
    
    // Energy facts
    final energyFact = await _generateEnergyFact();
    if (energyFact != null) facts.add(energyFact);
    
    // General facts
    final generalFacts = await _generateGeneralFacts();
    facts.addAll(generalFacts);
    
    return facts;
  }
  
  Future<String?> _generateWaterFact() async {
    final logs = await repository.getAllDailyLogs();
    if (logs.isEmpty) return null;
    
    final yearStart = date_utils.DateUtils.getStartOfYear();
    final thisYearLogs = logs.where((log) => 
      log.date.isAfter(yearStart) || log.date.isAtSameMomentAs(yearStart)
    ).toList();
    
    if (thisYearLogs.isEmpty) return null;
    
    final totalWater = thisYearLogs.fold<int>(0, (sum, log) => sum + log.waterCups);
    final liters = (totalWater * 0.25).toStringAsFixed(1); // Assuming 250ml per cup
    
    return "You've drunk $liters liters of water this year! 💧";
  }
  
  Future<String?> _generateSleepFact() async {
    final logs = await repository.getAllDailyLogs();
    if (logs.isEmpty) return null;
    
    final sleepLogs = logs.where((log) => log.sleepHours > 0).toList();
    if (sleepLogs.isEmpty) return null;
    
    sleepLogs.sort((a, b) => b.sleepHours.compareTo(a.sleepHours));
    final longestSleep = sleepLogs.first;
    
    return "Your longest sleep was ${longestSleep.sleepHours.toStringAsFixed(1)} hours on ${date_utils.DateUtils.formatDateDisplay(longestSleep.date)} 😴";
  }
  
  Future<String?> _generateMoodFact() async {
    final logs = await repository.getAllDailyLogs();
    if (logs.isEmpty) return null;
    
    final moodLogs = logs.where((log) => log.mood > 0).toList();
    if (moodLogs.isEmpty) return null;
    
    final averageMood = moodLogs.fold<double>(0, (sum, log) => sum + log.mood) / moodLogs.length;
    final happyDays = moodLogs.where((log) => log.mood >= 4).length;
    final percentage = ((happyDays / moodLogs.length) * 100).toStringAsFixed(0);
    
    return "You've been happy $percentage% of the time! Average mood: ${averageMood.toStringAsFixed(1)}/5 😊";
  }
  
  Future<String?> _generateEnergyFact() async {
    final logs = await repository.getAllDailyLogs();
    if (logs.isEmpty) return null;
    
    final energyLogs = logs.where((log) => log.energy > 0).toList();
    if (energyLogs.isEmpty) return null;
    
    final averageEnergy = energyLogs.fold<double>(0, (sum, log) => sum + log.energy) / energyLogs.length;
    
    return "Your average energy level is ${averageEnergy.toStringAsFixed(1)}/5 ⚡";
  }
  
  Future<List<String>> _generateGeneralFacts() async {
    final facts = <String>[];
    final logs = await repository.getAllDailyLogs();
    
    if (logs.isNotEmpty) {
      facts.add("You've logged ${logs.length} days of life data! 📊");
      
      final daysWithNotes = logs.where((log) => log.note?.isNotEmpty == true).length;
      if (daysWithNotes > 0) {
        facts.add("You've written notes on $daysWithNotes days 📝");
      }
    }
    
    return facts;
  }
  
  Future<double> calculateCorrelation(String metric1, String metric2) async {
    final logs = await repository.getAllDailyLogs();
    final validLogs = logs.where((log) => 
      _getMetricValue(log, metric1) != null && 
      _getMetricValue(log, metric2) != null
    ).toList();
    
    if (validLogs.length < 2) return 0.0;
    
    final values1 = validLogs.map((log) => _getMetricValue(log, metric1)!).toList();
    final values2 = validLogs.map((log) => _getMetricValue(log, metric2)!).toList();
    
    return _pearsonCorrelation(values1, values2);
  }
  
  double? _getMetricValue(DailyLog log, String metric) {
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
        return null;
    }
  }
  
  double _pearsonCorrelation(List<double> x, List<double> y) {
    if (x.length != y.length || x.isEmpty) return 0.0;
    
    final n = x.length;
    final meanX = x.reduce((a, b) => a + b) / n;
    final meanY = y.reduce((a, b) => a + b) / n;
    
    double numerator = 0;
    double sumXSquared = 0;
    double sumYSquared = 0;
    
    for (int i = 0; i < n; i++) {
      final xDiff = x[i] - meanX;
      final yDiff = y[i] - meanY;
      
      numerator += xDiff * yDiff;
      sumXSquared += xDiff * xDiff;
      sumYSquared += yDiff * yDiff;
    }
    
    final denominator = sqrt(sumXSquared * sumYSquared);
    return denominator == 0 ? 0 : numerator / denominator;
  }
}