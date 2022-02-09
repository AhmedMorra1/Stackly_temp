import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackly/configs/consts.dart';
import 'package:stackly/features/stack_page/stack_page_bloc.dart';
import 'package:stackly/features/stack_page/stack_page_event.dart';
import 'package:stackly/features/stack_page/stack_page_view.dart';
import 'package:stackly/features/today_page/date_row/date_row_cubit.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_bloc.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_events.dart';
import 'package:stackly/features/today_page/today_page_view.dart';
import 'bottom_bar_cubit.dart';

class BottomNavigatorView extends StatelessWidget {
  const BottomNavigatorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomAppBarCubit, int>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state,
            children: const [
              TodayPageView(),
              StackPageView(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              _bottomNavigationBarItem(icon: Icons.event_note, label: 'Today'),
              _bottomNavigationBarItem(icon: Icons.emoji_events, label: 'Stack'),
            ],
            onTap: (index) {
              context.read<BottomAppBarCubit>().changeTab(index);
              if (index == 0) {
                context.read<SupsListBloc>().add(SupsListEventLoad(dateTime: context.read<DateRowCubit>().state));
              } else if (index == 1) {
                context.read<StackPageBloc>().add(StackPageEventLoad());
              }
            },
            currentIndex: state,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            elevation: 1,
            backgroundColor: kBackGroundColor,
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
