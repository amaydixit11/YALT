import 'package:flutter/material.dart';
import 'today_screen.dart';
import 'lifetime_screen.dart';
import 'time_tracker_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "YALT",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.today), text: "Today"),
            Tab(icon: Icon(Icons.timeline), text: "Lifetime"),
            // Tab(icon: Icon(Icons.access_time), text: "Time Tracker"),
          ],
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorWeight: 3,
          isScrollable: false,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TodayScreen(), LifetimeScreen(),
          // TimeTrackerScreen()
        ],
      ),
    );
  }
}
