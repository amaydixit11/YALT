// lib/src/ui/widgets/today/hygiene_section.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/section_wrapper.dart';

class HygieneSection extends StatefulWidget {
  const HygieneSection({super.key});

  @override
  State<HygieneSection> createState() => _HygieneSectionState();
}

class _HygieneSectionState extends State<HygieneSection> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  
  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      title: 'Hygiene & Self Care',
      subtitle: 'Daily essentials',
      icon: Icons.spa_rounded,
      iconColor: Colors.pink,
      child: HygienePanel(
        onProgressUpdate: (progress) {
          _progressController.animateTo(progress);
        },
        progressAnimation: _progressAnimation,
      ),
    );
  }
}

class HygienePanel extends StatefulWidget {
  final Function(double) onProgressUpdate;
  final Animation<double> progressAnimation;

  const HygienePanel({
    super.key,
    required this.onProgressUpdate,
    required this.progressAnimation,
  });

  @override
  State<HygienePanel> createState() => _HygienePanelState();
}

class _HygienePanelState extends State<HygienePanel> {
  final List<Map<String, dynamic>> _hygieneItems = [
    {
      'name': 'Brush Teeth',
      'icon': Icons.brush_rounded,
      'color': Colors.blue,
      'completed': false,
    },
    {
      'name': 'Shower',
      'icon': Icons.shower_rounded,
      'color': Colors.teal,
      'completed': false,
    },
    {
      'name': 'Grooming',
      'icon': Icons.content_cut_rounded,
      'color': Colors.orange,
      'completed': false,
    },
  ];

  void _toggleItem(int index) {
    setState(() {
      _hygieneItems[index]['completed'] = !_hygieneItems[index]['completed'];
    });
    
    HapticFeedback.selectionClick();
    
    final completedCount = _hygieneItems.where((item) => item['completed'] as bool).length;
    final progress = completedCount / _hygieneItems.length;
    widget.onProgressUpdate(progress);
  }

  int get _completedCount => _hygieneItems.where((item) => item['completed'] as bool).length;
  double get _progressPercentage => _completedCount / _hygieneItems.length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Just the horizontal list of items
          _buildHorizontalItemsList(),
        ],
      ),
    );
  }

  Widget _buildCompactProgressHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade50, Colors.purple.shade50],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink.shade100, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Progress',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _progressPercentage >= 0.8 
                            ? Colors.green.shade100 
                            : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$_completedCount/${_hygieneItems.length}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _progressPercentage >= 0.8 
                              ? Colors.green.shade700 
                              : Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                AnimatedBuilder(
                  animation: widget.progressAnimation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: widget.progressAnimation.value * _progressPercentage,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _progressPercentage >= 0.8 ? Colors.green : Colors.pink,
                      ),
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(2),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalItemsList() {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _hygieneItems.length,
        separatorBuilder: (context, index) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final item = _hygieneItems[index];
          return CompactHygieneItem(
            name: item['name'] as String,
            icon: item['icon'] as IconData,
            color: item['color'] as Color,
            isCompleted: item['completed'] as bool,
            onTap: () => _toggleItem(index),
          );
        },
      ),
    );
  }

  Widget _buildCompactQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionButton(
            'Complete All',
            Icons.done_all_rounded,
            Colors.green,
            () {
              setState(() {
                for (var item in _hygieneItems) {
                  item['completed'] = true;
                }
              });
              widget.onProgressUpdate(1.0);
              HapticFeedback.mediumImpact();
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildQuickActionButton(
            'Reset',
            Icons.refresh_rounded,
            Colors.orange,
            () {
              setState(() {
                for (var item in _hygieneItems) {
                  item['completed'] = false;
                }
              });
              widget.onProgressUpdate(0.0);
              HapticFeedback.mediumImpact();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(String text, IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.2), width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompactHygieneItem extends StatefulWidget {
  final String name;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final VoidCallback onTap;

  const CompactHygieneItem({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  State<CompactHygieneItem> createState() => _CompactHygieneItemState();
}

class _CompactHygieneItemState extends State<CompactHygieneItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) => _animationController.forward(),
            onTapUp: (_) {
              _animationController.reverse();
              widget.onTap();
            },
            onTapCancel: () => _animationController.reverse(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 65,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: widget.isCompleted 
                    ? widget.color.withOpacity(0.15) 
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.isCompleted 
                      ? widget.color.withOpacity(0.3) 
                      : Colors.grey.shade200,
                  width: widget.isCompleted ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.isCompleted 
                        ? widget.color.withOpacity(0.1) 
                        : Colors.grey.withOpacity(0.05),
                    blurRadius: widget.isCompleted ? 4 : 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(
                            widget.isCompleted ? 0.2 : 0.15
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          widget.icon,
                          color: widget.color,
                          size: 18,
                        ),
                      ),
                      if (widget.isCompleted)
                        Positioned(
                          top: -2,
                          right: -2,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: widget.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: widget.isCompleted 
                          ? widget.color 
                          : Colors.grey.shade700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}