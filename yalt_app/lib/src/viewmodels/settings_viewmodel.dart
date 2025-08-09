import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/settings.dart';
import '../data/repository.dart';

final settingsViewModelProvider = AsyncNotifierProvider<SettingsViewModel, Settings>(
  () => SettingsViewModel(),
);

final isFirstRunProvider = FutureProvider<bool>((ref) async {
  final repository = ref.read(repositoryProvider);
  return repository.isFirstRun();
});

class SettingsViewModel extends AsyncNotifier<Settings> {
  late Repository _repository;
  
  @override
  Future<Settings> build() async {
    _repository = ref.read(repositoryProvider);
    return _repository.getSettings();
  }
  
  Future<void> updateSettings(Settings settings) async {
    state = const AsyncValue.loading();
    try {
      await _repository.saveSettings(settings);
      state = AsyncValue.data(settings);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  Future<void> updateThemeMode(String themeMode) async {
    final currentSettings = await future;
    final updatedSettings = currentSettings.copyWith(themeMode: themeMode);
    await updateSettings(updatedSettings);
  }
  
  Future<void> toggleEncryption() async {
    final currentSettings = await future;
    final updatedSettings = currentSettings.copyWith(
      useEncryption: !currentSettings.useEncryption,
    );
    await updateSettings(updatedSettings);
  }
  
  Future<void> setFirstRunComplete() async {
    await _repository.setFirstRunComplete();
    ref.invalidate(isFirstRunProvider);
  }
}