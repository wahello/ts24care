import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPopupMenu {
  int id;
  String title;
  Icon icon;
  CustomPopupMenu({this.id, this.title, this.icon});

  static List<CustomPopupMenu> listMenu = <CustomPopupMenu>[
    CustomPopupMenu(id: 1, title: 'Xóa' ,icon: Icon(Icons.delete, color: Colors.black45,)),
    CustomPopupMenu(id: 2, title: 'Thêm' ,icon: Icon(Icons.add))
  ];
}