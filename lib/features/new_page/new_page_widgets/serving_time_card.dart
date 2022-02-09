import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/features/new_page/new_page_event.dart';
import 'package:stackly/features/new_page/new_page_state.dart';
import 'package:stackly/services/analytics_helper.dart';

import '../new_page_bloc.dart';

class ServingTimeCard extends StatelessWidget {
  const ServingTimeCard({Key? key, required this.servingTime}) : super(key: key);
  final String servingTime;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPageBloc, NewPageState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 1.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 10.w,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: .3,
                    color: const Color(0xFF000000),
                  ),
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Center(
                  child: Text(
                    servingTime,
                    style: TextStyle(fontSize: 4.5.w),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<NewPageBloc>().add(RemoveServingTime(servingTime: servingTime));
                  logEvent(event: 'deleted_time');
                },
                child: const Icon(Icons.delete_forever_rounded),
              ),
            ],
          ),
        );
      },
    );
  }
}
