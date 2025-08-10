// lib/src/ui/screens/today_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/today/welcome_card.dart';
import '../widgets/today/quick_stats_section.dart';
import '../widgets/today/meals_section.dart';
import '../widgets/today/water_drinks_row.dart';
import '../widgets/today/hygiene_section.dart';
import '../widgets/today/daily_activities_section.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary.withOpacity(0.05),
            theme.colorScheme.surface,
          ],
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8),
            WelcomeCard(),
            SizedBox(height: 20),
            QuickStatsSection(),
            SizedBox(height: 24),
            MealsSection(),
            SizedBox(height: 20),
            WaterDrinksRow(),
            SizedBox(height: 20),
            HygieneSection(),
            SizedBox(height: 20),
            DailyActivitiesSection(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}