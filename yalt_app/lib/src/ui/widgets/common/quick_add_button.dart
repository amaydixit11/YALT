// lib/src/ui/widgets/common/quick_add_button_widget.dart
import 'package:flutter/material.dart';

class QuickAddButtonWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final Color? color;
  final VoidCallback onTap;
  final bool isSelected;

  const QuickAddButtonWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    this.color,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = color ?? theme.primaryColor;
    final isDark = theme.brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? buttonColor.withOpacity(0.2)
              : (isDark ? Colors.grey[800] : Colors.grey[100]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? buttonColor 
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: buttonColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? buttonColor 
                  : theme.colorScheme.onSurface.withOpacity(0.7),
              size: 20,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected 
                        ? buttonColor 
                        : theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuickAddGridWidget extends StatelessWidget {
  final List<QuickAddButtonWidget> buttons;
  final int crossAxisCount;

  const QuickAddGridWidget({
    super.key,
    required this.buttons,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: buttons,
    );
  }
}