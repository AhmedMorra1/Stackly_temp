import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/features/new_page/new_page_event.dart';
import 'package:stackly/features/new_page/new_page_state.dart';
import 'package:stackly/features/new_page/new_page_widgets/serving_type_picker.dart';

import '../new_page_bloc.dart';

class PackageCountRow extends StatelessWidget {
  const PackageCountRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController totalCountController = TextEditingController();
    totalCountController.text = context.read<NewPageBloc>().state.supplement.totalCount != 0 ? context.read<NewPageBloc>().state.supplement.totalCount.toString() : '';
    return BlocConsumer<NewPageBloc, NewPageState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Package Count',
              style: TextStyle(
                fontSize: 5.w,
              ),
            ),
            SizedBox(height: 2.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 10.w,
                  width: 44.w,
                  child: TextField(
                    controller: totalCountController,
                    key: const Key('Package Count TextField'),
                    maxLength: 3,
                    autofocus: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF000000), width: .3),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF000000), width: .3),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 3.w,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onChanged: (value) {
                      context.read<NewPageBloc>().add(PackageCountChanged(packageCount: value.isNotEmpty ? int.parse(value) : 0));
                      context.read<NewPageBloc>().add(CurrentCountChanged(currentCount: value.isNotEmpty ? int.parse(value) : 0));
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Container(
                  child: const Center(
                      child: ServingTypePicker(
                  )),
                  height: 10.w,
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(
                      width: .3,
                      color: const Color(0xFF000000),
                    ),
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.w),
          ],
        );
      },
    );
  }
}
