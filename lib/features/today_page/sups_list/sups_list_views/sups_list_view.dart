import 'package:flutter/material.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_views/supplement_card/day_detail_view.dart';

class SubsListView extends StatelessWidget {
  const SubsListView({Key? key,required this.subsList}) : super(key: key);
  final List<Map> subsList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: subsList.length,
        itemBuilder: (BuildContext context, int index) {
          return DayDetailCardView(
            specifics: subsList[index],
            previousSpecifics: index > 0 ? subsList[index - 1] : subsList[index],
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
