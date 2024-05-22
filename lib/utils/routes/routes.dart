import 'dart:ffi';

import 'package:bundy_track/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../Resourcess/Components/tabbar.dart';
import '../../view/allocator.dart';
import '../../view/overtime.dart';
import '../../view/profile.dart';
import '../../view/signIn_screen.dart';
import '../../view/signUp_Screen.dart';
import '../../view/time_hours.dart';
import '../../view/welcome_Screen.dart';
import '../../view/yesno.dart';

class Routes{
  static MaterialPageRoute generateRoute(RouteSettings settings){
    switch(settings.name){

      case RoutesName.signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case RoutesName.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
        case RoutesName.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
        case RoutesName.timeHours:
        return MaterialPageRoute(builder: (_) => const TimeHours());
        case RoutesName.tabBarScreen:
        return MaterialPageRoute(builder: (_) => CustomTabBar());
        case RoutesName.allocator:
        return MaterialPageRoute(builder: (_) =>  const AllocatorScreen());
        case RoutesName.profile:
          return MaterialPageRoute(builder: (_) =>  const Profile());
        case RoutesName.overtime:
          return MaterialPageRoute(builder: (_) => const Overtime());
        case RoutesName.selectionScreen:
          return MaterialPageRoute(builder: (_) => const Selection());

      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}