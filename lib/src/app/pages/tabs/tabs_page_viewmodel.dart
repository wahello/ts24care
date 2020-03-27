import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/menu.dart';
import 'package:ts24care/src/app/pages/help/help_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/home/home_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/setting/setting_viewmodel.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page.dart';
import 'package:ts24care/src/app/pages/ticket/ticket_page_viewmodel.dart';

class TabsPageViewModel extends ViewModelBase {
  PageController controller;
  Menu menu = Menu.tabMenu[0];
  TabsPageViewModel() {
    controller = PageController();
  }
  onTap(int index) {
    menu = Menu.tabMenu[index];
    controller.jumpToPage(index);
    this.updateState();
  }

  navigateChild(TabsArgument arg) {
    Menu.tabMenu.asMap().forEach((index, menu) {
      if (arg.routeChildName == menu.routeChildName) {
        this.menu = menu;
        controller = PageController(initialPage: menu.index);
        this.updateState();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
