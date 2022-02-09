import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_bloc.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_events.dart';
import 'package:stackly/services/analytics_helper.dart';
import 'package:sizer/sizer.dart';
import 'date_row_cubit.dart';

class DateRowView extends StatelessWidget {
  const DateRowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateRowCubit, DateTime>(
      builder: (BuildContext context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getSelectedDate(state),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 8.w,
              ),
            ),
            InkWell(
              onTap: () async {
                /// wait for date selection
                final DateTime? selected = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2010),
                  initialDate: state,
                  lastDate: DateTime.now().add(const Duration(days: 1)),
                );
                await context.read<DateRowCubit>().changeDate(selected!);
                context.read<SupsListBloc>().add(SupsListEventLoad(dateTime: selected));
                //logEvent(event: 'date_changed');
                /// check the selected date and act upon it to display matches and date text
                // if (selected != null && selected != selectedDate) {
                //   setState(() {
                //     /// update the selected date
                //     selectedDate = selected;
                //
                //     /// update the view model
                //     todayViewModel = TodayViewModel(today: selectedDate.toString().substring(0, 10));
                //
                //     /// refresh the match schedule based on the new selected date
                //     refreshDayDetails();
                //
                //
                //   });
                // }
              },
              child: Icon(
                Icons.calendar_today_outlined,
                size: 8.w,
              ),
            )
          ],
        );
      },
    );
  }
}

String getSelectedDate(DateTime selectedDate){
  /// change the selected date text based on the date
  if (selectedDate.toString().substring(0, 10) == DateTime.now().toString().substring(0, 10)) {
    logEvent(event: 'date_changed_today');
    return 'Today';
  } else if (selectedDate.toString().substring(0, 10) == DateTime.now().add(const Duration(days: 1)).toString().substring(0, 10)) {
    logEvent(event: 'date_changed_tomorrow');
    return 'Tomorrow';
  } else if (selectedDate.toString().substring(0, 10) == DateTime.now().subtract(const Duration(days: 1)).toString().substring(0, 10)) {
    logEvent(event: 'date_changed_yesterday');
    return 'Yesterday';
  } else {
    logEvent(event: 'date_changed_other');
    return DateFormat('yMMMMd').format(selectedDate);
  }
}