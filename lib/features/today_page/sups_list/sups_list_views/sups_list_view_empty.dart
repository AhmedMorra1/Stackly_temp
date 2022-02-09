import 'package:flutter/material.dart';

class SubsListViewEmpty extends StatelessWidget {
  const SubsListViewEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text(
          'No supplements.\nAdd supplements to your Stack.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
