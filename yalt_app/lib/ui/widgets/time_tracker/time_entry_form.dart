import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';
import 'package:yalt_app/ui/widgets/common/time_picker_field.dart';
import 'package:yalt_app/ui/widgets/common/mood_slider.dart';
import 'package:yalt_app/ui/widgets/time_tracker/time_form_fields.dart';
import 'package:yalt_app/ui/widgets/time_tracker/form_error_message.dart';

class TimeEntryForm extends ConsumerWidget {
  final VoidCallback? onEntryAdded;

  const TimeEntryForm({
    super.key,
    this.onEntryAdded,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(timeTrackerFormProvider);
    final formNotifier = ref.read(timeTrackerFormProvider.notifier);

    return Container(
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
          
          // Form Fields
          TimeFormFields(
            formState: formState,
            formNotifier: formNotifier,
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
          FormErrorMessage(
            errorMessage: formState.errorMessage,
            onDismiss: formNotifier.clearError,
          ),
          
          // Submit Button
          _buildSubmitButton(formState, formNotifier),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(dynamic formState, dynamic formNotifier) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: formState.isLoading 
            ? null 
            : () async {
                final success = await formNotifier.submitEntry();
                if (success) {
                  onEntryAdded?.call();
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
    );
  }
}