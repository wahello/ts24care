import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MenuAttachmentState {
  CAMERA,
  IMAGE,
  FILE,
}

class CustomPopupMenu {
  int id;
  String title;
  String subTitle;
  IconData iconData;
  var state;
  CustomPopupMenu({this.id, this.title, this.subTitle, this.iconData, this.state});

  static List<CustomPopupMenu> listMenu = <CustomPopupMenu>[
    CustomPopupMenu(id: 1, title: 'Xóa', iconData: Icons.delete),
    CustomPopupMenu(id: 2, title: 'Thêm', iconData: Icons.add)
  ];
  static List<CustomPopupMenu> listMenuAttachment = [
    CustomPopupMenu(
        id: 0,
        title: 'Camera',
        iconData: Icons.photo_camera,
        state: MenuAttachmentState.CAMERA),
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
}
