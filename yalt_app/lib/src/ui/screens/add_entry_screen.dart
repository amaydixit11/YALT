// lib/src/ui/screens/add_entry_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/common/quick_add_button.dart';
import '../widgets/common/section_header.dart';

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({super.key});

  @override
  ConsumerState<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends ConsumerState<AddEntryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedTracker;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _selectTracker(String trackerId) {
    setState(() {
      _selectedTracker = trackerId;
    });
    
    // Add haptic feedback
    // HapticFeedback.selectionClick();
    
    // TODO: Add the selected value to your data store
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $trackerId'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        // Tab Bar
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Daily', icon: Icon(Icons.today, size: 20)),
              Tab(text: 'Lifetime', icon: Icon(Icons.all_inclusive, size: 20)),
              Tab(text: 'Fun', icon: Icon(Icons.sentiment_very_satisfied, size: 20)),
            ],
          ),
        ),
        
        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDailyTab(),
              _buildLifetimeTab(),
              _buildFunTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SectionHeaderWidget(
            title: 'Hydration 💧',
            subtitle: 'Track your water intake',
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: QuickAddGridWidget(
              buttons: [
                QuickAddButtonWidget(
                  label: 'Small glass',
                  icon: Icons.local_drink_outlined,
                  value: '+250ml',
                  color: Colors.blue,
                  onTap: () => _selectTracker('water_250'),
                  isSelected: _selectedTracker == 'water_250',
                ),
                QuickAddButtonWidget(
                  label: 'Water bottle',
                  icon: Icons.sports_bar_outlined,
                  value: '+500ml',
                  color: Colors.blue,
                  onTap: () => _selectTracker('water_500'),
                  isSelected: _selectedTracker == 'water_500',
                ),
                QuickAddButtonWidget(
                  label: 'Large bottle',
                  icon: Icons.local_drink,
                  value: '+1L',
                  color: Colors.blue,
                  onTap: () => _selectTracker('water_1000'),
                  isSelected: _selectedTracker == 'water_1000',
                ),
              ],
            ),
          ),
          
          const SectionHeaderWidget(
            title: 'Reading 📚',
            subtitle: 'Log your reading progress',
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: QuickAddGridWidget(
              buttons: [
                QuickAddButtonWidget(
                  label: 'Quick read',
                  icon: Icons.book_outlined,
                  value: '+5 pages',
                  color: Colors.green,
                  onTap: () => _selectTracker('reading_5'),
                  isSelected: _selectedTracker == 'reading_5',
                ),
                QuickAddButtonWidget(
                  label: 'Good session',
                  icon: Icons.book,
                  value: '+20 pages',
                  color: Colors.green,
                  onTap: () => _selectTracker('reading_20'),
                  isSelected: _selectedTracker == 'reading_20',
                ),
                QuickAddButtonWidget(
                  label: 'Long read',
                  icon: Icons.menu_book,
                  value: '+50 pages',
                  color: Colors.green,
                  onTap: () => _selectTracker('reading_50'),
                  isSelected: _selectedTracker == 'reading_50',
                ),
              ],
            ),
          ),
          
          const SectionHeaderWidget(
            title: 'Exercise 💪',
            subtitle: 'Track your workout time',
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: QuickAddGridWidget(
              buttons: [
                QuickAddButtonWidget(
                  label: 'Quick workout',
                  icon: Icons.timer_outlined,
                  value: '+15 min',
                  color: Colors.orange,
                  onTap: () => _selectTracker('exercise_15'),
                  isSelected: _selectedTracker == 'exercise_15',
                ),
                QuickAddButtonWidget(
                  label: 'Full workout',
                  icon: Icons.fitness_center,
                  value: '+45 min',
                  color: Colors.orange,
                  onTap: () => _selectTracker('exercise_45'),
                  isSelected: _selectedTracker == 'exercise_45',
                ),
                QuickAddButtonWidget(
                  label: 'Long session',
                  icon: Icons.sports_gymnastics,
                  value: '+90 min',
                  color: Colors.orange,
                  onTap: () => _selectTracker('exercise_90'),
                  isSelected: _selectedTracker == 'exercise_90',
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildLifetimeTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SectionHeaderWidget(
            title: 'Entertainment 🎬',
            subtitle: 'Books, movies, and shows',
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: QuickAddGridWidget(
              buttons: [
                QuickAddButtonWidget(
                  label: 'Finished book',
                  icon: Icons.book,
                  value: '+1 Book',
                  color: Colors.purple,
                  onTap: () => _selectTracker('books_1'),
                  isSelected: _selectedTracker == 'books_1',
                ),
                QuickAddButtonWidget(
                  label: 'Watched movie',
                  icon: Icons.movie,
                  value: '+1 Movie',
                  color: Colors.red,
                  onTap: () => _selectTracker('movies_1'),
                  isSelected: _selectedTracker == 'movies_1',
                ),
                QuickAddButtonWidget(
                  label: 'TV episode',
                  icon: Icons.tv,
                  value: '+1 Episode',
                  color: Colors.indigo,
                  onTap: () => _selectTracker('episodes_1'),
                  isSelected: _selectedTracker == 'episodes_1',
                ),
              ],
            ),
          ),
          
          const SectionHeaderWidget(
            title: 'Learning 🎓',
            subtitle: 'Track your growth',
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: QuickAddGridWidget(
              buttons: [
                QuickAddButtonWidget(
                  label: 'Coding problem',
                  icon: Icons.code,
                  value: '+1 Solved',
                  color: Colors.blue,
                  onTap: () => _selectTracker('coding_1'),
                  isSelected: _selectedTracker == 'coding_1',
                ),
                QuickAddButtonWidget(
                  label: 'Course hour',
                  icon: Icons.school,
                  value: '+1 Hour',
                  color: Colors.teal,
                  onTap: () => _selectTracker('learning_1'),
                  isSelected: _selectedTracker == 'learning_1',
                ),
                QuickAddButtonWidget(
                  label: 'New skill',
                  icon: Icons.lightbulb,
                  value: '+1 Skill',
                  color: Colors.amber,
                  onTap: () => _selectTracker('skills_1'),
                  isSelected: _selectedTracker == 'skills_1',
                ),
              ],
            ),
          ),
          
          const SectionHeaderWidget(
            title: 'Social & Travel 🌍',
            subtitle: 'Experiences and connections',
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: QuickAddGridWidget(
              buttons: [
                QuickAddButtonWidget(
                  label: 'New place',
                  icon: Icons.place,
                  value: '+1 Visited',
                  color: Colors.green,
                  onTap: () => _selectTracker('places_1'),
                  isSelected: _selectedTracker == 'places_1',
                ),
                QuickAddButtonWidget(
                  label: 'New friend',
                  icon: Icons.person_add,
                  value: '+1 Friend',
                  color: Colors.pink,
                  onTap: () => _selectTracker('friends_1'),
                  isSelected: _selectedTracker == 'friends_1',
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildFunTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SectionHeaderWidget(
            title: 'Social Fun 😄',
            subtitle: 'Because life should be fun!',
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: QuickAddGridWidget(
              buttons: [
                QuickAddButtonWidget(
                  label: 'Meme shared',
                  icon: Icons.face,
                  value: '+1 Meme',
                  color: Colors.pink,
                  onTap: () => _selectTracker('memes_1'),
                  isSelected: _selectedTracker == 'memes_1',
                ),
                QuickAddButtonWidget(
                  label: 'Good laugh',
                  icon: Icons.sentiment_very_satisfied,
                  value: '+1 Laugh',
                  color: Colors.orange,
                  onTap: () => _selectTracker('laughs_1'),
                  isSelected: _selectedTracker == 'laughs_1',
                ),
                QuickAddButtonWidget(
                  label: 'Dad joke',
                  icon: Icons.psychology,
                  value: '+1 Pun',
                  color: Colors.amber,
                  onTap: () => _selectTracker('puns_1'),
                  isSelected: _selectedTracker == 'puns_1',
                ),
              ],
            ),
          ),
          
          const SectionHeaderWidget(
            title: 'Random Acts 🎲',
            subtitle: 'The little things that matter',
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: QuickAddGridWidget(
              buttons: [
                QuickAddButtonWidget(
                  label: 'Pet an animal',
                  icon: Icons.pets,
                  value: '+1 Pet',
                  color: Colors.brown,
                  onTap: () => _selectTracker('pets_1'),
                  isSelected: _selectedTracker == 'pets_1',
                ),
                QuickAddButtonWidget(
                  label: 'Random selfie',
                  icon: Icons.camera_alt,
                  value: '+1 Selfie',
                  color: Colors.purple,
                  onTap: () => _selectTracker('selfies_1'),
                  isSelected: _selectedTracker == 'selfies_1',
                ),
                QuickAddButtonWidget(
                  label: 'Wikipedia hole',
                  icon: Icons.circle,
                  value: '+1 Rabbit Hole',
                  color: Colors.blue,
                  onTap: () => _selectTracker('wikipedia_1'),
                  isSelected: _selectedTracker == 'wikipedia_1',
                ),
                QuickAddButtonWidget(
                  label: 'Said "I\'m tired"',
                  icon: Icons.bedtime,
                  value: '+1 Tired',
                  color: Colors.grey,
                  onTap: () => _selectTracker('tired_1'),
                  isSelected: _selectedTracker == 'tired_1',
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}