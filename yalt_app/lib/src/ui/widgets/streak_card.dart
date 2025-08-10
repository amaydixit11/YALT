import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StreakCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int streak;
  final Color color;

  const StreakCard({
    super.key,
    required this.icon,
    required this.label,
    required this.streak,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_fire_department,
                  size: 16,
                  color: streak > 0 ? Colors.orange : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  streak.toString(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: streak > 0 ? color : Colors.grey,
                  ),
                ),
              ],
            ).animate(target: streak > 0 ? 1 : 0)
                .shimmer(duration: 1000.ms, color: color.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }
}