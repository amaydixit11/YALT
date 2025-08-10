// lib/src/models/activity.dart
import 'package:flutter/material.dart';

class Activity {
  final String name;
  final IconData icon;
  final Color color;
  final ActivityType type;
  bool isCompleted;
  double progress;
  String? progressLabel;

  Activity({
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
    this.isCompleted = false,
    this.progress = 0.0,
    this.progressLabel,
  });

  void toggle() {
    if (type == ActivityType.boolean) {
      isCompleted = !isCompleted;
    }
  }

  void updateProgress(double newProgress, {String? label}) {
    if (type == ActivityType.progress) {
      progress = newProgress.clamp(0.0, 1.0);
      progressLabel = label;
      isCompleted = progress >= 1.0;
    }
  }
}

enum ActivityType {
  boolean,
  progress,
}