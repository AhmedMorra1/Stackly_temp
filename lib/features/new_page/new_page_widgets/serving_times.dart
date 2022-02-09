import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/features/new_page/new_page_event.dart';
import 'package:stackly/features/new_page/new_page_state.dart';
import 'package:stackly/features/new_page/new_page_widgets/serving_time_card.dart';
import 'package:stackly/services/analytics_helper.dart';


import '../new_page_bloc.dart';

class ServingTimesList extends StatelessWidget {
  const ServingTimesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPageBloc, NewPageState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Serving Times',
              style: TextStyle(
                fontSize: 5.w,
              ),
            ),
            SizedBox(height: 2.w),
            Column(
              children: state.supplement.servingTimes!
                  .map((e) => ServingTimeCard(
                servingTime: e,
              ))
                  .toList(),
            ),
            SizedBox(height: 1.w),
            InkWell(
              onTap: () async {
                await Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: TimeOfDay.now(),
                    onChange: (date) {
                      context.read<NewPageBloc>().add(AddServingTime(servingTime: date.format(context).toString()));
                      logEvent(event: 'time_added');
                    },
                  ),
                );
              },
              child: Container(
                height: 10.w,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(
                    width: .3,
                    color: const Color(0xFF000000),
                  ),
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Center(
                  child: Text(
                    'Add Time',
                    style: TextStyle(fontSize: 4.5.w),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.w),
          ],
        );
      },
    );
  }
}
