import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/daily_log.dart';
import '../../models/milestone.dart';
import '../../models/custom_counter.dart';
import '../../data/repository.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../widgets/mood_selector.dart';
import '../../widgets/energy_selector.dart';

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({super.key});

  @override
  ConsumerState<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends ConsumerState<AddEntryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  
  // Daily Log form
  int _mood = 0;
  int _energy = 0;
  double _sleepHours = 8.0;
  int _waterCups = 0;
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  
  // Milestone form
  final _milestoneController = TextEditingController();
  final _milestoneNoteController = TextEditingController();
  DateTime _milestoneDate = DateTime.now();
  
  // Counter form
  final _counterNameController = TextEditingController();
  final _counterUnitController = TextEditingController();
  double _counterStep = 1.0;
  bool _dailyReset = false;
  int _selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadTodayData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _noteController.dispose();
    _milestoneController.dispose();
    _milestoneNoteController.dispose();
    _counterNameController.dispose();
    _counterUnitController.dispose();
    super.dispose();
  }

  Future<void> _loadTodayData() async {
    final repository = ref.read(repositoryProvider);
    final todayLog = await repository.getTodayLog();
    
    if (todayLog != null) {
      setState(() {
        _mood = todayLog.mood;
        _energy = todayLog.energy;
        _sleepHours = todayLog.sleepHours;
        _waterCups = todayLog.waterCups;
        _noteController.text = todayLog.note ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Entry'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Daily Log'),
            Tab(text: 'Milestone'),
            Tab(text: 'Counter'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDailyLogForm(),
          _buildMilestoneForm(),
          _buildCounterForm(),
        ],
      ),
    );
  }

  Widget _buildDailyLogForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date selector
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Date'),
              subtitle: Text(date_utils.DateUtils.formatDateLong(_selectedDate)),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                }
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Mood
          Text(
            'Mood',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          MoodSelector(
            selectedMood: _mood,
            onMoodSelected: (mood) {
              setState(() {
                _mood = mood;
              });
            },
          ),
          
          const SizedBox(height: 24),
          
          // Energy
          Text(
            'Energy',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          EnergySelector(
            selectedEnergy: _energy,
            onEnergySelected: (energy) {
              setState(() {
                _energy = energy;
              });
            },
          ),
          
          const SizedBox(height: 24),
          
          // Sleep
          Text(
            'Sleep Hours',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.bedtime),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Slider(
                      value: _sleepHours,
                      min: 0,
                      max: 12,
                      divisions: 24,
                      label: '${_sleepHours.toStringAsFixed(1)} hrs',
                      onChanged: (value) {
                        setState(() {
                          _sleepHours = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    '${_sleepHours.toStringAsFixed(1)} hrs',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Water
          Text(
            'Water Intake',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.local_drink),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: _waterCups > 0 ? () {
                      setState(() {
                        _waterCups--;
                      });
                    } : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Expanded(
                    child: Text(
                      '$_waterCups cups',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _waterCups++;
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Note
          Text(
            'Note (Optional)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              hintText: 'How was your day?',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          
          const SizedBox(height: 32),
          
          // Save button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveDailyLog,
              child: const Text('Save Daily Log'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _milestoneController,
            decoration: const InputDecoration(
              labelText: 'Milestone Title',
              hintText: 'e.g., Graduated from college',
              border: OutlineInputBorder(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Date'),
              subtitle: Text(date_utils.DateUtils.formatDateLong(_milestoneDate)),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _milestoneDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() {
                    _milestoneDate = date;
                  });
                }
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          TextField(
            controller: _milestoneNoteController,
            decoration: const InputDecoration(
              labelText: 'Note (Optional)',
              hintText: 'Additional details...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveMilestone,
              child: const Text('Save Milestone'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _counterNameController,
            decoration: const InputDecoration(
              labelText: 'Counter Name',
              hintText: 'e.g., Books Read, Coffee Cups',
              border: OutlineInputBorder(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          TextField(
            controller: _counterUnitController,
            decoration: const InputDecoration(
              labelText: 'Unit',
              hintText: 'e.g., books, cups, hours',
              border: OutlineInputBorder(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Increment Step: ${_counterStep.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Slider(
            value: _counterStep,
            min: 0.1,
            max: 10.0,
            divisions: 99,
            onChanged: (value) {
              setState(() {
                _counterStep = value;
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          SwitchListTile(
            title: const Text('Reset Daily'),
            subtitle: const Text('Counter resets to 0 each day'),
            value: _dailyReset,
            onChanged: (value) {
              setState(() {
                _dailyReset = value;
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Color',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: AppConstants.counterColors.asMap().entries.map((entry) {
              final index = entry.key;
              final color = entry.value;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColorIndex = index;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: _selectedColorIndex == index
                        ? Border.all(color: Colors.black, width: 3)
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveCounter,
              child: const Text('Create Counter'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveDailyLog() async {
    final repository = ref.read(repositoryProvider);
    
    final log = DailyLog(
      id: const Uuid().v4(),
      date: date_utils.DateUtils.normalizeToLocalDate(_selectedDate),
      mood: _mood,
      energy: _energy,
      sleepHours: _sleepHours,
      waterCups: _waterCups,
      customCounters: {},
      note: _noteController.text.isEmpty ? null : _noteController.text,
      updatedAt: DateTime.now(),
    );
    
    await repository.saveDailyLog(log);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Daily log saved!')),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> _saveMilestone() async {
    if (_milestoneController.text.isEmpty) return;
    
    final repository = ref.read(repositoryProvider);
    
    final milestone = Milestone(
      id: const Uuid().v4(),
      title: _milestoneController.text,
      date: _milestoneDate,
      note: _milestoneNoteController.text.isEmpty ? null : _milestoneNoteController.text,
      createdAt: DateTime.now(),
    );
    
    await repository.saveMilestone(milestone);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Milestone saved!')),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> _saveCounter() async {
    if (_counterNameController.text.isEmpty) return;
    
    final repository = ref.read(repositoryProvider);
    
    final counter = CustomCounter(
      id: const Uuid().v4(),
      name: _counterNameController.text,
      unit: _counterUnitController.text.isEmpty ? 'count' : _counterUnitController.text,
      step: _counterStep,
      dailyReset: _dailyReset,
      colorIndex: _selectedColorIndex,
    );
    
    await repository.saveCounter(counter);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Counter created!')),
      );
      Navigator.of(context).pop();
    }
  }
}