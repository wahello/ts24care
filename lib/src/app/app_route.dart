import 'package:flutter/material.dart';
import 'package:ts24care/src/app/pages/help/faq/help_faq_page.dart';
import 'package:ts24care/src/app/pages/help/feedback/help_feedback_page.dart';
import 'package:ts24care/src/app/pages/home/newsAndTips/home_news_and_tips_page.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';
import 'package:ts24care/src/app/pages/notification/notification_page.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page.dart';
import 'package:ts24care/src/app/pages/tutorial/tutorial_page.dart';

class Routes {
  static Widget defaultPage;
  static navigateDefaultPage() async {
    Routes.defaultPage = TutorialPage();
  }

  static final Map<String, WidgetBuilder> route = {
    // '/': (context) => LoginPage(),
    LoginPage.routeName: (context) => LoginPage(),
    TutorialPage.routeName: (context) => TutorialPage(),
    TabsPage.routeName: (context) => TutorialPage(),
    NewsAndTipsPage.routeName: (context) => NewsAndTipsPage(),
    FAQPage.routeName: (context) => FAQPage(),
    FeedbackPage.routeName: (context) => FeedbackPage(),
    TicketNewPage.routeName: (context) => TicketNewPage(),
    TabsPage.routeName: (context) => TabsPage(),
    NotificationsPage.routeName: (context)=> NotificationsPage()
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
