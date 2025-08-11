import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';

class IncrementalButton extends ConsumerWidget {
  final String label;
  final int metricId;
  final List<double>? predefinedValues;

  const IncrementalButton({
    super.key,
    required this.label,
    required this.metricId,
    this.predefinedValues,
  });

  Future<double?> _showInputDialog(BuildContext context) async {
    final controller = TextEditingController();

    return showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter value for $label'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (predefinedValues != null && predefinedValues!.isNotEmpty)
              Wrap(
                spacing: 8,
                children: predefinedValues!.map((val) {
                  return ActionChip(
                    label: Text('+${val.toStringAsFixed(val.truncateToDouble() == val ? 0 : 2)}'),
                    onPressed: () {
                      Navigator.of(context).pop(val);
                    },
                  );
                }).toList(),
              ),
            if (predefinedValues != null && predefinedValues!.isNotEmpty)
              const Divider(height: 24),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(hintText: 'Enter custom number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final input = controller.text.trim();
              final value = double.tryParse(input);
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                // Optionally show error or do nothing
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final value = await _showInputDialog(context);
        if (value != null) {
          ref.read(incrementalLoggerProvider)(metricId, value);
        }
      },
      child: Text(label),
    );
  }
}
