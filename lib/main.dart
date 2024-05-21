import 'package:bundy_track/utils/routes/routes.dart';
import 'package:bundy_track/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import 'view/signIn_screen.dart';

void main() {
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

