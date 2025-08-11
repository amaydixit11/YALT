import 'package:flutter/material.dart';
import 'package:yalt_app/core/constants/metricIds.dart';
import 'package:yalt_app/ui/widgets/common/boolean_button.dart';
import 'package:yalt_app/ui/widgets/common/counter_button.dart';
import 'package:yalt_app/ui/widgets/common/incremental_button.dart';
import 'package:yalt_app/ui/widgets/common/value_button.dart';
import 'package:yalt_app/ui/widgets/debug_button.dart';

class LifetimeScreen extends StatelessWidget {
  const LifetimeScreen({super.key});

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
    // Health Related - Lifetime
    final healthLifetime = [
      IncrementalButton(label: "Weight Records", metricId: MetricIds.WEIGHT),
    ];

    // Productivity Related - Lifetime
    final productivityLifetime = [
      CounterButton(label: "Projects Started", metricId: MetricIds.PROJECTS_STARTED),
      ValueButton(label: "New Ideas", metricId: MetricIds.NEW_IDEAS),
      CounterButton(label: "Classes Attended", metricId: MetricIds.CLASSES_ATTENDED),
      CounterButton(label: "Classes Missed", metricId: MetricIds.CLASSES_MISSED),
    ];

    // Travel Related - Lifetime
    final travelPlaces = [
      ValueButton(label: "Cities Visited", metricId: MetricIds.CITIES),
      ValueButton(label: "States Visited", metricId: MetricIds.STATES),
      ValueButton(label: "Countries Visited", metricId: MetricIds.COUNTRIES),
    ];

    final travelModes = [
      CounterButton(label: "Train Rides", metricId: MetricIds.TRAIN),
      CounterButton(label: "Flight Trips", metricId: MetricIds.FLIGHT),
      CounterButton(label: "Boat Rides", metricId: MetricIds.BOAT),
      CounterButton(label: "Car Trips", metricId: MetricIds.CAR),
      CounterButton(label: "Bike Rides", metricId: MetricIds.BIKE),
      CounterButton(label: "Scooty Rides", metricId: MetricIds.SCOOTY),
      CounterButton(label: "Cycle Rides", metricId: MetricIds.CYCLE),
      CounterButton(label: "Metro Trips", metricId: MetricIds.METRO),
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
                Icon(Icons.timeline, color: Colors.deepPurple, size: 28),
                const SizedBox(width: 8),
                Text(
                  "Lifetime Tracking",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Track your achievements and experiences over time",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            DebugButton(),
            _buildSection("Health Milestones", healthLifetime, Icons.monitor_weight, Colors.green),
            _buildSection("Productivity & Learning", productivityLifetime, Icons.emoji_objects, Colors.orange),
            _buildSection("Places Explored", travelPlaces, Icons.public, Colors.blue),
            _buildSection("Transportation History", travelModes, Icons.directions, Colors.teal),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.insights, color: Colors.deepPurple, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    "Lifetime Stats",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "These metrics accumulate over your entire journey",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}