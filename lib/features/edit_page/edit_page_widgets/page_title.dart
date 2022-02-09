import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/features/edit_page/edit_page_bloc.dart';
import 'package:stackly/features/stack_page/stack_page_bloc.dart';
import 'package:stackly/features/stack_page/stack_page_event.dart';
import 'package:stackly/services/analytics_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../edit_page_event.dart';

class NewPageTitle extends StatelessWidget {
  const NewPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Edit',
              style: TextStyle(
                fontSize: 8.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            InkWell(
              key: const Key('delete'),
              onTap: () async {
                var result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete'),
                      content: const Text('Delete this Supplement?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            logEvent(event: 'delete_canceled');
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<EditPageBloc>().add(DeleteEdit());
                            context.read<StackPageBloc>().add(StackPageEventLoad());
                            Navigator.of(context).pop();
                            logEvent(event: 'delete_confirmed');
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
                if (result == true) {
                  Navigator.of(context).pop();
                }
              },
              child: const Icon(Icons.delete),
            )
          ],
        ),
        SizedBox(height: 10.w,),
      ],
    );
  }
}
