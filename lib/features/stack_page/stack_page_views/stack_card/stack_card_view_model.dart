import 'package:stackly/models/supplement.dart';
import 'package:flutter/material.dart';


class StackCardViewModel{
  final Supplement supplement;
  StackCardViewModel({required this.supplement});

  Map get map => supplement.toMap();

  String get id => map['id'].toString();
  String get name => map['name'];
  String get totalCount => map['total_count'].toString();
  String get currentCount => map['current_count'] >= 0 ? map['current_count'].toString() : '0';
  String get servingType => map['serving_type'];
  String get servingSize => map['serving_size'].toString();
  List get servingTimes => map['serving_times'];
  String get instructions => map['instructions'];
  String get refillAlertCount => map['refill_alert_count'].toString();
  String get lastDay => map['lastDay'];

  double get percent => map['current_count']/map['total_count'] >= 0 ? map['current_count']/map['total_count'] : 0;

  Color progressColor(){
    var percentage = map['current_count']/map['total_count'];
    if(percentage >= 0.5){
      return Colors.blueAccent;
    }else if (percentage >= 0.2 && percentage < 0.5){
      return Colors.orangeAccent;
    }
       return Colors.redAccent;
  }


}