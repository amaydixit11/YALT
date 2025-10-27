import 'package:flutter/material.dart';
import 'package:yalt_app/ui/widgets/common/custom_text_field.dart';

class TimeFormFields extends StatelessWidget {
  final dynamic formState;
  final dynamic formNotifier;

  const TimeFormFields({
    super.key,
    required this.formState,
    required this.formNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Activity Field
        CustomTextField(
          label: "Activity *",
          value: formState.activity,
          onChanged: formNotifier.setActivity,
          hintText: "What were you doing?",
        ),
        const SizedBox(height: 12),
        
        // Sub-activity Field
        CustomTextField(
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
              child: CustomTextField(
                label: "Group",
                value: formState.groupInvolved,
                onChanged: formNotifier.setGroupInvolved,
                hintText: "Team, family, etc.",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                label: "People",
                value: formState.peopleInvolved,
                onChanged: formNotifier.setPeopleInvolved,
                hintText: "Names of people",
              ),
            ),
          ],
        ),
      ],
    );
  }
}