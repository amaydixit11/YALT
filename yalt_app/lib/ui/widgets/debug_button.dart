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
        await logService.printAllEntries();
      },
      child: const Text('Print DB Entries'),
    );
  }
}
