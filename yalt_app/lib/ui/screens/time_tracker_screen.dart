import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';
import 'package:yalt_app/ui/widgets/time_tracker/time_entry_form.dart';
import 'package:yalt_app/ui/widgets/time_tracker/time_entries_list.dart';

class TimeTrackerScreen extends ConsumerWidget {
  const TimeTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // Expanded(
          //   child: TimeEntriesList(
          //     date: today,
          //   ),
          // ),
          TimeEntryForm(
            onEntryAdded: () {
              ref.invalidate(timeEntriesProvider(today));
            },
          ),
        ],
      ),
    );
  }
}
