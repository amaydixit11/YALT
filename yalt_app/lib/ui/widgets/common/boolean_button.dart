import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';

class BooleanButton extends ConsumerWidget {
  final String label;
  final int metricId;

  const BooleanButton({
    super.key,
    required this.label,
    required this.metricId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => ref.read(booleanLoggerProvider)(metricId),
      child: Text(label),
    );
  }
}
