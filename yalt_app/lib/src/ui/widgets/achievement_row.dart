import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/achievement.dart';

class AchievementRow extends StatelessWidget {
  final List<Achievement> achievements;

  const AchievementRow({
    super.key,
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    final unlockedAchievements = achievements.where((a) => a.unlocked).toList();
    
    if (unlockedAchievements.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Achievements',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: unlockedAchievements.length,
            itemBuilder: (context, index) {
              final achievement = unlockedAchievements[index];
              
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getIconData(achievement.iconName),
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          achievement.title,
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate()
                  .fadeIn(delay: (index * 100).ms)
                  .slideX(begin: 0.3, end: 0);
            },
          ),
        ),
      ],
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'star':
        return Icons.star;
      case 'calendar':
        return Icons.calendar_today;
      case 'trophy':
        return Icons.emoji_events;
      case 'water_drop':
        return Icons.water_drop;
      case 'bed':
        return Icons.bed;
      case 'emoji_emotions':
        return Icons.emoji_emotions;
      default:
        return Icons.star;
    }
  }
}