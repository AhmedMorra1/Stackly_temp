import 'package:flutter/material.dart';

class StackListViewError extends StatelessWidget {
  const StackListViewError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text(
          'Error Loading your stack.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
