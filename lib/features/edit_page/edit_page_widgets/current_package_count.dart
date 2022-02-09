import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../edit_page_bloc.dart';
import '../edit_page_event.dart';
import '../edit_page_state.dart';

class CurrentCountTextField extends StatelessWidget {
  const CurrentCountTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPageBloc, EditPageState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        TextEditingController currentCountController = TextEditingController();
        currentCountController.text = context.read<EditPageBloc>().state.supplement.currentCount != 0 ?context.read<EditPageBloc>().state.supplement.currentCount.toString():'';
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Package Count',
              style: TextStyle(
                fontSize: 5.w,
              ),
            ),
            SizedBox(height: 2.w),
            SizedBox(
              height: 10.w,
              width: 90.w,
              child: TextField(
                textAlign: TextAlign.center,
                controller: currentCountController,
                autofocus: false,
                decoration: InputDecoration(
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
                  context.read<EditPageBloc>().add(CurrentCountChanged(currentCount: value.isNotEmpty ? int.parse(value) : 0));
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
            SizedBox(height: 4.w),
          ],
        );
      },
    );
  }
}
