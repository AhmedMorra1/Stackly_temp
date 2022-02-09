import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/models/supplement.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'stack_card_view_model.dart';

class StackCardView extends StatelessWidget {
  final Supplement supplement;
  const StackCardView({required this.supplement});
  @override
  Widget build(BuildContext context) {
    StackCardViewModel stackCardViewModel = StackCardViewModel(supplement: supplement);
    return Padding(
      padding:  EdgeInsets.only(bottom: 2.w),
      child: Container(
        height: 16.w,
        width: 90.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(2.w),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      stackCardViewModel.name,
                      style: TextStyle(fontSize: 5.w),
                    ),
                  ),
                  SizedBox(
                    height: 1.w,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${stackCardViewModel.servingSize} ', style: TextStyle(fontSize: 3.w)),
                        Text(stackCardViewModel.servingType, style: TextStyle(fontSize: 3.w)),
                        Text(' - ', style: TextStyle(fontSize: 3.w)),
                        Text('${stackCardViewModel.instructions} - ', style: TextStyle(fontSize: 3.w)),
                        ...stackCardViewModel.servingTimes.map((e) => Text('$e ', style: TextStyle(fontSize: 3.w)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CircularPercentIndicator(
              radius: 14.w,
              lineWidth: 4.0,
              percent: stackCardViewModel.percent,
              reverse: true,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stackCardViewModel.currentCount,
                    style: TextStyle(fontSize: 3.w),
                  ),
                  SizedBox(
                    width: 10.w,
                    child: const Divider(
                      height: 1,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    stackCardViewModel.totalCount,
                    style: TextStyle(fontSize: 3.w),
                  ),
                ],
              ),
              progressColor: stackCardViewModel.progressColor(),
            ),
            SizedBox(
              width: 4.w,
            )
          ],
        ),
      ),
    );
  }
}