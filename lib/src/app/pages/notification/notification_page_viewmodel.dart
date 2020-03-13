
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/models/item_notification_model.dart';

import '../../app_localizations.dart';

class Choice {
  Choice({this.title, this.list});

  final String title;
  final List<ItemNotificationModel> list;
}

class NotificationPageViewModel extends ViewModelBase{

  TabController tabController;
  List<Choice> choices;


  NotificationPageViewModel(){
    choices = <Choice>[
      Choice(title: translation.text("NOTIFICATIONS_PAGE.RECENT_ITEMS"), list: ItemNotificationModel.listItemNewNotificationModel),
      Choice(title: translation.text("NOTIFICATIONS_PAGE.APPS"), list: ItemNotificationModel.listItemNewNotificationModel),
      Choice(title: translation.text("NOTIFICATIONS_PAGE.BLOCKED"), list: ItemNotificationModel.listItemNewNotificationModel)
    ];


  }
//  onHandleMenuItemNotification(CustomPopupMenu menu, {List<ItemNotificationModel> listNotificationOfChoices, ItemNotificationModel itemNotificationModel}){
//    print('id ${menu.id} item ${itemNotificationModel.type}');
//    if(menu.id == 1){
//      listNotificationOfChoices.remove(itemNotificationModel);
////      choices.
////      ItemNotificationModel.listItemNewNotificationModel.remove(itemNotificationModel);
//    }
//    this.updateState();
//    print('choices 1 ${choices[0].list.length}');
//    print('choices 2 ${choices[1].list.length}');
//    print('choices 3 ${choices[2].list.length}');
//  }
//  onHandleMenuDeleteNotification(ItemNotificationModel item){
//    ItemNotificationModel.listItemNewNotificationModel.remove(item);
//  }
}