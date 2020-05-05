import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/helpdesk-category.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/pages/ticket/detail/ticket_detail_page.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page.dart';

class TicketPageViewModel extends ViewModelBase {
  List<HelpdeskTicket> listTicketFiltered = List();
  List<HelpdeskTicket> listTicket = List();
  List<CustomPopupMenu> listStatusTicket = List();
  StreamSubscription streamSubscriptionTicketCreated;
  bool isAscendingDate = false;
  List<HelpDeskCategory> listHelpDeskCategory = List();
  HelpDeskCategory helpDeskCategory;
  String local;
  bool showSort = false;
  ScrollController controller = ScrollController();
  bool loadingMore = false;
  bool loadMoreDone = false;
  int _skip = 10;
  int status = 0;
  CustomPopupMenu customPopupMenu = CustomPopupMenu(
      id: 0,
      color: Colors.blue,
      title: translation.text("TICKET_PAGE.STATUS_ALL"),
      state: MenuStatusState.ALL);
  List<Color> listColor = [
    Color(0xFFD52A26),
    Color(0xFFF25022),
    Color(0xFF66A73D),
    Color(0xFF666666),
    Colors.purple,
    Colors.pinkAccent,
    Colors.yellow
  ];
  TicketPageViewModel() {
    listHelpDeskCategory.add(HelpDeskCategory(
        id: -1, name: translation.text("TICKET_NEW_PAGE.SELECT_SERVICE")));
    helpDeskCategory = listHelpDeskCategory[0];
    onLoadListCategory();
    saveLocal();
    onLoadStatusTicket();
    onLoad();
    listenTicketCreated();
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          !loadingMore) {
        int id = helpDeskCategory.id != -1 ? helpDeskCategory.id : 0;
        int date = isAscendingDate ? 1 : 0;
        onLoadMore(categoryID: id, date: date);
      }
    });
  }
  onLoadListCategory() async {
    listHelpDeskCategory.removeRange(1, listHelpDeskCategory.length);
    var _listHelpDeskCategory = await api.getListCategoryOfTicket();
    if (_listHelpDeskCategory != null) {
      listHelpDeskCategory.addAll(_listHelpDeskCategory);
      helpDeskCategory = listHelpDeskCategory[0];
      this.updateState();
    }
  }

  saveLocal() async {
    local = await translation.getPreferredLanguage();
  }

  checkLocalChange() async {
    String _local = await translation.getPreferredLanguage();
    if (_local != this.local) {
//      CustomPopupMenu.reLoad();
      onLoadStatusTicket();
      this.local = _local;
    }
  }

  Future listenTicketCreated() async {
    if (streamSubscriptionTicketCreated != null)
      streamSubscriptionTicketCreated.cancel();
    var _snap = handleTicketStatus.streamController.stream;
    streamSubscriptionTicketCreated = _snap.listen((onData) {
      if (onData != null && listStatusTicket.length > 4) {
        try {
          switch (onData) {
            case 0:
              this.customPopupMenu = this.listStatusTicket[0];
              break;
            case 1:
              this.customPopupMenu = this.listStatusTicket[1];
              break;
            case 2:
              this.customPopupMenu = this.listStatusTicket[2];
              break;
            case 3:
              this.customPopupMenu = this.listStatusTicket[3];
              break;
            case 4:
              this.customPopupMenu = this.listStatusTicket[4];
              break;
          }
          onLoad();
        } catch (e) {
          print(e);
        }
      }
    });
  }

  onLoad({int categoryID, int date}) async {
    int status = 0;
    if (customPopupMenu != null) status = customPopupMenu.id;
    loading = true;
    this.updateState();
    var _listTicket = await api.getListTicketByStatus(
        status: status,
        offset: 0,
        limit: 10,
        categoryId: categoryID != null ? categoryID : 0,
        date: date != null ? date : 0);
//    if (_listTicket.length > 0) {
    listTicket = _listTicket;
    loading = false;
    loadingMore = false;
    loadMoreDone = false;
    _skip = 10;
    this.updateState();
//    }
  }

  onLoadMore({int categoryID, int date}) {
    if (this.status != customPopupMenu.id) {
      loadingMore = false;
      loadMoreDone = false;
      _skip = 10;
    }
    if (loadMoreDone) return;
    if (customPopupMenu != null) status = customPopupMenu.id;
    loadingMore = true;
    this.updateState();
//    int countItemLoad = 0;
    api
        .getListTicketByStatus(
            status: status,
            limit: 10,
            offset: _skip,
            categoryId: categoryID != null ? categoryID : 0,
            date: date != null ? date : 0)
        .then((list) {
      if (list.length > 0) {
        // list.forEach((historyDriver) {
        //   countItemLoad += historyDriver.listHistory.length;
        // });
        // if (countItemLoad < _take) loadMoreDone = true;
//        list.forEach((item) {
//          var listItem =
//              listTicket.where((ticket) => ticket.id == item.id).toList();
//          if (listItem.length <= 0) listTicket.insert(listItem.length, item);
//        });
        listTicket.addAll(list);
        _skip += 10;
        loadingMore = false;
//        _getImageHistory();
      } else {
        print("loadmore done");
        loadingMore = false;
        loadMoreDone = true;
        this.updateState();
      }
      //  _getImageHistoryPositions();
      this.updateState();
    });
  }

  onLoadStatusTicket(){
    listStatusTicket.clear();
    listStatusTicket.add(CustomPopupMenu(
        id: 0,
        color: Colors.blue,
        title: translation.text("TICKET_PAGE.STATUS_ALL"),
        state: MenuStatusState.ALL));
    int count = 0;
    var _listStatus = sharedPreferencesTicketStatus.getTicketStatus();
    if (_listStatus.length > 0)
      _listStatus.forEach((status) {
        listStatusTicket.add(CustomPopupMenu(
            id: status.id,
            color: listColor[count++],
            title: CustomPopupMenu.getStatusName(status.name),
            state: CustomPopupMenu.getStatus(status.name)));
      });
    CustomPopupMenu.listTicketStatus =
        listStatusTicket.sublist(1, listStatusTicket.length);
    customPopupMenu = listStatusTicket[0];
    print(listStatusTicket[0].title);
    this.updateState();
  }

  onTapCreateTicket() {
    Navigator.pushNamed(context, TicketNewPage.routeName).then((result) {
      try {
        if (result == true) {
          this.customPopupMenu = this.listStatusTicket[1];
          onLoad();
        }
      } catch (e) {
        print(e);
      }
    });
  }

//  onActivatedChangedSearchBar(bool status) {
//    print("ON_ACTIVATED");
//    this.updateState();
//  }
//
//  onCancelSearchBar() {
//    print("ON_CANCEL");
//    this.updateState();
//  }
//
//  onClearQuery() {
//    print("ON_CLEAR");
//    this.updateState();
//  }

//  onQueryChanged(String query) {
//    this.updateState();
//  }

  onQuerySubmitted(String query) {
//    print("ON_SUBMIT333");
//    print(query);
    onSearchOnline(query);
//    listTicketFiltered = _filterItemTicket(query, listTicket);
    this.updateState();
  }

  onSearchOnline(String keyWord) {
    api.searchTickets(keyword: keyWord, offset: 0, limit: 10).then((list) {
      listTicketFiltered = list;
      this.updateState();
    });
  }

//  List<HelpdeskTicket> _filterItemTicket(
//      String text, List<HelpdeskTicket> listItemTicketModel) {
//    return listItemTicketModel
//        .where((item) =>
//            compareText(item.subject, text) ||
//            compareText(item.contactName, text) ||
//            compareText(item.description, text)
//    )
//        .toList();
//  }
  onTapTicket(HelpdeskTicket helpdeskTicket) {
    Navigator.pushNamed(context, TicketDetailPage.routeName,
            arguments: helpdeskTicket.id)
        .then((result) {
      try {
        if (result) onLoad();
      } catch (e) {}
    });
  }

  onSelected(CustomPopupMenu popupMenu) {
    this.customPopupMenu = popupMenu;
    onLoad();
  }

  onTapChat() {
//    Navigator.pushNamed(
//        context, FaqDetailPage.routeName,
//        arguments: [categoryId]);
  }

  handleShowSort() {
    showSort = !showSort;
    this.updateState();
  }

  changeSortDate() {
    isAscendingDate = !isAscendingDate;
    this.updateState();
  }

  onSelectedHelpDeskCategory(HelpDeskCategory helpDeskCategory) {
    this.helpDeskCategory = helpDeskCategory;
    this.updateState();
  }

  onTapHandleSettingSort() {
    Navigator.pop(context);
    int id = helpDeskCategory.id != -1 ? helpDeskCategory.id : 0;
    int date = isAscendingDate ? 1 : 0;
    onLoad(categoryID: id, date: date);
  }

  @override
  void dispose() {
    streamSubscriptionTicketCreated.cancel();
    super.dispose();
  }
}
