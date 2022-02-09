import 'package:flutter/material.dart';

class SupsListViewError extends StatelessWidget {
  const SupsListViewError({Key? key}) : super(key: key);

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
