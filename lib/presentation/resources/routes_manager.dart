import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/app/app.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/home_screen.dart';

class Routes {
  static const String home = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(''),
              ),
              body: Center(child: Text('')),
            ));
  }
}
