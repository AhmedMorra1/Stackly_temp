import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/services/analytics_helper.dart';

import '../edit_page_bloc.dart';
import '../edit_page_event.dart';
import '../edit_page_state.dart';

class SaveCancelRow extends StatelessWidget {
  const SaveCancelRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPageBloc, EditPageState>(
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
                    context.read<EditPageBloc>().add(CancelEdit());
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
                    context.read<EditPageBloc>().add(SaveEdit());
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
