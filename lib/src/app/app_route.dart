import 'package:flutter/material.dart';
import 'package:ts24care/src/app/models/customer.dart';
import 'package:ts24care/src/app/pages/help/faq/help_faq_page.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faq_detail_page.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faqArticleDetail/faq_article_detail_web_view_page.dart';
import 'package:ts24care/src/app/pages/help/helpChat/helpChat_page.dart';
import 'package:ts24care/src/app/pages/help/help_page.dart';
import 'package:ts24care/src/app/pages/help/productWarrantyDetail/product_warranty_detail_page.dart';
import 'package:ts24care/src/app/pages/home/newsAndTips/home_news_and_tips_page.dart';
import 'package:ts24care/src/app/pages/login/createAccount/create_new_password.dart';
import 'package:ts24care/src/app/pages/login/forgetPassword/forget_password.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';
import 'package:ts24care/src/app/pages/notification/notification_page.dart';
import 'package:ts24care/src/app/pages/setting/settingsNotifications/settings_my_notifications.dart';
import 'package:ts24care/src/app/pages/setting/userDetail/setting_user_detail_page.dart';
import 'package:ts24care/src/app/pages/setting/web_view_page.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page.dart';
import 'package:ts24care/src/app/pages/tutorial/tutorial_page.dart';
import 'pages/setting/settingsFeedback/settings_feedback_page.dart';

class Routes {
  static Widget defaultPage;

  static navigateDefaultPage() async {
    // Routes.defaultPage = TutorialPage();
//    Routes.defaultPage = LoginPage();
    Customer customer = new Customer();
    bool result = await customer.checkCustomerExist();
    if (result) {
      Routes.defaultPage =
          TabsPage(TabsArgument(routeChildName: HelpPage.routeName));
    } else
      Routes.defaultPage = TutorialPage();
  }

  static final Map<String, WidgetBuilder> route = {
    // '/': (context) => LoginPage(),
    LoginPage.routeName: (context) => LoginPage(),
    TutorialPage.routeName: (context) => TutorialPage(),
    TabsPage.routeName: (context) =>
        TabsPage(ModalRoute.of(context).settings.arguments),
    NewsAndTipsPage.routeName: (context) => NewsAndTipsPage(),
    FAQPage.routeName: (context) => FAQPage(),
    FaqDetailPage.routeName: (context) => FaqDetailPage(
          listParams: ModalRoute.of(context).settings.arguments,
        ),
    TicketNewPage.routeName: (context) => TicketNewPage(),
    NotificationsPage.routeName: (context) => NotificationsPage(),
    HelpChatPage.routeName: (context) => HelpChatPage(),
    ForgetPasswordPage.routeName: (context) => ForgetPasswordPage(),
    LoginPage.routeName: (context) => LoginPage(),
    CreateNewPasswordPage.routeName: (context) => CreateNewPasswordPage(),

    // 10/03/2020
    UserDetailPage.routeName: (context) =>
        UserDetailPage(ModalRoute.of(context).settings.arguments),
    SettingsNotificationsPage.routeName: (context) =>
        SettingsNotificationsPage(),
    SettingsFeedbackPage.routeName: (context) => SettingsFeedbackPage(),
    WebViewPage.routeName: (context) =>
        WebViewPage(arg: ModalRoute.of(context).settings.arguments),
    //    20/3/2020
    // show web html when click on article(FAQ page)
    FaqArticleDetailPage.routeName: (context) => FaqArticleDetailPage(
          htmlData: ModalRoute.of(context).settings.arguments,
        ),
    ProductWarrantyDetailPage.routeName: (context) => ProductWarrantyDetailPage(
          productWarranty: ModalRoute.of(context).settings.arguments,
        )
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
