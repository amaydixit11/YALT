import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuickCounter extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuickCounter({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  State<QuickCounter> createState() => _QuickCounterState();
}

class _QuickCounterState extends State<QuickCounter> {
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              widget.icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.value} ${widget.unit}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ).animate(target: _isAnimating ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2))
                .then()
                .scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    widget.onDecrement();
                    _triggerAnimation();
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.errorContainer,
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.onIncrement();
                    _triggerAnimation();
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _triggerAnimation() {
    setState(() {
      _isAnimating = true;
    });
    
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }
}