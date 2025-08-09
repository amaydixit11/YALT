import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/core/constants/app_constants.dart';
import 'src/core/theme/app_theme.dart';
import 'src/data/local/hive_setup.dart';
import 'src/core/services/notification_service.dart';
import 'src/features/main/main_screen.dart';
import 'src/features/onboarding/onboarding_screen.dart';
import 'src/viewmodels/settings_viewmodel.dart';

void main() async {
  // Ensure that Flutter bindings are initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive for local data storage
    await Hive.initFlutter();
    await HiveSetup.initialize();

    // Initialize the notification service
    await NotificationService.initialize();

    runApp(
      // Wrap the entire app in a ProviderScope for Riverpod state management
      const ProviderScope(
        child: MyApp(),
      ),
    );
  } catch (e) {
    // Handle initialization errors
    print('Error initializing app: $e');
    runApp(
      const ProviderScope(
        child: ErrorApp(),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the settings provider to dynamically update the theme
    final settings = ref.watch(settingsViewModelProvider);
    final isFirstRunAsync = ref.watch(isFirstRunProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      
      // Define light and dark themes for the app
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      
      // Set the theme mode based on user settings (system, light, or dark)
      themeMode: settings.when(
        data: (s) {
          switch (s.themeMode) {
            case 'light':
              return ThemeMode.light;
            case 'dark':
              return ThemeMode.dark;
            default:
              return ThemeMode.system;
          }
        },
        // Default to system theme while loading or on error
        loading: () => ThemeMode.system,
        error: (e, s) => ThemeMode.system,
      ),

      // Determine the initial screen
      home: isFirstRunAsync.when(
        data: (isFirstRun) {
          // If it's the first time the user opens the app, show the onboarding flow.
          // Otherwise, go straight to the main screen.
          return isFirstRun ? const OnboardingScreen() : const MainScreen();
        },
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          body: Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

// Error handling widget for initialization failures
class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Failed to initialize app',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Please restart the app'),
            ],
          ),
        ),
      ),
    );
  }
}