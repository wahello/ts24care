import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';

enum MenuAttachmentState {
  IMAGE,
  FILE,
}
enum MenuStatusState { NEW, IN_PROGRESS, SOLVED, CANCEL, ALL }

class CustomPopupMenu {
  int id;
  String title;
  String subTitle;
  IconData iconData;
  Color color;
  var state;
  CustomPopupMenu(
      {this.id,
      this.title,
      this.subTitle,
      this.iconData,
      this.state,
      this.color});
  static List<String> status = [
    translation.text("TICKET_PAGE.STATUS.ALL"),
    translation.text("TICKET_PAGE.STATUS_NEW"),
    translation.text("TICKET_PAGE.STATUS_IN_PROGRESS"),
    translation.text("TICKET_PAGE.STATUS_SOLVED"),
    translation.text("TICKET_PAGE.STATUS_CANCELED"),
  ];
  static List<CustomPopupMenu> listMenu = <CustomPopupMenu>[
    CustomPopupMenu(id: 1, title: translation.text("TICKET_PAGE.ADD"), iconData: Icons.delete),
    CustomPopupMenu(id: 2, title: translation.text("TICKET_PAGE.DELETE"), iconData: Icons.add)
  ];
  static List<CustomPopupMenu> listMenuAttachment = [
    CustomPopupMenu(
        id: 1,
        title: translation.text("TICKET_PAGE.IMAGE"),
        iconData: Icons.photo,
        state: MenuAttachmentState.IMAGE),
    CustomPopupMenu(
        id: 2,
        title: translation.text("TICKET_PAGE.FILE"),
        iconData: Icons.insert_drive_file,
        state: MenuAttachmentState.FILE),
  ];
  static List<CustomPopupMenu> listTicketStatus = [
    CustomPopupMenu(
        id: 1,
        title: status[1],
        state: MenuStatusState.NEW,
        color: Colors.orange[400]),
    CustomPopupMenu(
        id: 2,
        title: status[2],
        state: MenuStatusState.IN_PROGRESS,
        color: Colors.blue),
    CustomPopupMenu(
        id: 3,
        title: status[3],
        state: MenuStatusState.SOLVED,
        color: Colors.grey[400]),
    CustomPopupMenu(
        id: 4,
        title: status[4],
        state: MenuStatusState.CANCEL,
        color: Colors.red),
  ];
  static MenuStatusState getStatus(String name) {
    MenuStatusState state = MenuStatusState.NEW;
    switch (name.toLowerCase()) {
      case 'all':
        state = MenuStatusState.ALL;
        break;
      case 'new':
        state = MenuStatusState.NEW;
        break;
      case 'inprogress':
        state = MenuStatusState.IN_PROGRESS;
        break;
      case 'solved':
        state = MenuStatusState.SOLVED;
        break;
      case 'canceled':
        state = MenuStatusState.CANCEL;
        break;
    }
    return state;
  }

  static CustomPopupMenu getTicket(int id) {
    CustomPopupMenu customPopupMenu =
        listTicketStatus.firstWhere((item) => item.id == id);
    if (customPopupMenu != null) return customPopupMenu;
    return listTicketStatus[0];
  }

  static getStatusName(String name) {
    String state = status[1];
    switch (name.toLowerCase()) {
      case 'all':
        state = status[0];
        break;
      case 'new':
        state = status[1];
        break;
      case 'inprogress':
        state = status[2];
        break;
      case 'solved':
        state = status[3];
        break;
      case 'canceled':
        state = status[4];
        break;
    }
    return state;
  }
  static reLoad(){
    listMenu =  <CustomPopupMenu>[
      CustomPopupMenu(id: 1, title: translation.text("TICKET_PAGE.ADD"), iconData: Icons.delete),
      CustomPopupMenu(id: 2, title: translation.text("TICKET_PAGE.DELETE"), iconData: Icons.add)
    ];
    listMenuAttachment = [
      CustomPopupMenu(
          id: 1,
          title: translation.text("TICKET_PAGE.IMAGE"),
          iconData: Icons.photo,
          state: MenuAttachmentState.IMAGE),
      CustomPopupMenu(
          id: 2,
          title: translation.text("TICKET_PAGE.FILE"),
          iconData: Icons.insert_drive_file,
          state: MenuAttachmentState.FILE),
    ];
    status = [
      translation.text("TICKET_PAGE.STATUS.ALL"),
      translation.text("TICKET_PAGE.STATUS_NEW"),
      translation.text("TICKET_PAGE.STATUS_IN_PROGRESS"),
      translation.text("TICKET_PAGE.STATUS_SOLVED"),
      translation.text("TICKET_PAGE.STATUS_CANCELED"),
    ];
  }
}
