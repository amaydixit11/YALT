import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/history_viewmodel.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/constants/app_constants.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(historyViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search notes...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (query) {
                    ref.read(historyViewModelProvider.notifier).search(query);
                  },
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildFilterChip('all', 'All'),
                    _buildFilterChip('mood', 'Mood'),
                    _buildFilterChip('sleep', 'Sleep'),
                    _buildFilterChip('water', 'Water'),
                    _buildFilterChip('notes', 'Notes'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: historyState.when(
        data: (state) => _buildHistoryList(context, state),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading history: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(historyViewModelProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _selectedFilter == value;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = value;
          });
          ref.read(historyViewModelProvider.notifier).filter(value);
        },
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context, HistoryState state) {
    if (state.filteredLogs.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No entries found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Start logging to see your history here',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.filteredLogs.length,
      itemBuilder: (context, index) {
        final log = state.filteredLogs[index];
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: _getMoodColor(log.mood),
              child: Text(
                log.mood > 0 ? AppConstants.moodEmojis[log.mood - 1] : '?',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            title: Text(date_utils.DateUtils.formatDateDisplay(log.date)),
            subtitle: Text(
              _buildLogSummary(log),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMetricRow('Mood', '${log.mood}/5', AppConstants.moodEmojis[log.mood - 1]),
                    _buildMetricRow('Energy', '${log.energy}/5', '⚡'),
                    _buildMetricRow('Sleep', '${log.sleepHours.toStringAsFixed(1)} hrs', '😴'),
                    _buildMetricRow('Water', '${log.waterCups} cups', '💧'),
                    if (log.note?.isNotEmpty == true) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Note:',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(log.note!),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _editLog(log),
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                        ),
                        TextButton.icon(
                          onPressed: () => _deleteLog(log),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetricRow(String label, String value, String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(value),
        ],
      ),
    );
  }

  Color _getMoodColor(int mood) {
    if (mood == 0) return Colors.grey;
    const colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.green,
    ];
    return colors[mood - 1];
  }

  String _buildLogSummary(log) {
    final parts = <String>[];
    if (log.mood > 0) parts.add('Mood: ${log.mood}/5');
    if (log.energy > 0) parts.add('Energy: ${log.energy}/5');
    if (log.sleepHours > 0) parts.add('Sleep: ${log.sleepHours.toStringAsFixed(1)}h');
    if (log.waterCups > 0) parts.add('Water: ${log.waterCups} cups');
    
    return parts.isEmpty ? 'No data logged' : parts.join(' • ');
  }

  void _editLog(log) {
    // TODO: Navigate to edit screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit functionality coming soon')),
    );
  }

  void _deleteLog(log) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this entry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(historyViewModelProvider.notifier).deleteLog(log.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Entry deleted'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // TODO: Implement undo functionality
              },
            ),
          ),
        );
      }
    }
  }
}