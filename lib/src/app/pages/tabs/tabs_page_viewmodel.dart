import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/help_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/home/home_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/setting/setting_viewmodel.dart';
import 'package:ts24care/src/app/pages/ticket/ticket_page_viewmodel.dart';

class TabsPageViewModel extends ViewModelBase {
  int currentTabIndex = 0;

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
    //cloudService.busSession.syncColectionChildrenBusSession();
    // cloudService.sendMessage();
  }
  onTapped(int index) {
    currentTabIndex = index;
    // if (currentTabIndex == 2) //LocateBus
    // {
    //   Future.delayed(const Duration(milliseconds: 300), () {
    //     locateBusPageViewModel.showGoolgeMap = true;
    //     locateBusPageViewModel.updateState();
    //   });
    // }
    this.updateState();
  }

  GlobalKey<FancyBottomNavigationState> fancyKey =
  GlobalKey<FancyBottomNavigationState>();

  GlobalKey<ScaffoldState> scaffoldTabbar = GlobalKey<ScaffoldState>();
  //Xử lý khi slide menu tap item
  onSlideMenuTapped(int index, /*{ChildrenBusSession data}*/) {
    currentTabIndex = index;
    fancyKey.currentState.setPage(index);
    // if (data != null) {
    //   locateBusPageViewModel.childrenBus = data;
    //   locateBusPageViewModel.listenData(data.sessionID);
    // }
    // locateBusPageViewModel.updateState();
  }
}
