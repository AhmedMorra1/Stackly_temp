import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';


class NotificationsHelper {

  NotificationsHelper._privateConstructor();
  static final NotificationsHelper instance = NotificationsHelper._privateConstructor();

  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    const sound = 'pristine.mp3';
    return  NotificationDetails(
      android: AndroidNotificationDetails(
        'c4',
        'channel 4',
        channelDescription: 'channel 4 description',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound(sound.split('.').first),
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {

    const android = AndroidInitializationSettings('stackly_notification_icon');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await _notifications.initialize(settings,onSelectNotification: (payload)async{
      onNotifications.add(payload);
    });

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static Future showScheduledNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime servingTime,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(servingTime, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );

  static Future showDailyScheduledNotifications({
    int? id,
    String? title,
    String? body,
    String? payload,
    required DateTime servingTime,
  }) async =>
      _notifications.zonedSchedule(
        id!,
        title,
        body,
        _scheduleDaily(Time(servingTime.hour,servingTime.minute,servingTime.second)),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

  static tz.TZDateTime _scheduleDaily(Time time){
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }

  static void cancel(int id) => _notifications.cancel(id);
  static void cancelAll() => _notifications.cancelAll();

}
