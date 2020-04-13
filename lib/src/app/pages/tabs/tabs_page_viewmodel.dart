
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/menu.dart';
import 'package:ts24care/src/app/pages/help/helpChat/helpChat_page.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page.dart';

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

  onTapCreateTicket() {
    Navigator.pushNamed(context, TicketNewPage.routeName).then((result){
      try{
        if(result){
          handleTicketCreated.streamController.sink.add(result);
        }
      }catch(e){}
    });
  }
  onTapChat() {
    Navigator.pushNamed(context, HelpChatPage.routeName);
  }
}
