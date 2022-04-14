import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/screens/development_screen.dart';

class Routes {
  static const String development = "/development";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.development:
        return MaterialPageRoute(builder: (_) => DevelopmentScreen());
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
