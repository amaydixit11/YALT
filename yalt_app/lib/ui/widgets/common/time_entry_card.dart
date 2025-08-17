import 'package:flutter/material.dart';
import 'package:yalt_app/core/entities/time_tracker_entity.dart';

class TimeEntryCard extends StatelessWidget {
  final TimeTrackerEntry entry;
  final VoidCallback? onTap;

  const TimeEntryCard({
    super.key,
    required this.entry,
    this.onTap,
  });

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDuration() {
    final duration = entry.endTime.difference(entry.startTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Color _getActivityColor() {
    if (entry.activity.toLowerCase() == 'blank') {
      return Colors.grey;
    }
    
    // Simple hash-based color generation
    final hash = entry.activity.hashCode;
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.amber,
    ];
    
    return colors[hash.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final activityColor = _getActivityColor();
    final isBlank = entry.activity.toLowerCase() == 'blank';
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: isBlank ? 1 : 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Time range indicator
              Container(
                width: 4,
                height: 50,
                decoration: BoxDecoration(
                  color: activityColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              
              // Main content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time range and duration
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_formatTime(entry.startTime)} - ${_formatTime(entry.endTime)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isBlank ? Colors.grey.shade600 : Colors.black87,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: activityColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _formatDuration(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: activityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    // Activity
                    Text(
                      entry.activity,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isBlank ? FontWeight.w400 : FontWeight.w600,
                        color: isBlank ? Colors.grey.shade600 : Colors.black87,
                        fontStyle: isBlank ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                    
                    // Sub-activity
                    if (entry.subActivity != null && entry.subActivity!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        entry.subActivity!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                    
                    // Additional info row
                    if (_hasAdditionalInfo()) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Group involved
                          if (entry.groupInvolved != null && entry.groupInvolved!.isNotEmpty)
                            _buildInfoChip(Icons.group, entry.groupInvolved!, Colors.blue),
                          
                          // People involved
                          if (entry.peopleInvolved != null && entry.peopleInvolved!.isNotEmpty) ...[
                            if (entry.groupInvolved != null && entry.groupInvolved!.isNotEmpty)
                              const SizedBox(width: 8),
                            _buildInfoChip(Icons.person, entry.peopleInvolved!, Colors.green),
                          ],
                          
                          // Mood
                          if (entry.mood != null) ...[
                            if (_hasGroupOrPeople())
                              const SizedBox(width: 8),
                            _buildMoodChip(entry.mood!),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  bool _hasAdditionalInfo() {
    return (entry.groupInvolved != null && entry.groupInvolved!.isNotEmpty) ||
           (entry.peopleInvolved != null && entry.peopleInvolved!.isNotEmpty) ||
           entry.mood != null;
  }
  
  bool _hasGroupOrPeople() {
    return (entry.groupInvolved != null && entry.groupInvolved!.isNotEmpty) ||
           (entry.peopleInvolved != null && entry.peopleInvolved!.isNotEmpty);
  }
  
  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMoodChip(int mood) {
    Color moodColor;
    if (mood >= 75) {
      moodColor = Colors.green;
    } else if (mood >= 50) {
      moodColor = Colors.orange;
    } else {
      moodColor = Colors.red;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: moodColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.mood, size: 14, color: moodColor),
          const SizedBox(width: 4),
          Text(
            mood.toString(),
            style: TextStyle(
              fontSize: 12,
              color: moodColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}