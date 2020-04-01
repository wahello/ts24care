import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  static List<CustomPopupMenu> listMenu = <CustomPopupMenu>[
    CustomPopupMenu(id: 1, title: 'Xóa', iconData: Icons.delete),
    CustomPopupMenu(id: 2, title: 'Thêm', iconData: Icons.add)
  ];
  static List<CustomPopupMenu> listMenuAttachment = [
    CustomPopupMenu(
        id: 1,
        title: 'Image',
        iconData: Icons.photo,
        state: MenuAttachmentState.IMAGE),
    CustomPopupMenu(
        id: 2,
        title: 'File',
        iconData: Icons.insert_drive_file,
        state: MenuAttachmentState.FILE),
  ];
  static List<CustomPopupMenu> listTicketStatus = [
    CustomPopupMenu(
        id: 1,
        title: 'New',
        state: MenuStatusState.NEW,
        color: Colors.orange[400]),
    CustomPopupMenu(
        id: 2,
        title: 'In progress',
        state: MenuStatusState.IN_PROGRESS,
        color: Colors.blue),
    CustomPopupMenu(
        id: 3,
        title: 'Solved',
        state: MenuStatusState.SOLVED,
        color: Colors.grey[400]),
    CustomPopupMenu(
        id: 4,
        title: 'Cancel',
        state: MenuStatusState.CANCEL,
        color: Colors.red),
  ];
  static MenuStatusState getStatus(int id) {
    MenuStatusState state = MenuStatusState.NEW;
    switch (id) {
      case 0:
        state = MenuStatusState.ALL;
        break;
      case 1:
        state = MenuStatusState.NEW;
        break;
      case 2:
        state = MenuStatusState.IN_PROGRESS;
        break;
      case 3:
        state = MenuStatusState.SOLVED;
        break;
      case 4:
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

  static getStatusNameFromId(int id) {
    String state = "Mới";
    switch (id) {
      case 0:
        state = "Tất cả";
        break;
      case 1:
        state = "Mới";
        break;
      case 2:
        state = "Đang xử lý";
        break;
      case 3:
        state = "Đã giải quyết";
        break;
      case 4:
        state = "Hủy bỏ";
        break;
    }
    return state;
  }
}
