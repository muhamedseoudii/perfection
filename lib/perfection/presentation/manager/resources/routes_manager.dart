import 'package:flutter/material.dart';
import 'package:perfection/perfection/presentation/pages/home/view/user_details_view.dart';
import 'package:perfection/perfection/presentation/pages/home/view/user_list_view.dart';

import '../../pages/splash/splash_view.dart';
import 'string_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String userListRoute = "/userList";
  static const String userDetailsRoute = "/userDetails";

}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.userListRoute:
        return MaterialPageRoute(builder: (_) => const UserListScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(child: Text(AppStrings.noRouteFound)),
        );
      },
    );
  }
}
