import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';

class DebugButton extends ConsumerWidget {
  const DebugButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logService = ref.watch(logServiceProvider);

    return FloatingActionButton.extended(
      onPressed: () => _showDebugDialog(context, logService),
      icon: const Icon(Icons.bug_report),
      label: const Text('Debug'),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      heroTag: "debug_button", // Prevents hero animation conflicts
    );
  }

  void _showDebugDialog(BuildContext context, logService) async {
    // Show loading dialog first
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading database entries...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      final entries = await logService.getAllEntries();

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();

        // Show main debug dialog
        showDialog(
          context: context,
          builder: (context) => DebugDialog(entries: entries),
        );
      }
    } catch (error) {
      // Close loading dialog and show error
      if (context.mounted) {
        Navigator.of(context).pop();
        _showErrorDialog(context, error.toString());
      }
    }
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Text('Failed to load database entries:\n$error'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class DebugDialog extends StatefulWidget {
  final List<dynamic> entries;

  const DebugDialog({super.key, required this.entries});

  @override
  State<DebugDialog> createState() => _DebugDialogState();
}

class _DebugDialogState extends State<DebugDialog> {
  String _searchQuery = '';
  String _selectedFilter = 'All';
  final List<String> _filterOptions = [
    'All',
    'Food',
    'Health',
    'Productivity',
    'Entertainment',
    'Mood',
    'Finance',
    'Travel',
    'Social',
  ];

  List<dynamic> get _filteredEntries {
    var filtered = widget.entries.where((entry) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final metricName = _getMetricName(entry.metricId).toLowerCase();
        if (!metricName.contains(_searchQuery.toLowerCase())) {
          return false;
        }
      }

      // Category filter
      if (_selectedFilter != 'All') {
        final category = _getMetricCategory(entry.metricId);
        if (category != _selectedFilter) {
          return false;
        }
      }

      return true;
    }).toList();

    // Sort by timestamp (newest first)
    filtered.sort((a, b) {
      final timeA = a.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      final timeB = b.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      return timeB.compareTo(timeA);
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredEntries = _filteredEntries;

    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Database Entries (${filteredEntries.length})'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => _copyAllEntries(filteredEntries),
              tooltip: 'Copy all entries',
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                switch (value) {
                  case 'clear_search':
                    setState(() {
                      _searchQuery = '';
                      _selectedFilter = 'All';
                    });
                    break;
                  case 'export':
                    _exportEntries(filteredEntries);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'clear_search',
                  child: Row(
                    children: [
                      Icon(Icons.clear),
                      SizedBox(width: 8),
                      Text('Clear Filters'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'export',
                  child: Row(
                    children: [
                      Icon(Icons.download),
                      SizedBox(width: 8),
                      Text('Export Data'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            // Search and Filter Section
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search metrics...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () =>
                                  setState(() => _searchQuery = ''),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                  const SizedBox(height: 12),
                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _filterOptions.map((filter) {
                        final isSelected = _selectedFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(filter),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedFilter = selected ? filter : 'All';
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Entries List
            Expanded(
              child: filteredEntries.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: filteredEntries.length,
                      itemBuilder: (context, index) {
                        final entry = filteredEntries[index];
                        return _buildEntryCard(entry, index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty || _selectedFilter != 'All'
                ? 'No entries match your filters'
                : 'No entries found in database',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey),
          ),
          if (_searchQuery.isNotEmpty || _selectedFilter != 'All')
            TextButton(
              onPressed: () => setState(() {
                _searchQuery = '';
                _selectedFilter = 'All';
              }),
              child: const Text('Clear filters'),
            ),
        ],
      ),
    );
  }

  Widget _buildEntryCard(dynamic entry, int index) {
    final metricName = _getMetricName(entry.metricId);
    final category = _getMetricCategory(entry.metricId);
    final time = entry.timestamp?.toLocal() ?? DateTime.now();
    final timeString =
        '${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getCategoryColor(category),
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          metricName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(
                color: _getCategoryColor(category),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              timeString,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (entry.booleanValue != null)
              Icon(
                entry.booleanValue ? Icons.check_circle : Icons.cancel,
                color: entry.booleanValue ? Colors.green : Colors.red,
                size: 20,
              ),
            if (entry.numericValue != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  entry.numericValue.toString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            if (entry.textValue != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  entry.textValue.toString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            const Icon(Icons.expand_more),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Metric ID', entry.metricId.toString()),
                _buildInfoRow('Timestamp', time.toString()),
                if (entry.booleanValue != null)
                  _buildInfoRow('Boolean Value', entry.booleanValue.toString()),
                if (entry.numericValue != null)
                  _buildInfoRow('Numeric Value', entry.numericValue.toString()),
                if (entry.textValue != null)
                  _buildInfoRow('Text Value', entry.textValue.toString()),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () => _copyEntry(entry),
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text('Copy'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: SelectableText(value)),
        ],
      ),
    );
  }

  String _getMetricName(int metricId) {
    // Map metric IDs to readable names
    const metricNames = {
      // Food Related
      1: 'Breakfast',
      2: 'Lunch',
      3: 'Snacks',
      4: 'Dinner',
      5: 'Coffee',
      6: 'Coke',
      7: 'Pepsi',
      8: 'Thumbs Up',
      9: 'Sprite',
      10: 'Mountain Dew',
      11: 'Fanta',
      12: 'Mirinda',
      13: 'Sting',
      14: 'Gold Sting',
      15: 'Blue Sting',
      16: 'Limca',
      17: 'Goli Soda',
      18: 'Jeera Soda',
      19: 'Arora Lemon',
      20: 'Nimbooz',
      21: 'Slice',
      22: 'Maaza',
      23: 'Frooti',
      24: 'Water',

      // Health Related
      100: 'Hand Washing',
      101: 'Shower',
      102: 'Brush Teeth',
      103: 'Poop',
      104: 'Pee',
      105: 'Momentum',
      106: 'Sleeping Time',
      107: 'Wake Up Time',
      108: 'Phone Screen Time',
      109: 'Laptop Screen Time',
      110: 'TV Screen Time',
      111: 'Screen Time Steps',
      112: 'Weight',

      // Productivity Related
      200: 'Problems Solved',
      201: 'Study',
      202: 'Projects Started',
      203: 'New Ideas',
      204: 'Classes Attended',
      205: 'Classes Missed',

      // Entertainment Related
      300: 'Gaming',
      301: 'Music',
      302: 'Movie',
      303: 'Series',
      304: 'Book',

      // Mood Related
      400: 'Mood',
      401: 'Happy',
      402: 'Sad',
      403: 'Angry',
      404: 'Excited',
      405: 'Relaxed',
      406: 'Anxious',
      407: 'Energy Level',
      408: 'Anxiety Level',
      409: 'Stress Level',

      // Finance Related
      500: 'Cash Spending',
      501: 'UPI Spending',

      // Travel Related
      600: 'Cities Visited',
      601: 'States Visited',
      602: 'Countries Visited',
      603: 'Train Travel',
      604: 'Flight Travel',
      605: 'Boat Travel',
      606: 'Car Travel',
      607: 'Bike Travel',
      608: 'Scooty Travel',
      609: 'Cycle Travel',
      610: 'Metro Travel',

      // Social Related
      700: 'Friends Met',
      701: 'Family Time',
      702: 'Colleagues Met',
      703: 'Relatives Met',
      704: 'Online Friends',
    };

    return metricNames[metricId] ?? 'Unknown Metric ($metricId)';
  }

  String _getMetricCategory(int metricId) {
    if (metricId >= 1 && metricId <= 99) return 'Food';
    if (metricId >= 100 && metricId <= 199) return 'Health';
    if (metricId >= 200 && metricId <= 299) return 'Productivity';
    if (metricId >= 300 && metricId <= 399) return 'Entertainment';
    if (metricId >= 400 && metricId <= 499) return 'Mood';
    if (metricId >= 500 && metricId <= 599) return 'Finance';
    if (metricId >= 600 && metricId <= 699) return 'Travel';
    if (metricId >= 700 && metricId <= 799) return 'Social';
    return 'Unknown';
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.orange;
      case 'Health':
        return Colors.green;
      case 'Productivity':
        return Colors.blue;
      case 'Entertainment':
        return Colors.purple;
      case 'Mood':
        return Colors.pink;
      case 'Finance':
        return Colors.teal;
      case 'Travel':
        return Colors.indigo;
      case 'Social':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _copyEntry(dynamic entry) {
    final text =
        '''
Metric: ${_getMetricName(entry.metricId)}
Category: ${_getMetricCategory(entry.metricId)}
Metric ID: ${entry.metricId}
Timestamp: ${entry.timestamp?.toLocal().toString() ?? 'Unknown'}
Boolean Value: ${entry.booleanValue}
Numeric Value: ${entry.numericValue}
Text Value: ${entry.textValue}
''';

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Entry copied to clipboard')));
  }

  void _copyAllEntries(List<dynamic> entries) {
    final text = entries
        .map(
          (entry) =>
              '''
${_getMetricName(entry.metricId)} | ${_getMetricCategory(entry.metricId)} | ID: ${entry.metricId} | ${entry.timestamp?.toLocal().toString() ?? 'Unknown'} | Boolean: ${entry.booleanValue} | Numeric: ${entry.numericValue} | Text: ${entry.textValue}
''',
        )
        .join('\n');

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${entries.length} entries copied to clipboard')),
    );
  }

  void _exportEntries(List<dynamic> entries) {
    // This would typically save to a file, but for now we'll copy CSV format
    final csv = [
      'Metric Name,Category,Metric ID,Timestamp,Boolean Value,Numeric Value,Text Value',
      ...entries.map(
        (entry) =>
            '"${_getMetricName(entry.metricId)}","${_getMetricCategory(entry.metricId)}",${entry.metricId},"${entry.timestamp?.toLocal().toString() ?? 'Unknown'}",${entry.booleanValue},${entry.numericValue},"${entry.textValue}"',
      ),
    ].join('\n');

    Clipboard.setData(ClipboardData(text: csv));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('CSV data copied to clipboard')),
    );
  }
}
