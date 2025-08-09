import 'package:flutter/material.dart';

enum EntryType { dailyLog, milestone, counter }

class EntryTypeSelector extends StatelessWidget {
  final EntryType selectedType;
  final Function(EntryType) onTypeSelected;

  const EntryTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entry Type',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTypeChip(
                    context,
                    EntryType.dailyLog,
                    'Daily Log',
                    Icons.today,
                    'Mood, energy, sleep, water',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTypeChip(
                    context,
                    EntryType.milestone,
                    'Milestone',
                    Icons.flag,
                    'Important life events',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTypeChip(
                    context,
                    EntryType.counter,
                    'Counter',
                    Icons.add_circle,
                    'Create custom metric',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(
    BuildContext context,
    EntryType type,
    String title,
    IconData icon,
    String subtitle,
  ) {
    final isSelected = selectedType == type;
    
    return GestureDetector(
      onTap: () => onTypeSelected(type),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected 
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: isSelected 
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}