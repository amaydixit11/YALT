import 'package:flutter/material.dart';

class EmptyEntriesState extends StatelessWidget {
  const EmptyEntriesState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.schedule,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "No entries yet today",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Add your first time entry above",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}