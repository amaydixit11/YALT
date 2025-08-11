import 'package:flutter/material.dart';
import 'package:yalt_app/core/constants/metricIds.dart';
import 'package:yalt_app/ui/widgets/common/boolean_button.dart';
import 'package:yalt_app/ui/widgets/common/counter_button.dart';
import 'package:yalt_app/ui/widgets/common/incremental_button.dart';
import 'package:yalt_app/ui/widgets/common/value_button.dart';
import 'package:yalt_app/ui/widgets/debug_button.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  Widget _buildSection(String title, List<Widget> buttons, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: buttons,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Food Related - Today
    final foodMeals = [
      BooleanButton(label: "Breakfast", metricId: MetricIds.BREAKFAST),
      BooleanButton(label: "Lunch", metricId: MetricIds.LUNCH),
      BooleanButton(label: "Snacks", metricId: MetricIds.SNACKS),
      BooleanButton(label: "Dinner", metricId: MetricIds.DINNER),
      CounterButton(label: "Coffee", metricId: MetricIds.COFFEE),
      IncrementalButton(
        label: "Water", 
        metricId: MetricIds.WATER, 
        predefinedValues: [100, 250, 500],
      ),
    ];

    final foodDrinks = [
      CounterButton(label: "Coke", metricId: MetricIds.COLD_DRINK_COKE),
      CounterButton(label: "Pepsi", metricId: MetricIds.COLD_DRINK_PEPSI),
      CounterButton(label: "Thumbs Up", metricId: MetricIds.COLD_DRINK_THUMBSUP),
      CounterButton(label: "Sprite", metricId: MetricIds.COLD_DRINK_SPRITE),
      CounterButton(label: "Mt. Dew", metricId: MetricIds.COLD_DRINK_MOUNTAINDEW),
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

    // Health Related - Today
    final healthHygiene = [
      IncrementalButton(label: "Hand Washing", metricId: MetricIds.HAND_WASHING),
      IncrementalButton(label: "Shower", metricId: MetricIds.SHOWER),
      IncrementalButton(label: "Brush", metricId: MetricIds.BRUSH),
      IncrementalButton(label: "Poop", metricId: MetricIds.POOP),
      IncrementalButton(label: "Pee", metricId: MetricIds.PEE),
      IncrementalButton(label: "Momentum", metricId: MetricIds.MOMENTUM),
    ];

    final healthTracking = [
      ValueButton(label: "Sleeping Time", metricId: MetricIds.SLEEPING_TIME),
      ValueButton(label: "Wakeup Time", metricId: MetricIds.WAKEUP_TIME),
      IncrementalButton(label: "Phone Screen Time", metricId: MetricIds.SCREEN_TIME_PHONE, predefinedValues: [5, 15, 20, 30, 45, 60, 75, 90]),
      IncrementalButton(label: "Laptop Screen Time", metricId: MetricIds.SCREEN_TIME_LAPTOP, predefinedValues: [5, 15, 20, 30, 45, 60, 75, 90]),
      IncrementalButton(label: "TV Screen Time", metricId: MetricIds.SCREEN_TIME_TV, predefinedValues: [5, 15, 20, 30, 45, 60, 75, 90]),
      IncrementalButton(label: "Steps", metricId: MetricIds.SCREEN_TIME_STEPS, predefinedValues: [100, 250, 500]),
    ];
  
    // Productivity Related - Today
    final productivity = [
      CounterButton(label: "Problems Solved", metricId: MetricIds.PROBLEMS_SOLVED),
      IncrementalButton(
        label: "Study Hours", 
        metricId: MetricIds.STUDY, 
        predefinedValues: [5, 15, 30, 45, 60, 75, 90],
      ),
    ];

    // Entertainment Related - Today
    final entertainment = [
      IncrementalButton(label: "Gaming", metricId: MetricIds.GAMING),
      ValueButton(label: "Movie", metricId: MetricIds.MOVIE),
      ValueButton(label: "Series", metricId: MetricIds.SERIES),
      ValueButton(label: "Book", metricId: MetricIds.BOOK),
    ];

    // Mood Related - Today
    final mood = [
      IncrementalButton(label: "Mood", metricId: MetricIds.MOOD),
      CounterButton(label: "Happy", metricId: MetricIds.HAPPY),
      CounterButton(label: "Sad", metricId: MetricIds.SAD),
      CounterButton(label: "Angry", metricId: MetricIds.ANGRY),
      CounterButton(label: "Excited", metricId: MetricIds.EXCITED),
      CounterButton(label: "Relaxed", metricId: MetricIds.RELAXED),
      CounterButton(label: "Anxious", metricId: MetricIds.ANXIOUS),
      IncrementalButton(label: "Energy Level", metricId: MetricIds.ENERGY_LEVEL),
      IncrementalButton(label: "Anxiety Level", metricId: MetricIds.ANXIETY_LEVEL),
      IncrementalButton(label: "Stress Level", metricId: MetricIds.STRESS_LEVEL),
    ];

    // Finance Related - Today
    final finance = [
      IncrementalButton(label: "Cash Spending", metricId: MetricIds.SPENDING_CASH, predefinedValues: [10, 20, 30, 50, 80, 100, 120, 150, 200, 250, 500]),
      IncrementalButton(label: "UPI Spending", metricId: MetricIds.SPENDING_UPI, predefinedValues: [10, 20, 30, 50, 80, 100, 120, 150, 200, 250, 500]),
    ];

    // Social Related - Today
    final social = [
      ValueButton(label: "Friends", metricId: MetricIds.FRIENDS),
      ValueButton(label: "Family", metricId: MetricIds.FAMILY),
      ValueButton(label: "Colleagues", metricId: MetricIds.COLLEAGUES),
      ValueButton(label: "Relatives", metricId: MetricIds.RELATIVES),
      ValueButton(label: "Online Friends", metricId: MetricIds.ONLINE_FRIENDS),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.today, color: Colors.blue, size: 28),
                const SizedBox(width: 8),
                Text(
                  "Today's Tracking",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DebugButton(),
            _buildSection("Meals & Beverages", foodMeals, Icons.restaurant, Colors.orange),
            _buildSection("Cold Drinks", foodDrinks, Icons.local_drink, Colors.blue),
            _buildSection("Hygiene", healthHygiene, Icons.clean_hands, Colors.green),
            _buildSection("Screen Time & Sleep", healthTracking, Icons.smartphone, Colors.purple),
            _buildSection("Productivity", productivity, Icons.work, Colors.teal),
            _buildSection("Entertainment", entertainment, Icons.games, Colors.red),
            _buildSection("Mood & Feelings", mood, Icons.mood, Colors.pink),
            _buildSection("Finance", finance, Icons.account_balance_wallet, Colors.indigo),
            _buildSection("Social Interactions", social, Icons.people, Colors.amber),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}