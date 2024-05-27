import 'package:bundy_track/provider/TabIndexProvider.dart';
import 'package:bundy_track/provider/Welcome_provider.dart';
import 'package:bundy_track/utils/routes/routes.dart';
import 'package:bundy_track/utils/routes/routes_name.dart';
import 'package:bundy_track/view/allocator.dart';
import 'package:bundy_track/view/welcome_Screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
