import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> showNotification(
    RemoteNotification notification, AndroidNotification android) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'School-Yard',
    'School-Yard',
    channelDescription: 'School Yard App Chat Notification',
    importance: Importance.max,
    priority: Priority.high,
    icon: 'app_icon',
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    notification.title, // Notification title
    notification.body, // Notification body
    platformChannelSpecifics,
    payload: 'item x', // Payload (optional)
  );
}
