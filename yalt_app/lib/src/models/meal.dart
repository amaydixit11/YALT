// lib/src/models/meal.dart
import 'package:flutter/material.dart';

class Meal {
  final String name;
  final IconData icon;
  final Color color;
  bool isCompleted;

  Meal({
    required this.name,
    required this.icon,
    required this.color,
    this.isCompleted = false,
  });

  void toggle() {
    isCompleted = !isCompleted;
  }
}
