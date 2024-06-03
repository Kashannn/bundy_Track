import 'package:bundy_track/provider/TabIndexProvider.dart';
import 'package:bundy_track/provider/Welcome_provider.dart';
import 'package:bundy_track/utils/routes/routes.dart';
import 'package:bundy_track/utils/routes/routes_name.dart';
import 'package:bundy_track/view/allocator.dart';
import 'package:bundy_track/view/welcome_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(const MyApp());
}
@pragma('vm:entry-point')
Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('background message ${message.notification!.body}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TabIndexProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bundy Track',
            initialRoute: RoutesName.signInScreen,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      )
    );
  }
}
