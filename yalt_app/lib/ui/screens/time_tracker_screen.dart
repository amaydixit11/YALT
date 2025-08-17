import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';
import 'package:yalt_app/ui/widgets/common/time_picker_field.dart';
import 'package:yalt_app/ui/widgets/common/mood_slider.dart';
import 'package:yalt_app/ui/widgets/common/time_entry_card.dart';

class TimeTrackerScreen extends ConsumerWidget {
  const TimeTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(timeTrackerFormProvider);
    final formNotifier = ref.read(timeTrackerFormProvider.notifier);
    final today = DateTime.now();
    final timeEntries = ref.watch(timeEntriesProvider(today));

    return Scaffold(
      body: Column(
        children: [
          // Form Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Time Entry",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Time Pickers Row
                Row(
                  children: [
                    Expanded(
                      child: TimePickerField(
                        label: "From",
                        selectedTime: formState.startTime,
                        onTimeSelected: formNotifier.setStartTime,
                        isRequired: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TimePickerField(
                        label: "To",
                        selectedTime: formState.endTime,
                        onTimeSelected: formNotifier.setEndTime,
                        isRequired: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Activity Field
                _buildTextField(
                  label: "Activity *",
                  value: formState.activity,
                  onChanged: formNotifier.setActivity,
                  hintText: "What were you doing?",
                ),
                const SizedBox(height: 12),
                
                // Sub-activity Field
                _buildTextField(
                  label: "Sub-activity",
                  value: formState.subActivity,
                  onChanged: formNotifier.setSubActivity,
                  hintText: "More specific details (optional)",
                ),
                const SizedBox(height: 12),
                
                // Group and People Row
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: "Group",
                        value: formState.groupInvolved,
                        onChanged: formNotifier.setGroupInvolved,
                        hintText: "Team, family, etc.",
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        label: "People",
                        value: formState.peopleInvolved,
                        onChanged: formNotifier.setPeopleInvolved,
                        hintText: "Names of people",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Mood Slider
                MoodSlider(
                  label: "Mood (0-100)",
                  value: formState.mood,
                  onChanged: formNotifier.setMood,
                ),
                const SizedBox(height: 16),
                
                // Error Message
                if (formState.errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.red.shade700, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            formState.errorMessage!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red.shade700, size: 16),
                          onPressed: formNotifier.clearError,
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: formState.isLoading 
                        ? null 
                        : () async {
                            final success = await formNotifier.submitEntry();
                            if (success) {
                              // Refresh the time entries
                              ref.invalidate(timeEntriesProvider(today));
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: formState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            "Add Entry",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          
          // Entries List Section
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Today's Entries",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  Expanded(
                    child: timeEntries.when(
                      data: (entries) {
                        if (entries.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "No entries yet today",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Add your first time entry above",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        
                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 16),
                          itemCount: entries.length,
                          itemBuilder: (context, index) {
                            return TimeEntryCard(
                              entry: entries[index],
                              onTap: () {
                                // TODO: Implement edit functionality
                              },
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Error loading entries",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              error.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextField({
    required String label,
    required String value,
    required Function(String) onChanged,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: TextEditingController(text: value)..selection = TextSelection.collapsed(offset: value.length),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
        ),
      ],
    );
  }
}