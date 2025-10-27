import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';
import 'package:yalt_app/ui/widgets/common/time_entry_card.dart';
import 'package:yalt_app/ui/widgets/time_tracker/empty_entries_state.dart';
import 'package:yalt_app/ui/widgets/time_tracker/entries_error_state.dart';

class TimeEntriesList extends ConsumerWidget {
  final DateTime date;

  const TimeEntriesList({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeEntries = ref.watch(timeEntriesProvider(date));

    return Container(
      color: Colors.grey.shade50,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Today's Entries",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          timeEntries.when(
            data: (entries) {
              if (entries.isEmpty) {
                return const EmptyEntriesState();
              }

              return Column(
                children: entries.map((entry) {
                  return TimeEntryCard(
                    entry: entry,
                    onTap: () {
                      // TODO: Implement edit functionality
                    },
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => EntriesErrorState(error: error),
          ),
        ],
      ),
    );
  }
}
