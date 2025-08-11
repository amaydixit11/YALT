import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:yalt_app/core/constants/metricIds.dart';
import 'package:yalt_app/ui/widgets/common/boolean_button.dart';
import 'package:yalt_app/ui/widgets/debug_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Life Stats")),
      body: const Center(
        child: Column(
          children: [
            DebugButton(),
            Row(
              children: [
                BooleanButton(label: "Breakfast", metricId: MetricIds.BREAKFAST),
                BooleanButton(label: "Lunch", metricId: MetricIds.LUNCH),
                BooleanButton(label: "Snacks", metricId: MetricIds.SNACKS),
                BooleanButton(label: "Dinner", metricId: MetricIds.DINNER),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
