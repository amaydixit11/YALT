// lib/src/ui/widgets/today/daily_activities_section.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/section_wrapper.dart';

class DailyActivitiesSection extends StatefulWidget {
  const DailyActivitiesSection({super.key});

  @override
  State<DailyActivitiesSection> createState() => _DailyActivitiesSectionState();
}

class _DailyActivitiesSectionState extends State<DailyActivitiesSection> {
  // State for each tracker
  int hoursSlept = 0;
  int stepsWalked = 0;
  int phoneTimeMinutes = 0;
  int computerTimeMinutes = 0;
  int junkFoodCount = 0;
  int problemsSolved = 0;
  int studyHours = 0;

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      title: 'Daily Reset Trackers',
      subtitle: 'Track your daily habits & activities',
      icon: Icons.track_changes_rounded,
      iconColor: Colors.purple,
      child: DailyActivitiesPanel(
        hoursSlept: hoursSlept,
        stepsWalked: stepsWalked,
        phoneTimeMinutes: phoneTimeMinutes,
        computerTimeMinutes: computerTimeMinutes,
        junkFoodCount: junkFoodCount,
        problemsSolved: problemsSolved,
        studyHours: studyHours,
        onUpdateValue: _updateValue,
      ),
    );
  }

  void _updateValue(String key, int value) {
    setState(() {
      switch (key) {
        case 'sleep':
          hoursSlept = value;
          break;
        case 'steps':
          stepsWalked = value;
          break;
        case 'phone':
          phoneTimeMinutes = value;
          break;
        case 'computer':
          computerTimeMinutes = value;
          break;
        case 'junkFood':
          junkFoodCount = value;
          break;
        case 'problems':
          problemsSolved = value;
          break;
        case 'study':
          studyHours = value;
          break;
      }
    });
  }
}

class DailyActivitiesPanel extends StatelessWidget {
  final int hoursSlept;
  final int stepsWalked;
  final int phoneTimeMinutes;
  final int computerTimeMinutes;
  final int junkFoodCount;
  final int problemsSolved;
  final int studyHours;
  final Function(String, int) onUpdateValue;

  const DailyActivitiesPanel({
    super.key,
    required this.hoursSlept,
    required this.stepsWalked,
    required this.phoneTimeMinutes,
    required this.computerTimeMinutes,
    required this.junkFoodCount,
    required this.problemsSolved,
    required this.studyHours,
    required this.onUpdateValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Row 1
          Row(
            children: [
              Expanded(
                child: CompactTracker(
                  label: 'Sleep',
                  emoji: '🛏️',
                  value: hoursSlept,
                  unit: 'hrs',
                  color: Colors.indigo,
                  onChanged: (value) => onUpdateValue('sleep', value),
                  target: 8,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: CompactTracker(
                  label: 'Steps',
                  emoji: '🚶‍♂️',
                  value: stepsWalked,
                  unit: '',
                  color: Colors.green,
                  onChanged: (value) => onUpdateValue('steps', value),
                  target: 10000,
                  isLargeNumber: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Row 2
          Row(
            children: [
              Expanded(
                child: CompactTracker(
                  label: 'Phone Time',
                  emoji: '📱',
                  value: phoneTimeMinutes,
                  unit: 'min',
                  color: Colors.orange,
                  onChanged: (value) => onUpdateValue('phone', value),
                  target: 120,
                  isReverse: true, // Less is better
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: CompactTracker(
                  label: 'Computer',
                  emoji: '💻',
                  value: computerTimeMinutes,
                  unit: 'min',
                  color: Colors.blue,
                  onChanged: (value) => onUpdateValue('computer', value),
                  target: 480,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Row 3
          Row(
            children: [
              Expanded(
                child: CompactTracker(
                  label: 'Junk Food',
                  emoji: '🍟',
                  value: junkFoodCount,
                  unit: '',
                  color: Colors.red,
                  onChanged: (value) => onUpdateValue('junkFood', value),
                  target: 0,
                  isReverse: true,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: CompactTracker(
                  label: 'Problems',
                  emoji: '🧮',
                  value: problemsSolved,
                  unit: '',
                  color: Colors.purple,
                  onChanged: (value) => onUpdateValue('problems', value),
                  target: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Row 4 - Study hours (same size as others now)
          Row(
            children: [
              Expanded(
                child: CompactTracker(
                  label: 'Study Hours',
                  emoji: '📚',
                  value: studyHours,
                  unit: 'hrs',
                  color: Colors.teal,
                  onChanged: (value) => onUpdateValue('study', value),
                  target: 6,
                ),
              ),
              const Expanded(child: SizedBox()), // Empty space to keep layout balanced
            ],
          ),
        ],
      ),
    );
  }
}

class CompactTracker extends StatelessWidget {
  final String label;
  final String emoji;
  final int value;
  final String unit;
  final Color color;
  final Function(int) onChanged;
  final int target;
  final bool isReverse;
  final bool isLargeNumber;
  final bool isFullWidth;

  const CompactTracker({
    super.key,
    required this.label,
    required this.emoji,
    required this.value,
    required this.unit,
    required this.color,
    required this.onChanged,
    this.target = 0,
    this.isReverse = false,
    this.isLargeNumber = false,
    this.isFullWidth = false,
  });

  double get progress {
    if (target == 0) return 0.0;
    return (value / target).clamp(0.0, 1.0);
  }

  Color get progressColor {
    if (isReverse) {
      // For reverse metrics (phone time, junk food), red when high, green when low
      if (progress <= 0.5) return Colors.green;
      if (progress <= 0.8) return Colors.orange;
      return Colors.red;
    } else {
      // For normal metrics, green when target reached
      if (progress >= 1.0) return Colors.green;
      if (progress >= 0.7) return Colors.orange;
      return color;
    }
  }

  void _showEditDialog(BuildContext context) {
    final controller = TextEditingController(text: value.toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update $label'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: label,
                suffixText: unit,
                border: const OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            if (target > 0) ...[
              const SizedBox(height: 12),
              Text(
                'Target: $target $unit',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newValue = int.tryParse(controller.text) ?? 0;
              onChanged(newValue);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  String get displayValue {
    if (isLargeNumber && value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEditDialog(context),
      child: Container(
        height: 60, // Increased height to accommodate new layout
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Emoji and label section - fixed width to prevent overflow
            SizedBox(
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(emoji, style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Made text black
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  if (target > 0) ...[
                    const SizedBox(height: 4),
                    Container(
                      height: 2,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: progressColor,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 4),
            // Value section - flexible to use available space
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      displayValue,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Made text black
                      ),
                      maxLines: 1,
                    ),
                  ),
                  if (unit.isNotEmpty)
                    Text(
                      unit,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.black54, // Made text black but slightly faded
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            // Quick increment buttons - side by side
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => onChanged((value - _getIncrement()).clamp(0, double.infinity).toInt()),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 12,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: () => onChanged(value + _getIncrement()),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 12,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _getIncrement() {
    if (isLargeNumber) return 500; // For steps
    if (unit == 'min') return 15; // For time in minutes
    return 1; // For hours, count, etc.
  }
}