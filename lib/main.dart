import 'package:bundy_track/utils/routes/routes.dart';
import 'package:bundy_track/utils/routes/routes_name.dart';
import 'package:bundy_track/view/allocator.dart';
import 'package:bundy_track/view/welcome_Screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       initialRoute: RoutesName.signInScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

