import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../viewmodels/stats_viewmodel.dart';
import '../../core/constants/app_constants.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  String _selectedMetric = 'mood';
  int _selectedDays = 30;

  @override
  Widget build(BuildContext context) {
    final statsState = ref.watch(statsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'export_csv') {
                ref.read(statsViewModelProvider.notifier).exportCSV(_selectedMetric);
              } else if (value == 'fun_fact') {
                ref.read(statsViewModelProvider.notifier).generateFunFact();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export_csv',
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 8),
                    Text('Export CSV'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'fun_fact',
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline),
                    SizedBox(width: 8),
                    Text('Generate Fun Fact'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: statsState.when(
        data: (state) => _buildStatsContent(context, state),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading stats: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(statsViewModelProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsContent(BuildContext context, StatsState state) {
    return Column(
      children: [
        // Metric selector
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedMetric,
                  decoration: const InputDecoration(
                    labelText: 'Metric',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'mood', child: Text('Mood')),
                    DropdownMenuItem(value: 'energy', child: Text('Energy')),
                    DropdownMenuItem(value: 'sleep', child: Text('Sleep')),
                    DropdownMenuItem(value: 'water', child: Text('Water')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedMetric = value;
                      });
                      ref.read(statsViewModelProvider.notifier).updateMetric(value, _selectedDays);
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _selectedDays,
                  decoration: const InputDecoration(
                    labelText: 'Period',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 7, child: Text('7 days')),
                    DropdownMenuItem(value: 30, child: Text('30 days')),
                    DropdownMenuItem(value: 90, child: Text('90 days')),
                    DropdownMenuItem(value: 365, child: Text('1 year')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedDays = value;
                      });
                      ref.read(statsViewModelProvider.notifier).updateMetric(_selectedMetric, value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        
        // Chart
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildChart(state),
              ),
            ),
          ),
        ),
        
        // Summary stats
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildSummaryStats(context, state),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChart(StatsState state) {
    if (state.chartData.isEmpty) {
      return const Center(
        child: Text('No data available for selected period'),
      );
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < state.chartData.length) {
                  final date = state.chartData[index].date;
                  return Text(
                    '${date.day}',
                    style: const TextStyle(fontSize: 12),
                  );
                }
                return const Text('');
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: state.chartData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value.value);
            }).toList(),
            isCurved: true,
            color: const Color(0xFF0891B2),
            barWidth: 3,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF0891B2).withOpacity(0.1),
            ),
          ),
        ],
        minY: 0,
        maxY: _getMaxY(_selectedMetric),
      ),
    );
  }

  double _getMaxY(String metric) {
    switch (metric) {
      case 'mood':
      case 'energy':
        return 5;
      case 'sleep':
        return 12;
      case 'water':
        return 15;
      default:
        return 10;
    }
  }

  Widget _buildSummaryStats(BuildContext context, StatsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard('Average', state.average.toStringAsFixed(1)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard('Best Day', state.bestValue.toStringAsFixed(1)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard('Total Days', state.totalDays.toString()),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard('Logged Days', state.loggedDays.toString()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}