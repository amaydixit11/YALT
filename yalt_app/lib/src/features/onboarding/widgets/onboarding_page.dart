import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget illustration;
  final List<Widget>? features;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.illustration,
    this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          illustration
              .animate()
              .scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 48),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
          if (features != null) ...[
            const SizedBox(height: 32),
            ...features!.map((feature) => feature
                .animate()
                .fadeIn(delay: 900.ms)
                .slideY(begin: 0.3, end: 0)),
          ],
        ],
      ),
    );
  }
}