import 'package:bundy_track/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../view/signIn_screen.dart';
import '../../view/signUp_Screen.dart';

class Routes{
  static MaterialPageRoute generateRoute(RouteSettings settings){
    switch(settings.name){

      case RoutesName.signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case RoutesName.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

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