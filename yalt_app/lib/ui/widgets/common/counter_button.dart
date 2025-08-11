import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';

class CounterButton extends ConsumerWidget {
  final String label;
  final int metricId;

  const CounterButton({
    super.key,
    required this.label,
    required this.metricId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => ref.read(counterLoggerProvider)(metricId),
      child: Text(label),
    );
  }
}
