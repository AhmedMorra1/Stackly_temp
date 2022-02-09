import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/configs/consts.dart';
import 'package:stackly/features/stack_page/stack_page_bloc.dart';
import 'package:stackly/features/stack_page/stack_page_event.dart';
import 'package:stackly/services/analytics_helper.dart';

import 'edit_page_bloc.dart';
import 'edit_page_state.dart';
import 'edit_page_widgets/current_package_count.dart';
import 'edit_page_widgets/instruction.dart';
import 'edit_page_widgets/name_text_field.dart';
import 'edit_page_widgets/package_count_row.dart';
import 'edit_page_widgets/page_title.dart';
import 'edit_page_widgets/save_cancel_row.dart';
import 'edit_page_widgets/serving_size.dart';
import 'edit_page_widgets/serving_times.dart';

class EditPageView extends StatelessWidget {
  const EditPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: BlocConsumer<EditPageBloc,EditPageState>(
              listener: (BuildContext context, state) {
                if (state.status.isInitial){
                }else if (state.status.isEmptyName){
                  showSnackBar('Supplement must have a name.',context);
                  logEvent(event: 'new_save_error_name_empty');
                }else if (state.status.isPackageCountEmpty){
                  showSnackBar("Package Count can't be zero.",context);
                  logEvent(event: 'new_save_error_package_count_empty');
                }else if (state.status.isCurrentPackageCountEmpty){
                  showSnackBar("Current Package Count can't be zero.",context);
                  logEvent(event: 'new_save_error_current_package_count_empty');
                }else if (state.status.isCurrentCountMoreThanPackageCount){
                  showSnackBar("Current Package Count can't be more than Package Count!",context);
                  logEvent(event: 'new_save_error_count_more');
                }else if (state.status.isServingSizeEmpty){
                  showSnackBar("Serving Size can't be zero.",context);
                  logEvent(event: 'new_save_error_size_empty');
                }else if (state.status.isServingTimesEmpty){
                  showSnackBar("Add at least one serving time.",context);
                  logEvent(event: 'new_save_error_times_empty');
                }else{
                  context.read<StackPageBloc>().add(StackPageEventLoad());
                  Navigator.of(context).pop();
                  logEvent(event: 'new_saved');
                }
              },
              builder: (BuildContext context, state) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      NewPageTitle(),
                      NameTextField(),
                      PackageCountRow(),
                      CurrentCountTextField(),
                      ServingSizeTextField(),
                      ServingTimesList(),
                      InstructionPicker(),
                      SaveCancelRow(),
                    ],
                  ),
                );
              }),
        ),
      ),
      backgroundColor: kBackGroundColor,
    );
  }
}

void showSnackBar(String message, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ),
  );
}