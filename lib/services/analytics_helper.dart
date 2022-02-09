import 'package:firebase_analytics/firebase_analytics.dart';

logEvent({required String event, Map<String, Object?>? parameters}){
  try {
    FirebaseAnalytics().logEvent(
      name: event,
      parameters: parameters,);
  } finally {

  }
}