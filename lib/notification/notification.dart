import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utils/routes/routes_name.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: true,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined permission');
    }
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (payload) async {
      handelMessage(context, message);

        });
  }

  void firebaseInit(BuildContext context) {
   if(kDebugMode){
     FirebaseMessaging.onMessage.listen((message) {
       print(message.notification!.body.toString());
       print(message.notification!.title.toString());
       print(message.data['name']);
       print(message.data['id']);

       initLocalNotification(context, message);
       showNotification(message);

     });
   }
  }

  Future<void> showNotification(RemoteMessage message)async{
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      'Channel Name',
      importance: Importance.max,

    );

    AndroidNotificationDetails  androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        ticker: 'ticker'

    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails
    );

    Future.delayed(Duration.zero,(){
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  Future<String> getToken() async {
    String? token = await messaging.getToken();
    return token!;
  }


  void handelMessage(BuildContext context, RemoteMessage message) {
    if(message.data['name'] == 'kashan'){
      Navigator.pushNamed(context, RoutesName.message);
    }
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      print('Token Refreshed');
    });
  }
}
