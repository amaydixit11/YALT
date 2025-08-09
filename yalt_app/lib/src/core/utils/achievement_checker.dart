import '../../data/repository.dart';
import 'streak_calculator.dart';

class AchievementChecker {
  final Repository repository;
  late StreakCalculator _streakCalculator;
  
  AchievementChecker(this.repository) {
    _streakCalculator = StreakCalculator(repository);
  }
  
  Future<List<String>> checkAndUnlockAchievements() async {
    final unlockedIds = <String>[];
    
    // Check first log achievement
    final logs = await repository.getAllDailyLogs();
    if (logs.isNotEmpty) {
      final unlocked = await _unlockIfNotUnlocked('first_log');
      if (unlocked) unlockedIds.add('first_log');
    }
    
    // Check streak achievements
    final moodStreak = await _streakCalculator.computeCurrentStreak('mood');
    if (moodStreak >= 7) {
      final unlocked = await _unlockIfNotUnlocked('week_streak');
      if (unlocked) unlockedIds.add('week_streak');
    }
    if (moodStreak >= 30) {
      final unlocked = await _unlockIfNotUnlocked('month_streak');
      if (unlocked) unlockedIds.add('month_streak');
    }
    
    // Check today's achievements
    final todayLog = await repository.getTodayLog();
    if (todayLog != null) {
      if (todayLog.waterCups >= 8) {
        final unlocked = await _unlockIfNotUnlocked('hydration_hero');
        if (unlocked) unlockedIds.add('hydration_hero');
      }
      
      if (todayLog.sleepHours >= 8.0) {
        final unlocked = await _unlockIfNotUnlocked('sleep_champion');
        if (unlocked) unlockedIds.add('sleep_champion');
      }
    }
    
    // Check mood master (7 consecutive happy days)
    final happyStreak = await _streakCalculator.computeCurrentStreak('mood');
    if (happyStreak >= 7) {
      final unlocked = await _unlockIfNotUnlocked('mood_master');
      if (unlocked) unlockedIds.add('mood_master');
    }
    
    return unlockedIds;
  }
  
  Future<bool> _unlockIfNotUnlocked(String achievementId) async {
    final achievements = await repository.getAllAchievements();
    final achievement = achievements.where((a) => a.id == achievementId).firstOrNull;
    
    if (achievement != null && !achievement.unlocked) {
      await repository.unlockAchievement(achievementId);
      return true;
    }
    
    return false;
  }
}