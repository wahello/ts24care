import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/pages/ticket/detail/ticket_detail_page.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page.dart';

class TicketPageViewModel extends ViewModelBase {
  List<HelpdeskTicket> listTicketFiltered = List();
  List<HelpdeskTicket> listTicket = List();
  List<CustomPopupMenu> listStatusTicket = List();
  CustomPopupMenu customPopupMenu = CustomPopupMenu.listTicketStatus[0];
  List<Color> listColor = [
    Colors.blue,
    Colors.orange,
    Colors.grey[400],
    Colors.red,
    Colors.purple,
    Colors.pinkAccent,
    Colors.yellow
  ];
  TicketPageViewModel() {
    onLoadStatusTicket();
    onLoad(0);
  }

  onLoad(int status) async {
    loading = true;
    this.updateState();
    var _listTicket =
        await api.getListTicketByStatus(status: status, offset: 0, limit: 10);
//    if (_listTicket.length > 0) {
    listTicket = _listTicket;
    loading = false;
    this.updateState();
//    }
  }

  onLoadStatusTicket() async {
    listStatusTicket.clear();
    listStatusTicket.add(CustomPopupMenu(
        id: 0,
        color: Colors.green,
        title: "Tất cả",
        state: MenuStatusState.ALL));
    int count = 0;
    var _listStatus = await api.getStatusTicket();
    if (_listStatus.length > 0)
      _listStatus.forEach((status) {
        listStatusTicket.add(CustomPopupMenu(
            id: status.id,
            color: listColor[count++],
            title: CustomPopupMenu.getStatusNameFromId(status.id),
            state: CustomPopupMenu.getStatus(status.id)));
      });
    CustomPopupMenu.listTicketStatus =
        listStatusTicket.sublist(1, listStatusTicket.length);
    customPopupMenu = listStatusTicket[0];
    this.updateState();
  }

  onTapCreateTicket() {
    Navigator.pushNamed(context, TicketNewPage.routeName).then((result) {
      if (result != null && result) {
        onLoad(0);
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
        arguments: helpdeskTicket);
  }

  onSelected(CustomPopupMenu popupMenu) {
    this.customPopupMenu = popupMenu;
    switch (popupMenu.state) {
      case MenuStatusState.ALL:
        onLoad(0);
        break;
      case MenuStatusState.NEW:
        onLoad(1);
        break;
      case MenuStatusState.IN_PROGRESS:
        onLoad(2);
        break;
      case MenuStatusState.SOLVED:
        onLoad(3);
        break;
      case MenuStatusState.CANCEL:
        onLoad(4);
        break;
    }
  }

  onTapChat() {
//    Navigator.pushNamed(
//        context, FaqDetailPage.routeName,
//        arguments: [categoryId]);
  }
}
