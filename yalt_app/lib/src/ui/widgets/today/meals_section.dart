// lib/src/ui/widgets/today/meals_section.dart
import 'package:flutter/material.dart';
import '../common/section_wrapper.dart';
import '../common/animated_checkbox.dart';

class MealsSection extends StatelessWidget {
  const MealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      title: 'Meals',
      subtitle: 'Track your eating habits',
      icon: Icons.restaurant_rounded,
      iconColor: Colors.orange,
      child: MealsPanel(),
    );
  }
}

class MealsPanel extends StatefulWidget {
  @override
  State<MealsPanel> createState() => _MealsPanelState();
}

class _MealsPanelState extends State<MealsPanel> {
  List<Map<String, dynamic>> meals = [
    {'name': 'Breakfast', 'icon': Icons.free_breakfast_rounded, 'color': Colors.orange, 'completed': false},
    {'name': 'Lunch', 'icon': Icons.lunch_dining_rounded, 'color': Colors.green, 'completed': false},
    {'name': 'Dinner', 'icon': Icons.dinner_dining_rounded, 'color': Colors.red, 'completed': false},
    {'name': 'Snacks', 'icon': Icons.cookie_rounded, 'color': Colors.purple, 'completed': false},
  ];

  void _toggleMealCompletion(int index) {
    setState(() {
      meals[index]['completed'] = !meals[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: meals.asMap().entries.map((entry) {
          final index = entry.key;
          final meal = entry.value;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 0 : 4,
                right: index == meals.length - 1 ? 0 : 4,
              ),
              child: CompactMealButton(
                name: meal['name'] as String,
                icon: meal['icon'] as IconData,
                color: meal['color'] as Color,
                isCompleted: meal['completed'] as bool,
                onTap: () => _toggleMealCompletion(index),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CompactMealButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final VoidCallback onTap;

  const CompactMealButton({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: 70,
        decoration: BoxDecoration(
          color: isCompleted ? color.withOpacity(0.15) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted ? color.withOpacity(0.6) : Colors.grey.shade200,
            width: isCompleted ? 2 : 1,
          ),
          boxShadow: isCompleted ? [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isCompleted ? color.withOpacity(0.25) : color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon, 
                color: isCompleted ? color : color.withOpacity(0.7),
                size: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isCompleted ? FontWeight.w700 : FontWeight.w600,
                color: isCompleted ? color : Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isCompleted ? 1.1 : 0.9,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isCompleted ? color : Colors.transparent,
                  border: Border.all(
                    color: isCompleted ? color : Colors.grey.shade400,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: isCompleted 
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 8,
                    )
                  : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}