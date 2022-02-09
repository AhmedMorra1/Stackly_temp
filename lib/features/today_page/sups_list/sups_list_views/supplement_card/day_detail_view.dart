import 'package:flutter/material.dart';
import 'package:stackly/models/day_details.dart';
import 'package:stackly/configs/extensions.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:stackly/services/analytics_helper.dart';
import 'package:stackly/services/db_helper.dart';
import 'package:stackly/models/supplement.dart';
import 'package:sizer/sizer.dart';

class DayDetailCardView extends StatelessWidget {
  final Map specifics;
  final Map previousSpecifics;
  const DayDetailCardView({required this.specifics,required this.previousSpecifics});
  @override
  Widget build(BuildContext context) {
    String servingTime = specifics['servingTime'];
    String previousServingTime = previousSpecifics['servingTime'];
    String supplementName = specifics['supplementName'];
    int supplementServingSize = specifics['supplementServingSize'];
    String supplementServingType = specifics['supplementServingType'];
    String supplementInstructions = specifics['supplementInstructions'];
    int dayDetailId = specifics['id'];
    int previousDayDetailId = previousSpecifics['id'];
    int dayId = specifics['day_id'];
    int supplementId = specifics['supplement_id'];
    int servingTimeId = specifics['serving_time_id'];
    // int previousServingTimeId = previousSpecifics['serving_time_id'];
    String taken = specifics['taken'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (servingTime != previousServingTime || dayDetailId == previousDayDetailId)
          Padding(
            padding:  EdgeInsets.only(bottom: 4.w,top:  2.w),
            child: Text(
              servingTime,
              style: TextStyle(
                fontSize: 5.w,
                fontWeight: FontWeight.w200,
              ),
            ),
          )
        else
          const SizedBox(),
        Padding(
          padding: EdgeInsets.only(bottom: 2.w,),
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
                SizedBox(width: 2.w,),
                RoundCheckBox(
                  onTap: (selected) async {

                    Supplement? supplement = await DBHelper.instance.getSupplement(supplementId);
                    if(selected == true){
                      logEvent(event: 'unchecked');
                      supplement!.currentCount = supplement.currentCount! - supplementServingSize;
                    }else{
                      logEvent(event: 'checked');
                      supplement!.currentCount = supplement.currentCount! + supplementServingSize;
                    }
                    taken = selected.toString();
                    DBHelper.instance.updateDayDetail(DayDetails(
                      id: dayDetailId,
                      day_id: dayId,
                      supplement_id: supplementId,
                      serving_time_id: servingTimeId,
                      taken: taken,
                    ),
                    );
                    DBHelper.instance.updateSupplement(supplement);
                  },
                  checkedColor: Colors.blueAccent,
                  isChecked: taken.parseBool(),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplementName,
                      style: TextStyle(fontSize: 5.w),
                    ),
                    SizedBox(height: 1.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${supplementServingSize.toString()} ', style: TextStyle(fontSize: 3.w)),
                        Text(supplementServingType, style: TextStyle(fontSize: 3.w)),
                        Text(' - ', style: TextStyle(fontSize: 3.w)),
                        Text(supplementInstructions, style: TextStyle(fontSize:  3.w)),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width:  4.w,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
