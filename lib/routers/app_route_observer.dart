import 'package:flutter/material.dart';

class AppRouteObserver extends NavigatorObserver {
  final Function({String? route, dynamic args}) onRouteChage;

  AppRouteObserver({required this.onRouteChage});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    onRouteChage.call(
      route: route.settings.name,
      args: route.settings.arguments,
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    onRouteChage.call(
      route: route.settings.name,
      args: route.settings.arguments,
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (true) {}
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    onRouteChage.call(
      route: route.settings.name,
      args: route.settings.arguments,
    );
  }
}
