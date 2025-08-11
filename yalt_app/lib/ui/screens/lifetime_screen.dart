import 'package:flutter/material.dart';
import 'package:yalt_app/core/constants/metricIds.dart';
import 'package:yalt_app/ui/widgets/common/boolean_button.dart';
import 'package:yalt_app/ui/widgets/common/counter_button.dart';
import 'package:yalt_app/ui/widgets/common/incremental_button.dart';
import 'package:yalt_app/ui/widgets/common/value_button.dart';
import 'package:yalt_app/ui/widgets/debug_button.dart';

class LifetimeScreen extends StatelessWidget {
  const LifetimeScreen({super.key});

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
    // Health Related - Lifetime
    final healthLifetime = [
      IncrementalButton(label: "Weight", metricId: MetricIds.WEIGHT),
    ];

    // Productivity Related - Lifetime
    final productivityLifetime = [
      CounterButton(label: "Projects", metricId: MetricIds.PROJECTS_STARTED),
      ValueButton(label: "Ideas", metricId: MetricIds.NEW_IDEAS),
      CounterButton(label: "Classes ✓", metricId: MetricIds.CLASSES_ATTENDED),
      CounterButton(label: "Classes ✗", metricId: MetricIds.CLASSES_MISSED),
    ];

    // Travel Related - Lifetime
    final travelPlaces = [
      ValueButton(label: "Cities", metricId: MetricIds.CITIES),
      ValueButton(label: "States", metricId: MetricIds.STATES),
      ValueButton(label: "Countries", metricId: MetricIds.COUNTRIES),
    ];

    final travelModes = [
      CounterButton(label: "Train", metricId: MetricIds.TRAIN),
      CounterButton(label: "Flight", metricId: MetricIds.FLIGHT),
      CounterButton(label: "Boat", metricId: MetricIds.BOAT),
      CounterButton(label: "Car", metricId: MetricIds.CAR),
      CounterButton(label: "Bike", metricId: MetricIds.BIKE),
      CounterButton(label: "Scooty", metricId: MetricIds.SCOOTY),
      CounterButton(label: "Cycle", metricId: MetricIds.CYCLE),
      CounterButton(label: "Metro", metricId: MetricIds.METRO),
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
            _buildCompactSection("Health", healthLifetime, Icons.monitor_weight, Colors.green),
            _buildCompactSection("Learning", productivityLifetime, Icons.emoji_objects, Colors.orange),
            _buildCompactSection("Places", travelPlaces, Icons.public, Colors.blue),
            _buildCompactSection("Transport", travelModes, Icons.directions, Colors.teal),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.2), width: 0.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.insights, color: Colors.deepPurple, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    "Lifetime cumulative stats",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}