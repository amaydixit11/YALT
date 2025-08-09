import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daily_log.dart';
import '../data/repository.dart';

final historyViewModelProvider = AsyncNotifierProvider<HistoryViewModel, HistoryState>(
  () => HistoryViewModel(),
);

class HistoryViewModel extends AsyncNotifier<HistoryState> {
  late Repository _repository;
  List<DailyLog> _allLogs = [];
  String _searchQuery = '';
  String _selectedFilter = 'all';
  
  @override
  Future<HistoryState> build() async {
    _repository = ref.read(repositoryProvider);
    _allLogs = await _repository.getAllDailyLogs();
    
    return HistoryState(
      allLogs: _allLogs,
      filteredLogs: _allLogs,
      searchQuery: _searchQuery,
      selectedFilter: _selectedFilter,
    );
  }
  
  Future<void> search(String query) async {
    _searchQuery = query.toLowerCase();
    await _applyFilters();
  }
  
  Future<void> filter(String filterType) async {
    _selectedFilter = filterType;
    await _applyFilters();
  }
  
  Future<void> _applyFilters() async {
    var filtered = List<DailyLog>.from(_allLogs);
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((log) {
        return log.note?.toLowerCase().contains(_searchQuery) == true;
      }).toList();
    }
    
    // Apply metric filter
    switch (_selectedFilter) {
      case 'mood':
        filtered = filtered.where((log) => log.mood > 0).toList();
        break;
      case 'sleep':
        filtered = filtered.where((log) => log.sleepHours > 0).toList();
        break;
      case 'water':
        filtered = filtered.where((log) => log.waterCups > 0).toList();
        break;
      case 'notes':
        filtered = filtered.where((log) => log.note?.isNotEmpty == true).toList();
        break;
      case 'all':
      default:
        // No additional filtering
        break;
    }
    
    state = AsyncValue.data(HistoryState(
      allLogs: _allLogs,
      filteredLogs: filtered,
      searchQuery: _searchQuery,
      selectedFilter: _selectedFilter,
    ));
  }
  
  Future<void> deleteLog(String id) async {
    await _repository.deleteDailyLog(id);
    _allLogs = await _repository.getAllDailyLogs();
    await _applyFilters();
  }
  
  Future<void> refresh() async {
    _allLogs = await _repository.getAllDailyLogs();
    await _applyFilters();
  }
}

class HistoryState {
  final List<DailyLog> allLogs;
  final List<DailyLog> filteredLogs;
  final String searchQuery;
  final String selectedFilter;
  
  HistoryState({
    required this.allLogs,
    required this.filteredLogs,
    required this.searchQuery,
    required this.selectedFilter,
  });
}