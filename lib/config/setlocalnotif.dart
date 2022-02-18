import 'package:easyalquran/view/jadwal/jadwalsholat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_All.dart' as tz;

class Setlocalnotif {
  static FlutterLocalNotificationsPlugin lokalNotif =
      FlutterLocalNotificationsPlugin();

  static init(BuildContext context) async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
    var initAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {});

    var initallSettings =
        InitializationSettings(android: initAndroid, iOS: initIOS);

    await lokalNotif.initialize(initallSettings,
        onSelectNotification: (payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
        if (payload == 'sholat') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Jadwalsholat()),
          );
        }
      }
    });
  }

  static setSchedule(timed, id, title) async {
    final adzans = title == 'Imsak' || title == 'Terbit'
        ? ''
        : title != 'Subuh'
            ? 'adzan'
            : 'subuh';
    String titlenotif = title == 'Imsak' || title == 'Terbit' ? '' : 'Sholat';
    String subtitle = title == 'Imsak' || title == 'Terbit'
        ? 'Sekarang sudah waktunya'
        : 'Selamat menunaikan ibadah sholat';

    await lokalNotif.zonedSchedule(
      id,
      'Waktunya $titlenotif $title',
      '$subtitle $title!',
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      //nextInstanceOfTenAM(timed),
      nextInstanceOfTenAMLastYear(timed),
      NotificationDetails(
        android: AndroidNotificationDetails(
          id.toString(),
          'your channel name',
          channelDescription: 'your channel description',
          sound: RawResourceAndroidNotificationSound(adzans),
          playSound: true,
          priority: Priority.high,
          importance: Importance.max,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'sholat',
    );
  }

  static tz.TZDateTime nextInstanceOfTenAM(time) {
    final tm = time.split(':');
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, int.parse(tm[0]), int.parse(tm[1]));
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static tz.TZDateTime nextInstanceOfTenAMLastYear(time) {
    final tm = time.split(':');
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final schedule = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        int.parse(tm[0]), int.parse(tm[1]));
    return schedule;
  }

  static shoLokalnotif(id, name, des) async {
    const AndroidNotificationDetails androichanel = AndroidNotificationDetails(
        'notif', 'name',
        channelDescription: 'des',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androichanel);
    await lokalNotif.show(0, name, des, platformChannelSpecifics,
        payload: 'item x');
  }

  static Future<void> deleteNotificationChannel(String channelId) async {
    await lokalNotif
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel(channelId);
  }
}
