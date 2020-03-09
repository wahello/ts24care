import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/menu.dart';
import 'package:ts24care/src/app/pages/help/help_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/home/home_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/setting/setting_viewmodel.dart';
import 'package:ts24care/src/app/pages/ticket/ticket_page_viewmodel.dart';

class TabsPageViewModel extends ViewModelBase {
  PageController controller;
  Menu menu = Menu.tabMenu[0];
  HomePageViewModel homeViewModel;
  TicketPageViewModel ticketsViewModel;
  HelpPageViewModel helpViewModel;
  SettingPageViewModel settingsViewModel;
  // CloudFiresStoreService cloudService = CloudFiresStoreService();
  TabsPageViewModel() {
    homeViewModel = HomePageViewModel();
    ticketsViewModel = TicketPageViewModel();
    helpViewModel = HelpPageViewModel();
    settingsViewModel = SettingPageViewModel();
    controller = PageController();
    //cloudService.busSession.syncColectionChildrenBusSession();
    // cloudService.sendMessage();
  }
  onTap(int index) {
    menu = Menu.tabMenu[index];
    controller.jumpToPage(index);
    this.updateState();
  }
}
