import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewPageTitle extends StatelessWidget {
  const NewPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add New',
          style: TextStyle(
            fontSize: 8.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.w,),
      ],
    );
  }
}
