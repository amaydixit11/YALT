import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';

class IncrementalButton extends ConsumerWidget {
  final String label;
  final int metricId;

  const IncrementalButton({
    super.key,
    required this.label,
    required this.metricId,
  });

  Future<double?> _showInputDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter value for $label'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Enter number'),
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
                // Optional: show error or keep dialog open
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
