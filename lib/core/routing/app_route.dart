import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store_app/core/routing/routes.dart';
import 'package:store_app/features/home/views/home_screen.dart';
import 'package:store_app/features/login/views/login_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}")),
          ),
        );
    }
  }
}
