import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dashboard/dashboard_screen.dart';
import '../history/history_screen.dart';
import '../stats/stats_screen.dart';
import '../settings/settings_screen.dart';
import '../add_entry/add_entry_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const HistoryScreen(),
    const StatsScreen(),
    const SettingsScreen(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      outlinedIcon: Icons.dashboard_outlined,
      filledIcon: Icons.dashboard_rounded,
      label: 'Dashboard',
      color: Colors.blue,
    ),
    NavigationItem(
      outlinedIcon: Icons.history_outlined,
      filledIcon: Icons.history_rounded,
      label: 'History',
      color: Colors.green,
    ),
    NavigationItem(
      outlinedIcon: Icons.bar_chart_outlined,
      filledIcon: Icons.bar_chart_rounded,
      label: 'Stats',
      color: Colors.purple,
    ),
    NavigationItem(
      outlinedIcon: Icons.settings_outlined,
      filledIcon: Icons.settings_rounded,
      label: 'Settings',
      color: Colors.orange,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fabScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: _buildEnhancedFAB(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildEnhancedBottomNavBar(context),
    );
  }

  Widget _buildEnhancedFAB(BuildContext context) {
    return ScaleTransition(
      scale: _fabScaleAnimation,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: FloatingActionButton.large(
          onPressed: () {
            _fabAnimationController.forward().then((_) {
              _fabAnimationController.reverse();
            });
            
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const AddEntryScreen(),
                fullscreenDialog: true,
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    )),
                    child: child,
                  );
                },
              ),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ],
              ),
            ),
            child: const Icon(
              Icons.add_rounded,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedBottomNavBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 60,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BottomAppBar(
          height: 80,
          color: Colors.transparent,
          elevation: 0,
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ..._navigationItems.take(2).toList().asMap().entries.map(
                  (entry) => _buildEnhancedNavItem(
                    context,
                    _navigationItems[entry.key],
                    entry.key,
                  ),
                ),
                const SizedBox(width: 64), // Space for FAB
                ..._navigationItems.skip(2).toList().asMap().entries.map(
                  (entry) => _buildEnhancedNavItem(
                    context,
                    _navigationItems[entry.key + 2],
                    entry.key + 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedNavItem(BuildContext context, NavigationItem item, int index) {
    final isSelected = _currentIndex == index;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (_currentIndex != index) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected 
                  ? item.color.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: isSelected 
                  ? Border.all(color: item.color.withOpacity(0.3), width: 1)
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isSelected ? item.filledIcon : item.outlinedIcon,
                    key: ValueKey(isSelected),
                    color: isSelected 
                        ? item.color
                        : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected 
                        ? item.color
                        : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  child: Text(item.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData outlinedIcon;
  final IconData filledIcon;
  final String label;
  final Color color;

  NavigationItem({
    required this.outlinedIcon,
    required this.filledIcon,
    required this.label,
    required this.color,
  });
}