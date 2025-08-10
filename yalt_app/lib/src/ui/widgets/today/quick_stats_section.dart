// lib/src/ui/widgets/today/quick_stats_section.dart
import 'package:flutter/material.dart';
import '../common/stat_card.dart';

class QuickStatsSection extends StatelessWidget {
  const QuickStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: const Row(
        children: [
          Expanded(child: StatCard(value: '8/12', label: 'Tasks Done', icon: Icons.task_alt_rounded, color: Colors.green)),
          SizedBox(width: 12),
          Expanded(child: StatCard(value: '67%', label: 'Daily Goal', icon: Icons.trending_up_rounded, color: Colors.blue)),
          SizedBox(width: 12),
          Expanded(child: StatCard(value: '5', label: 'Streak', icon: Icons.local_fire_department_rounded, color: Colors.orange)),
        ],
      ),
    );
  }
}
