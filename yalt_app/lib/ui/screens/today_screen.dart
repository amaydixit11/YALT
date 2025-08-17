import 'package:flutter/material.dart';
import 'package:yalt_app/core/constants/metricIds.dart';
import 'package:yalt_app/ui/widgets/common/boolean_button.dart';
import 'package:yalt_app/ui/widgets/common/counter_button.dart';
import 'package:yalt_app/ui/widgets/common/incremental_button.dart';
import 'package:yalt_app/ui/widgets/common/value_button.dart';
import 'package:yalt_app/ui/widgets/debug_button.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  Widget _buildCompactSection(String title, List<Widget> buttons, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border.all(color: color.withOpacity(0.2), width: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 3,
            children: buttons,
          ),
        ],
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
      CounterButton(label: "Hand Washing", metricId: MetricIds.HAND_WASHING),
      CounterButton(label: "Shower", metricId: MetricIds.SHOWER),
      CounterButton(label: "Brush", metricId: MetricIds.BRUSH),
      CounterButton(label: "Poop", metricId: MetricIds.POOP),
      CounterButton(label: "Pee", metricId: MetricIds.PEE),
      CounterButton(label: "Momentum", metricId: MetricIds.MOMENTUM),
    ];

    final healthTracking = [
      ValueButton(label: "Sleep Time", metricId: MetricIds.SLEEPING_TIME),
      ValueButton(label: "Wake Time", metricId: MetricIds.WAKEUP_TIME),
      IncrementalButton(label: "Phone", metricId: MetricIds.SCREEN_TIME_PHONE, predefinedValues: [5, 15, 20, 30, 45, 60, 75, 90]),
      IncrementalButton(label: "Laptop", metricId: MetricIds.SCREEN_TIME_LAPTOP, predefinedValues: [5, 15, 20, 30, 45, 60, 75, 90]),
      IncrementalButton(label: "TV", metricId: MetricIds.SCREEN_TIME_TV, predefinedValues: [5, 15, 20, 30, 45, 60, 75, 90]),
      IncrementalButton(label: "Steps", metricId: MetricIds.SCREEN_TIME_STEPS, predefinedValues: [100, 250, 500]),
    ];
  
    // Productivity Related - Today
    final productivity = [
      CounterButton(label: "Problems", metricId: MetricIds.PROBLEMS_SOLVED),
      IncrementalButton(
        label: "Study", 
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
      IncrementalButton(label: "Energy", metricId: MetricIds.ENERGY_LEVEL),
      IncrementalButton(label: "Anxiety", metricId: MetricIds.ANXIETY_LEVEL),
      IncrementalButton(label: "Stress", metricId: MetricIds.STRESS_LEVEL),
    ];

    // Finance Related - Today
    final finance = [
      IncrementalButton(label: "Cash", metricId: MetricIds.SPENDING_CASH, predefinedValues: [10, 20, 30, 50, 80, 100, 120, 150, 200, 250, 500]),
      IncrementalButton(label: "UPI", metricId: MetricIds.SPENDING_UPI, predefinedValues: [10, 20, 30, 50, 80, 100, 120, 150, 200, 250, 500]),
    ];

    // Social Related - Today
    final social = [
      ValueButton(label: "Friends", metricId: MetricIds.FRIENDS),
      ValueButton(label: "Family", metricId: MetricIds.FAMILY),
      ValueButton(label: "Colleagues", metricId: MetricIds.COLLEAGUES),
      ValueButton(label: "Relatives", metricId: MetricIds.RELATIVES),
      ValueButton(label: "Online", metricId: MetricIds.ONLINE_FRIENDS),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            DebugButton(),
            const SizedBox(height: 4),
            _buildCompactSection("Meals", foodMeals, Icons.restaurant, Colors.orange),
            _buildCompactSection("Drinks", foodDrinks, Icons.local_drink, Colors.blue),
            _buildCompactSection("Hygiene", healthHygiene, Icons.clean_hands, Colors.green),
            _buildCompactSection("Screen & Sleep", healthTracking, Icons.smartphone, Colors.purple),
            _buildCompactSection("Work", productivity, Icons.work, Colors.teal),
            _buildCompactSection("Fun", entertainment, Icons.games, Colors.red),
            _buildCompactSection("Mood", mood, Icons.mood, Colors.pink),
            _buildCompactSection("Money", finance, Icons.account_balance_wallet, Colors.indigo),
            _buildCompactSection("Social", social, Icons.people, Colors.amber),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}