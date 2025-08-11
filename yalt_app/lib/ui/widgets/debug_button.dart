import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';

class DebugButton extends ConsumerWidget {
  const DebugButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logService = ref.watch(logServiceProvider);

    return ElevatedButton(
      onPressed: () async {
        final entries = await logService.getAllEntries();

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Database Entries'),
            content: SizedBox(
              width: double.maxFinite,
              child: entries.isEmpty
                  ? const Text('No entries found.')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        final e = entries[index];
                        final time = e.timestamp?.toLocal().toString() ?? 'Unknown time';

                        return ListTile(
                          title: Text('Metric ID: ${e.metricId}'),
                          subtitle: Text(
                            'Timestamp: $time\n'
                            'Boolean: ${e.booleanValue}\n'
                            'Numeric: ${e.numericValue}',
                          ),
                        );
                      },
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: const Text('Show DB Entries'),
    );
  }
}
