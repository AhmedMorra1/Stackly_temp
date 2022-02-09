import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/features/new_page/new_page_event.dart';
import 'package:stackly/features/new_page/new_page_state.dart';
import 'package:stackly/services/analytics_helper.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../new_page_bloc.dart';

class InstructionPicker extends StatelessWidget {
  const InstructionPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPageBloc, NewPageState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        List<String> labels = ['With Food', 'On Empty Stomach'];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instructions',
              style: TextStyle(
                fontSize: 5.w,
              ),
            ),
            SizedBox(height: 2.w),
            ToggleSwitch(
              minWidth: 44.5.w,
              minHeight: 10.w,
              initialLabelIndex: labels.indexOf(state.supplement.instructions!),
              totalSwitches: 2,
              labels: labels,
              onToggle: (index) {
                context.read<NewPageBloc>().add(InstructionsChanged(instruction: labels[index]));
                logEvent(event: 'instruction_picked_${labels[index]}');
              },
            ),
            SizedBox(height: 4.w),
          ],
        );
      },
    );
  }
}
