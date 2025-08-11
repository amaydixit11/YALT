import 'package:flutter/material.dart';
import 'package:yalt_app/core/constants/metricIds.dart';
import 'package:yalt_app/ui/widgets/common/boolean_button.dart';
import 'package:yalt_app/ui/widgets/common/counter_button.dart';
import 'package:yalt_app/ui/widgets/common/incremental_button.dart';
import 'package:yalt_app/ui/widgets/common/value_button.dart';
import 'package:yalt_app/ui/widgets/debug_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildSection(String title, List<Widget> buttons) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: buttons,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Food Related - meals as BooleanButtons, drinks as CounterButtons
    final foodMeals = [
      BooleanButton(label: "Breakfast", metricId: MetricIds.BREAKFAST),
      BooleanButton(label: "Lunch", metricId: MetricIds.LUNCH),
      BooleanButton(label: "Snacks", metricId: MetricIds.SNACKS),
      BooleanButton(label: "Dinner", metricId: MetricIds.DINNER),
      BooleanButton(label: "Coffee", metricId: MetricIds.COFFEE),
      BooleanButton(label: "Water", metricId: MetricIds.WATER),
    ];

    final foodDrinks = [
      CounterButton(label: "Coke", metricId: MetricIds.COLD_DRINK_COKE),
      CounterButton(label: "Pepsi", metricId: MetricIds.COLD_DRINK_PEPSI),
      CounterButton(label: "Thumbs Up", metricId: MetricIds.COLD_DRINK_THUMBSUP),
      CounterButton(label: "Sprite", metricId: MetricIds.COLD_DRINK_SPRITE),
      CounterButton(label: "Mt. Dew", metricId: MetricIds.COLD_DRINK_MOUNTAINDew),
      CounterButton(label: "Fanta", metricId: MetricIds.COLD_DRINK_FANTA),
      CounterButton(label: "Mirinda", metricId: MetricIds.COLD_DRINK_MIRINDA),
      CounterButton(label: "Sting", metricId: MetricIds.COLD_DRINK_STING),
      CounterButton(label: "Gold Sting", metricId: MetricIds.COLD_DRINK_GOLDSTING),
      CounterButton(label: "Blue Sting", metricId: MetricIds.COLD_DRINK_BLUESTING),
      CounterButton(label: "Limca", metricId: MetricIds.COLD_DRINK_LIMCA),
      CounterButton(label: "Goli Soda", metricId: MetricIds.COLD_DRINK_GOLISODA),
      CounterButton(label: "Jeera Soda", metricId: MetricIds.COLD_DRINK_JEERASODA),
      CounterButton(label: "Arora Lemon", metricId: MetricIds.COLD_DRINK_ARORALEMON),
      CounterButton(label: "Nimbooz", metricId: MetricIds.COLD_DRINK_NIMBOOZ),
      CounterButton(label: "Slice", metricId: MetricIds.COLD_DRINK_SLICE),
      CounterButton(label: "Maaza", metricId: MetricIds.COLD_DRINK_MAAZA),
      CounterButton(label: "Frooti", metricId: MetricIds.COLD_DRINK_FROOTI),
    ];

    // Health Related
    final healthBooleans = [
      IncrementalButton(label: "Hand Washing", metricId: MetricIds.HAND_WASHING),
      IncrementalButton(label: "Shower", metricId: MetricIds.SHOWER),
      IncrementalButton(label: "Brush", metricId: MetricIds.BRUSH),
      IncrementalButton(label: "Poop", metricId: MetricIds.POOP),
      IncrementalButton(label: "Pee", metricId: MetricIds.PEE),
      IncrementalButton(label: "Momentum", metricId: MetricIds.MOMENTUM),
    ];

    final healthIncrementals = [
      IncrementalButton(label: "Sleeping Time", metricId: MetricIds.SLEEPING_TIME),
      IncrementalButton(label: "Wakeup Time", metricId: MetricIds.WAKEUP_TIME),
      IncrementalButton(label: "Screen Time Phone", metricId: MetricIds.SCREEN_TIME_PHONE),
      IncrementalButton(label: "Screen Time Laptop", metricId: MetricIds.SCREEN_TIME_LAPTOP),
      IncrementalButton(label: "Screen Time TV", metricId: MetricIds.SCREEN_TIME_TV),
      IncrementalButton(label: "Steps", metricId: MetricIds.SCREEN_TIME_STEPS),
    ];

    // Productivity Related
    final productivityIncrementals = [
      IncrementalButton(label: "Problems Solved", metricId: MetricIds.PROBLEMS_SOLVED),
      IncrementalButton(label: "Study Hours", metricId: MetricIds.STUDY),
    ];

    // Entertainment Related
    final entertainmentIncrementals = [
      IncrementalButton(label: "Gaming", metricId: MetricIds.GAMING),
      IncrementalButton(label: "Music", metricId: MetricIds.MUSIC),
      IncrementalButton(label: "Movie", metricId: MetricIds.MOVIE),
      IncrementalButton(label: "Series", metricId: MetricIds.SERIES),
      IncrementalButton(label: "Book", metricId: MetricIds.BOOK),
    ];

    // Mood Related - ValueButton (user picks mood string)
    final moodValues = [
      ValueButton(label: "Mood", metricId: MetricIds.MOOD),
      ValueButton(label: "Happy", metricId: MetricIds.HAPPY),
      ValueButton(label: "Sad", metricId: MetricIds.SAD),
      ValueButton(label: "Angry", metricId: MetricIds.ANGRY),
      ValueButton(label: "Excited", metricId: MetricIds.EXCITED),
      ValueButton(label: "Relaxed", metricId: MetricIds.RELAXED),
      ValueButton(label: "Anxious", metricId: MetricIds.ANXIOUS),
    ];

    // Finance Related
    final financeIncrementals = [
      IncrementalButton(label: "Spending Cash", metricId: MetricIds.SPENDING_CASH),
      IncrementalButton(label: "Spending UPI", metricId: MetricIds.SPENDING_UPI),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Life Stats")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DebugButton(),
            _buildSection("Food - Meals", foodMeals),
            _buildSection("Food - Drinks", foodDrinks),
            _buildSection("Health - Hygiene", healthBooleans),
            _buildSection("Health - Times & Steps", healthIncrementals),
            _buildSection("Productivity", productivityIncrementals),
            _buildSection("Entertainment", entertainmentIncrementals),
            _buildSection("Mood", moodValues),
            _buildSection("Finance", financeIncrementals),
          ],
        ),
      ),
    );
  }
}
