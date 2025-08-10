import 'package:flutter/material.dart';

class HygieneItemModel {
  final String name;
  final IconData icon;
  final Color color;
  bool isCompleted;

  HygieneItemModel({
    required this.name,
    required this.icon,
    required this.color,
    this.isCompleted = false,
  });

  void toggle() {
    isCompleted = !isCompleted;
  }
}