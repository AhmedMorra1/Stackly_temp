import 'package:flutter/material.dart';
import 'package:stackly/features/edit_page/edit_page_bloc.dart';
import 'package:stackly/features/edit_page/edit_page_event.dart';
import 'package:stackly/features/edit_page/edit_page_view.dart';
import 'package:stackly/models/supplement.dart';
import 'package:stackly/services/analytics_helper.dart';
import 'package:stackly/features/stack_page/stack_page_views/stack_card/stack_card_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StackListView extends StatelessWidget {
  const StackListView({Key? key,required this.supplements}) : super(key: key);
  final List<Supplement> supplements;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: supplements.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: StackCardView(supplement: supplements[index]),
            onTap: () async {
              context.read<EditPageBloc>().add(NewEdit(supplement: supplements[index]));
              logEvent(event: 'stack_card_opened');
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const EditPageView();
                }),
              );
            },
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
