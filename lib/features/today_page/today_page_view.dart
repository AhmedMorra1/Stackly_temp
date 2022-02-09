import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackly/configs/consts.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_bloc.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_events.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_states.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_views/sups_list_view.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_views/sups_list_view_empty.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_views/sups_list_view_error.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_views/sups_list_view_loading.dart';
import 'date_row/date_row_cubit.dart';
import 'date_row/date_row_view.dart';

class TodayPageView extends StatelessWidget {
  const TodayPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: BlocConsumer<SupsListBloc, SupsListState>(
            listener: (BuildContext context, state){
            },
            builder: (BuildContext context, state) {
              return Column(
                children: [
                  const DateRowView(),
                  SizedBox(height: 5.h,),
                  state.status.isInitial ? const SubsListViewEmpty()
                  : (state.status.isLoading ? const SupsListViewLoading()
                  : (state.status.isError ? const SupsListViewError()
                  : SubsListView(subsList: state.supsList,)))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
