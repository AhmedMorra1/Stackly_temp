import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackly/services/analytics_helper.dart';

import '../edit_page_bloc.dart';
import '../edit_page_event.dart';
import '../edit_page_state.dart';


class ServingTypePicker extends StatelessWidget {
  const ServingTypePicker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var items = [
      'Capsules',
      'Tablets',
      'Softgels',
      'Gummies',
      'Teaspoons',
      'Scoops',
      'Packages',
      'Bars',
      'Pieces',
    ];
    return BlocConsumer<EditPageBloc, EditPageState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return DropdownButton(
          underline: const SizedBox(),
          value: state.supplement.servingType,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            context.read<EditPageBloc>().add(ServingTypeChanged(servingType: newValue!));
            logEvent(event: 'type_picked');
            logEvent(event: 'type_picked_$newValue');
          },
        );
      },
    );
  }
}
