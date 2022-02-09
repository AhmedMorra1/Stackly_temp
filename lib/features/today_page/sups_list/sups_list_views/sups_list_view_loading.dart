import 'package:flutter/material.dart';

class SupsListViewLoading extends StatelessWidget {
  const SupsListViewLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
