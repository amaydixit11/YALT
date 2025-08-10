// lib/src/ui/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/common/main_layout.dart';
import 'stats_screen.dart';
import 'today_screen.dart';
import 'add_entry_screen.dart';
// import 'lifetime_screen.dart';
import 'history_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MainLayoutWidget(
      initialIndex: 1, // Start with Today screen
      pageTitles: const [
        'Stats Overview',
        'Today',
        'Add Entry',
        'Lifetime Stats',
        'History',
      ],
      pages: const [
        StatsScreen(),
        TodayScreen(),
        AddEntryScreen(),
        // LifetimeScreen(),
        HistoryScreen(),
      ],
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            // Navigate to settings
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // Handle notifications
          },
        ),
      ],
    );
  }
}