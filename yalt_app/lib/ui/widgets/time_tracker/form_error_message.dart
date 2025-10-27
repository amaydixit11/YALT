import 'package:flutter/material.dart';

class FormErrorMessage extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onDismiss;

  const FormErrorMessage({
    super.key,
    this.errorMessage,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: Colors.red.shade700, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              errorMessage!,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 14,
              ),
            ),
          ),
          if (onDismiss != null)
            IconButton(
              icon: Icon(Icons.close, color: Colors.red.shade700, size: 16),
              onPressed: onDismiss,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }
}