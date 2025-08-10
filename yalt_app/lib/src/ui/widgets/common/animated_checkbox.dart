import 'package:flutter/material.dart';

class AnimatedCheckbox extends StatelessWidget {
  final bool isChecked;
  final Color color;

  const AnimatedCheckbox({
    super.key,
    required this.isChecked,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isChecked ? color : Colors.transparent,
        border: Border.all(
          color: isChecked ? color : Colors.grey.shade400,
          width: 2,
        ),
      ),
      child: isChecked
          ? const Icon(
              Icons.check_rounded,
              size: 16,
              color: Colors.white,
            )
          : null,
    );
  }
}