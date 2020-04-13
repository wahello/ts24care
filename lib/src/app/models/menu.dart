import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/pages/home/dashboard/dashboard_page.dart';
import 'package:ts24care/src/app/pages/notification/notification_page.dart';
import 'package:ts24care/src/app/pages/setting/setting_page.dart';
import 'package:ts24care/src/app/pages/ticket/ticket_page.dart';

class Menu {
  Menu(
      {@required this.title,
      @required this.iconData,
      this.index,
      this.page,
      this.routeChildName});
  int index;
  String title;
  IconData iconData;
  Widget page;
  String routeChildName;
  static List<Menu> tabMenu = <Menu>[
    Menu(
      index: 0,
      title: translation.text("HOME_PAGE.TITLE"),
      iconData: Icons.home,
      page: Dashboard(),
      routeChildName: Dashboard.routeName,
    ),
    Menu(
      index: 1,
      title: translation.text("TICKET_PAGE.TITLE"),
      iconData: FontAwesomeIcons.ticketAlt,
      page: TicketsPage(),
      routeChildName: TicketsPage.routeName,
    ),
//    Menu(
//      index: 2,
//      title: translation.text("HELP_PAGE.TITLE"),
//      iconData: Icons.help,
//      page: HelpPage(),
//      routeChildName: HelpPage.routeName,
//    ),
    Menu(
      index: 2,
      title: translation.text("NOTIFICATIONS_PAGE.TITLE"),
      iconData: Icons.notifications,
      page: NotificationsPage(),
      routeChildName: NotificationsPage.routeName,
    ),
    Menu(
      index: 3,
      title: translation.text("SETTINGS_PAGE.TITLE"),
      iconData: Icons.settings,
      page: SettingPage(),
      routeChildName: SettingPage.routeName,
    ),
  ];
  static reload() {
    tabMenu = <Menu>[
      Menu(
        index: 0,
        title: translation.text("HOME_PAGE.TITLE"),
        iconData: Icons.home,
        page: Dashboard(),
        routeChildName: Dashboard.routeName,
      ),
      Menu(
        index: 1,
        title: translation.text("TICKET_PAGE.TITLE"),
        iconData: FontAwesomeIcons.ticketAlt,
        page: TicketsPage(),
        routeChildName: TicketsPage.routeName,
      ),
      // Menu(
      //   index: 2,
      //   title: translation.text("HELP_PAGE.TITLE"),
      //   iconData: Icons.help,
      //   page: HelpPage(),
      //   routeChildName: HelpPage.routeName,
      // ),
      Menu(
        index: 2,
        title: translation.text("NOTIFICATIONS_PAGE.TITLE"),
        iconData: Icons.notifications,
        page: NotificationsPage(),
        routeChildName: NotificationsPage.routeName,
      ),
      Menu(
        index: 3,
        title: translation.text("SETTINGS_PAGE.TITLE"),
        iconData: Icons.settings,
        page: SettingPage(),
        routeChildName: SettingPage.routeName,
      ),
    ];
  }
}
