// lib/src/ui/widgets/common/main_layout_widget.dart
import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class MainLayoutWidget extends StatefulWidget {
  final List<Widget> pages;
  final int initialIndex;
  final List<String> pageTitles;
  final bool showAppBar;
  final List<Widget>? appBarActions;

  const MainLayoutWidget({
    super.key,
    required this.pages,
    this.initialIndex = 0,
    required this.pageTitles,
    this.showAppBar = true,
    this.appBarActions,
  });

  @override
  State<MainLayoutWidget> createState() => _MainLayoutWidgetState();
}

class _MainLayoutWidgetState extends State<MainLayoutWidget> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavTap(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: widget.showAppBar ? _buildAppBar(theme) : null,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: widget.pages,
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      title: Text(
        widget.pageTitles[_currentIndex],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: theme.colorScheme.onSurface,
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: false,
      actions: widget.appBarActions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: theme.colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
    );
  }
}