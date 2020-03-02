import 'dart:async';
import 'package:flutter/material.dart';

class Routes {
  static Widget defaultPage;
  static final Map<String, WidgetBuilder> route = {
    // '/': (context) => LoginPage(),
  };
}

void function(int index) {}

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  static String routeCurrentName = '';
  void _sendScreenView(PageRoute<dynamic> route) {
    routeCurrentName = route.settings.name;
    var screenName = route.settings.name;
    // switch (screenName) {
    //   case PopupChatPage.routeName:
    //     handlerPushNotification.dispose();
    //     break;
    //   default:
    // }
    print('screenName $screenName');

    // do something with it, ie. send it to your analytics service collector
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}

class RoutePopArgument {
  final String routeName;
  final dynamic data;

  RoutePopArgument(this.routeName, this.data);
}
