import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../viewmodels/settings_viewmodel.dart';
import '../../data/repository.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: settingsState.when(
        data: (settings) => _buildSettingsContent(context, ref, settings),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading settings: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(settingsViewModelProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context, WidgetRef ref, settings) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Appearance
        _buildSection(
          context,
          'Appearance',
          [
            ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Theme'),
              subtitle: Text(_getThemeDisplayName(settings.themeMode)),
              onTap: () => _showThemeDialog(context, ref, settings.themeMode),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Privacy & Security
        _buildSection(
          context,
          'Privacy & Security',
          [
            SwitchListTile(
              secondary: const Icon(Icons.security),
              title: const Text('Encryption'),
              subtitle: const Text('Encrypt local database'),
              value: settings.useEncryption,
              onChanged: (value) {
                if (value) {
                  _showEncryptionDialog(context, ref);
                } else {
                  ref.read(settingsViewModelProvider.notifier).toggleEncryption();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Privacy Policy'),
              subtitle: const Text('Your data never leaves your device'),
              onTap: () => _showPrivacyDialog(context),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Data Management
        _buildSection(
          context,
          'Data Management',
          [
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export Data'),
              subtitle: const Text('Download all your data as JSON'),
              onTap: () => _exportData(context, ref),
            ),
            ListTile(
              leading: const Icon(Icons.upload),
              title: const Text('Import Data'),
              subtitle: const Text('Restore from JSON backup'),
              onTap: () => _importData(context, ref),
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text('Clear All Data', style: TextStyle(color: Colors.red)),
              subtitle: const Text('Permanently delete all data'),
              onTap: () => _showClearDataDialog(context, ref),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Notifications
        _buildSection(
          context,
          'Notifications',
          [
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Daily Reminder'),
              subtitle: Text(settings.dailyReminderTime != null 
                  ? 'Remind at ${settings.dailyReminderTime!.format(context)}'
                  : 'No reminder set'),
              onTap: () => _setReminderTime(context, ref, settings.dailyReminderTime),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // About
        _buildSection(
          context,
          'About',
          [
            const ListTile(
              leading: Icon(Icons.info),
              title: Text('Version'),
              subtitle: Text('1.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Open Source'),
              subtitle: const Text('Built with Flutter'),
              onTap: () {
                // Could open GitHub repo
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  String _getThemeDisplayName(String themeMode) {
    switch (themeMode) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      default:
        return 'System';
    }
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref, String currentTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('System'),
              value: 'system',
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsViewModelProvider.notifier).updateThemeMode(value);
                  Navigator.of(context).pop();
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Light'),
              value: 'light',
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsViewModelProvider.notifier).updateThemeMode(value);
                  Navigator.of(context).pop();
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Dark'),
              value: 'dark',
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsViewModelProvider.notifier).updateThemeMode(value);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEncryptionDialog(BuildContext context, WidgetRef ref) {
    final passphraseController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable Encryption'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter a passphrase to encrypt your local database:'),
            const SizedBox(height: 16),
            TextField(
              controller: passphraseController,
              decoration: const InputDecoration(
                labelText: 'Passphrase',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (passphraseController.text.isNotEmpty) {
                // TODO: Implement encryption with passphrase
                ref.read(settingsViewModelProvider.notifier).toggleEncryption();
                Navigator.of(context).pop();
              }
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'LifeStats is designed with privacy in mind:\n\n'
            '• All your data is stored locally on your device\n'
            '• No data is sent to external servers\n'
            '• Optional encryption protects your data\n'
            '• You control all exports and backups\n'
            '• No analytics or tracking\n\n'
            'Your personal data stays personal.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    try {
      final repository = ref.read(repositoryProvider);
      final data = await repository.exportAllData();
      
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/lifestats_backup.json');
      await file.writeAsString(jsonEncode(data));
      
      await Share.shareXFiles([XFile(file.path)], text: 'LifeStats data backup');
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data exported successfully')),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $error')),
        );
      }
    }
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    // TODO: Implement file picker and import
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Import functionality coming soon')),
    );
  }

  void _showClearDataDialog(BuildContext context, WidgetRef ref) {
    final confirmController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This will permanently delete all your data. This action cannot be undone.\n\n'
              'Type "RESET" to confirm:',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmController,
              decoration: const InputDecoration(
                labelText: 'Type RESET',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              if (confirmController.text == 'RESET') {
                final repository = ref.read(repositoryProvider);
                await repository.clearAllData();
                
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All data cleared')),
                  );
                }
              }
            },
            child: const Text('Clear Data', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _setReminderTime(BuildContext context, WidgetRef ref, TimeOfDay? currentTime) async {
    final time = await showTimePicker(
      context: context,
      initialTime: currentTime ?? const TimeOfDay(hour: 20, minute: 0),
    );
    
    if (time != null) {
      final repository = ref.read(repositoryProvider);
      final currentSettings = await repository.getSettings();
      final updatedSettings = currentSettings.copyWith(dailyReminderTime: time);
      
      await ref.read(settingsViewModelProvider.notifier).updateSettings(updatedSettings);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reminder set for ${time.format(context)}')),
        );
      }
    }
  }
}