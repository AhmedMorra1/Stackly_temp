import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/features/new_page/new_page_event.dart';
import 'package:stackly/features/new_page/new_page_state.dart';
import 'package:stackly/features/today_page/date_row/date_row_cubit.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_bloc.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_events.dart';
import 'package:stackly/services/analytics_helper.dart';

import '../new_page_bloc.dart';

class SaveCancelRow extends StatelessWidget {
  const SaveCancelRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPageBloc, NewPageState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context.read<NewPageBloc>().add(CancelNew());
                    logEvent(event: 'new_canceled');
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 12.w,
                    width: 42.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(
                        width: .3,
                        color: Colors.redAccent,
                      ),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 6.w),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()  {
                    context.read<NewPageBloc>().add(SaveNew());
                  },
                  child: Container(
                    height: 12.w,
                    width: 42.w,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade400,
                      border: Border.all(
                        width: .3,
                        color: const Color(0xFF000000),
                      ),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 6.w, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.w),
          ],
        );
      },
    );
  }
}
