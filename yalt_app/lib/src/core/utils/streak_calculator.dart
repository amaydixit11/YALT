import '../../models/daily_log.dart';
import '../../data/repository.dart';
import 'date_utils.dart' as date_utils;

class StreakCalculator {
  final Repository repository;
  
  StreakCalculator(this.repository);
  
  Future<int> computeCurrentStreak(String metric, [DateTime? today]) async {
    final targetDate = today ?? DateTime.now();
    int streak = 0;
    DateTime currentDate = date_utils.DateUtils.normalizeToLocalDate(targetDate);
    
    while (true) {
      final entry = await repository.getDailyLogByDate(currentDate);
      if (entry != null && _meetsThreshold(entry, metric)) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    
    return streak;
  }
  
  Future<StreakInfo> computeLongestStreak(String metric) async {
    final allLogs = await repository.getAllDailyLogs();
    if (allLogs.isEmpty) return StreakInfo(0, null, null);
    
    // Sort by date
    allLogs.sort((a, b) => a.date.compareTo(b.date));
    
    int longestStreak = 0;
    int currentStreak = 0;
    DateTime? longestStart;
    DateTime? longestEnd;
    DateTime? currentStart;
    
    for (int i = 0; i < allLogs.length; i++) {
      final log = allLogs[i];
      
      if (_meetsThreshold(log, metric)) {
        if (currentStreak == 0) {
          currentStart = log.date;
        }
        currentStreak++;
        
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
          longestStart = currentStart;
          longestEnd = log.date;
        }
      } else {
        currentStreak = 0;
        currentStart = null;
      }
    }
    
    return StreakInfo(longestStreak, longestStart, longestEnd);
  }
  
  bool _meetsThreshold(DailyLog log, String metric) {
    switch (metric) {
      case 'mood':
        return log.mood >= 4; // Happy or very happy
      case 'energy':
        return log.energy >= 4; // Energetic or very energetic
      case 'sleep':
        return log.sleepHours >= 7.0; // At least 7 hours
      case 'water':
        return log.waterCups >= 8; // At least 8 cups
      default:
        return false;
    }
  }
}

class StreakInfo {
  final int length;
  final DateTime? startDate;
  final DateTime? endDate;
  
  StreakInfo(this.length, this.startDate, this.endDate);
}