import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/pages/help/help_page.dart';
import 'package:ts24care/src/app/pages/home/home_page.dart';
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
      title: translation.text("Trang chủ"),
      iconData: Icons.home,
      page: HomePage(),
      routeChildName: HomePage.routeName,
    ),
    Menu(
      index: 1,
      title: translation.text("Phiếu yêu cầu"),
      iconData: Icons.pages,
      page: TicketsPage(),
      routeChildName: TicketsPage.routeName,
    ),
    Menu(
      index: 2,
      title: translation.text("Giúp đỡ"),
      iconData: Icons.help,
      page: HelpPage(),
      routeChildName: HelpPage.routeName,
    ),
     Menu(
       index: 3,
       title: translation.text("Thông báo"),
       iconData: Icons.notifications,
       page: NotificationsPage(),
       routeChildName: NotificationsPage.routeName,
     ),
    Menu(
      index: 4,
      title: translation.text("Cài đặt"),
      iconData: Icons.settings,
      page: SettingPage(),
      routeChildName: SettingPage.routeName,
    ),
  ];
  static reload(){
    tabMenu = <Menu>[
      Menu(
        index: 0,
        title: translation.text("Trang chủ"),
        iconData: Icons.home,
        page: HomePage(),
        routeChildName: HomePage.routeName,
      ),
      Menu(
        index: 1,
        title: translation.text("Phiếu"),
        iconData: Icons.pages,
        page: TicketsPage(),
        routeChildName: TicketsPage.routeName,
      ),
      Menu(
        index: 2,
        title: translation.text("Giúp đỡ"),
        iconData: Icons.help,
        page: HelpPage(),
        routeChildName: HelpPage.routeName,
      ),
      Menu(
        index: 3,
        title: translation.text("Thông báo"),
        iconData: Icons.alarm,
        page: NotificationsPage(),
        routeChildName: NotificationsPage.routeName,
      ),
      Menu(
        index: 4,
        title: translation.text("Cài đặt"),
        iconData: Icons.settings,
        page: SettingPage(),
        routeChildName: SettingPage.routeName,
      ),
    ];
  }
}
