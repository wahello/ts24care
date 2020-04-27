import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/models/item_notification_model.dart';
import 'package:ts24care/src/app/models/onesignal-notification-messages.dart';
import 'package:ts24care/src/app/pages/ticket/detail/ticket_detail_page.dart';

class Choice {
  Choice({this.title, this.list});

  final String title;
  final List<ItemNotificationModel> list;
}

class NotificationPageViewModel extends ViewModelBase {
  TabController tabController;

  //List<Choice> choices;
  ScrollController controller = ScrollController();

  //int offset = 0;
  //int limit = 10;
  bool loadingMore = false;
  bool loadMoreDone = false;
  int _skip = 10;
  int initLoading = 0;

  List<OneSignalNotificationMessages> listNotification = List();

  NotificationPageViewModel() {
    onLoadListNotification();
    //onLoad();
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          !loadingMore) {

//        int id = helpDeskCategory.id != -1 ? helpDeskCategory.id : 0;
//        int date = isAscendingDate ? 1 : 0;
        onLoadMore();
      }
    });
  }

  onLoadListNotification() async {
    //listHelpDeskCategory.removeRange(1, listHelpDeskCategory.length);
    var _listNotification = await api.getListNotification(offset: 0, limit: 10);
    if (_listNotification != null) {
      listNotification.addAll(_listNotification);
      initLoading = 1;
      //helpDeskCategory = listHelpDeskCategory[0];
      this.updateState();
    }
  }

  onLoad() async {
//    int status = 0;
//    if (customPopupMenu != null) status = customPopupMenu.id;
    loading = true;
    this.updateState();
    var _listNotification = await api.getListNotification(offset: 0, limit: 10);
//    if (_listTicket.length > 0) {
    listNotification = List();
    listNotification.addAll(_listNotification);
    loading = false;
    loadingMore = false;
    loadMoreDone = false;
    _skip = 10;
    this.updateState();
  }

  onLoadMore() {
    if (loadMoreDone) return;
//    if (customPopupMenu != null) status = customPopupMenu.id;
    loadingMore = true;
    this.updateState();
//    int countItemLoad = 0;

    api
        .getListNotification(
      limit: 10,
      offset: _skip,
    )
        .then((list) {
      if (list.length > 0) {
        listNotification.addAll(list);
        _skip += 10;
        loadingMore = false;
        this.updateState();
        return;
//        _getImageHistory();
      } else {
        loadingMore = false;
        loadMoreDone = true;
        this.updateState();
        return;
      }
      //  _getImageHistoryPositions();
    });
  }

  onTapNotification(OneSignalNotificationMessages notification) {
    dynamic data = notification.data;
    if (data != null) {
      try {
        var mapData = jsonDecode(data);
        mapData.forEach((key, value) {
          switch (key) {
            //lấy theo model odoo
            case "model":
              switch (value) {
                case "helpdesk.ticket":
                  HelpdeskTicket helpdeskTicket =
                      HelpdeskTicket.fromJsonPushNotification(mapData);
                  //navigate qua page ticket
                  Navigator.pushNamed(context, TicketDetailPage.routeName,
                      arguments:  helpdeskTicket.id);
                  break;
                default:
              }
              break;
            default:
          }
        });
      } catch (error) {
        print('error $error');
      }
    }
  }
}
