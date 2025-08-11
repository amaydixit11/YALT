import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';

class ValueButton extends ConsumerWidget {
  final String label;
  final int metricId;

  const ValueButton({
    super.key,
    required this.label,
    required this.metricId,
  });

  Future<String?> _showInputDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter value for $label'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter text'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final input = controller.text.trim();
              if (input.isNotEmpty) {
                Navigator.of(context).pop(input);
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
          ref.read(valueLoggerProvider)(metricId, value);
        }
      },
      child: Text(label),
    );
  }
}
