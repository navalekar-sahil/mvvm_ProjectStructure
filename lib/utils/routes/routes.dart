import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/homeView.dart';
import 'package:mvvm/view/loginView.dart';
import 'package:mvvm/view/splashView.dart';

import '../../view/register.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

        case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());

      case RoutesName.register:
        return MaterialPageRoute(builder: (BuildContext context) => const RegisterView());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text("No routes define"),
            ),
          );
        });
    }
  }
}