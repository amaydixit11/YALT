import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../viewmodels/settings_viewmodel.dart';
import '../main/main_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPage1(),
                  _buildPage2(),
                ],
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.analytics_outlined,
            size: 120,
            color: Color(0xFF0891B2),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 48),
          Text(
            'Welcome to LifeStats',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          Text(
            'Super fast personal life stats — everything stored locally on your device.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.security, color: Color(0xFF0891B2)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your data never leaves your device',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildPage2() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0891B2).withOpacity(0.1),
                  const Color(0xFF8B5CF6).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.trending_up,
                  size: 80,
                  color: Color(0xFF0891B2),
                ),
                const SizedBox(height: 16),
                Text(
                  'Track Everything',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 48),
          Text(
            'Quick logging, streaks, and fun facts',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          Text(
            'Log your mood, energy, sleep, and custom metrics in seconds. See beautiful charts, track streaks, and discover insights about your life.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 32),
          _buildFeatureList().animate().fadeIn(delay: 900.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      '📊 Beautiful charts and statistics',
      '🔥 Streak tracking and achievements',
      '⚡ Lightning-fast logging',
      '🎯 Custom counters and metrics',
    ];

    return Column(
      children: features.map((feature) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(
              feature.split(' ')[0],
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                feature.substring(feature.indexOf(' ') + 1),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(2, (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index 
                    ? const Color(0xFF0891B2)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            )).animate(interval: 100.ms).scale(),
          ),
          const SizedBox(height: 24),
          
          // Navigation buttons
          Row(
            children: [
              if (_currentPage > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Back'),
                  ),
                ),
              if (_currentPage > 0) const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _currentPage == 1 ? _completeOnboarding : _nextPage,
                  child: Text(_currentPage == 1 ? 'Get Started' : 'Next'),
                ),
              ),
            ],
          ),
          
          // Skip button
          if (_currentPage == 0)
            TextButton(
              onPressed: _completeOnboarding,
              child: const Text('Skip'),
            ),
        ],
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _completeOnboarding() async {
    await ref.read(settingsViewModelProvider.notifier).setFirstRunComplete();
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }
}