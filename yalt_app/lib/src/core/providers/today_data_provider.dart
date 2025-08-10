// lib/src/providers/today_data_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/meal.dart';
import '../../models/hygiene_item.dart';
import '../../models/activity.dart';
import 'package:flutter/material.dart';

final mealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
  return MealsNotifier();
});

final hygieneProvider = StateNotifierProvider<HygieneNotifier, List<HygieneItemModel>>((ref) {
  return HygieneNotifier();
});

final activitiesProvider = StateNotifierProvider<ActivitiesNotifier, List<Activity>>((ref) {
  return ActivitiesNotifier();
});

final waterIntakeProvider = StateNotifierProvider<WaterIntakeNotifier, int>((ref) {
  return WaterIntakeNotifier();
});

final coldDrinksProvider = StateNotifierProvider<ColdDrinksNotifier, int>((ref) {
  return ColdDrinksNotifier();
});

class MealsNotifier extends StateNotifier<List<Meal>> {
  MealsNotifier() : super([
    Meal(name: 'Breakfast', icon: Icons.free_breakfast_rounded, color: Colors.orange, isCompleted: true),
    Meal(name: 'Lunch', icon: Icons.lunch_dining_rounded, color: Colors.green),
    Meal(name: 'Dinner', icon: Icons.dinner_dining_rounded, color: Colors.red),
    Meal(name: 'Snacks', icon: Icons.cookie_rounded, color: Colors.purple, isCompleted: true),
  ]);

  void toggleMeal(int index) {
    final meals = [...state];
    meals[index].toggle();
    state = meals;
  }
}

class HygieneNotifier extends StateNotifier<List<HygieneItemModel>> {
  HygieneNotifier() : super([
    HygieneItemModel(name: 'Brush Teeth', icon: Icons.brush_rounded, color: Colors.blue, isCompleted: true),
    HygieneItemModel(name: 'Bath/Shower', icon: Icons.bathtub_rounded, color: Colors.cyan),
    HygieneItemModel(name: 'Skincare', icon: Icons.face_retouching_natural_rounded, color: Colors.pink),
    HygieneItemModel(name: 'Grooming', icon: Icons.content_cut_rounded, color: Colors.brown),
  ]);

  void toggleHygiene(int index) {
    final items = [...state];
    items[index].toggle();
    state = items;
  }
}

class ActivitiesNotifier extends StateNotifier<List<Activity>> {
  ActivitiesNotifier() : super([
    Activity(
      name: 'Morning Walk',
      icon: Icons.directions_walk_rounded,
      color: Colors.green,
      type: ActivityType.boolean,
      isCompleted: true,
    ),
    Activity(
      name: 'Reading',
      icon: Icons.book_rounded,
      color: Colors.indigo,
      type: ActivityType.progress,
      progress: 0.5,
      progressLabel: '25/50 pages',
    ),
    Activity(
      name: 'Exercise',
      icon: Icons.fitness_center_rounded,
      color: Colors.red,
      type: ActivityType.progress,
      progress: 0.75,
      progressLabel: '45/60 min',
    ),
    Activity(
      name: 'Meditation',
      icon: Icons.self_improvement_rounded,
      color: Colors.teal,
      type: ActivityType.boolean,
    ),
  ]);

  void toggleActivity(int index) {
    final activities = [...state];
    activities[index].toggle();
    state = activities;
  }

  void updateActivityProgress(int index, double progress, {String? label}) {
    final activities = [...state];
    activities[index].updateProgress(progress, label: label);
    state = activities;
  }
}

class WaterIntakeNotifier extends StateNotifier<int> {
  WaterIntakeNotifier() : super(1200);

  void addWater(int ml) {
    state += ml;
  }

  void resetWater() {
    state = 0;
  }
}

class ColdDrinksNotifier extends StateNotifier<int> {
  ColdDrinksNotifier() : super(2);

  void addDrink() {
    state++;
  }

  void resetDrinks() {
    state = 0;
  }
}