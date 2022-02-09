import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/features/new_page/new_page_view.dart';
import 'package:stackly/features/stack_page/stack_page_bloc.dart';
import 'package:stackly/features/stack_page/stack_page_event.dart';
import 'package:stackly/features/stack_page/stack_page_state.dart';
import 'package:stackly/features/stack_page/stack_page_views/stack_list_initial.dart';
import 'package:stackly/features/stack_page/stack_page_views/stack_list_loading.dart';
import 'package:stackly/features/stack_page/stack_page_views/stack_list_view.dart';
import 'package:stackly/features/stack_page/stack_page_views/stack_list_view_error.dart';
import 'package:stackly/features/today_page/date_row/date_row_cubit.dart';
import 'package:stackly/services/analytics_helper.dart';

class StackPageView extends StatelessWidget {
  const StackPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const NewPageView();
              },
            ),
          );
          context.read<StackPageBloc>().add(StackPageEventLoad());
          logEvent(event: 'new_clicked');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
            top: 5.w,
          ),
          child: BlocConsumer<StackPageBloc, StackPageState>(
            listener: (BuildContext context, state) {
            },
            builder: (BuildContext context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          context.read<StackPageBloc>().add(StackPageEventLoad());
                        },
                        child: Text(
                          'Stack',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 8.w,
                          ),
                          key: const Key('Stack'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  state.status.isInitial
                      ? const StackListViewEmpty()
                      : (state.status.isLoading
                          ? const StackListViewLoading()
                          : (state.status.isError
                              ? const StackListViewError()
                              : StackListView(
                                  supplements: state.stackList,
                                )))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
