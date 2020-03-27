import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemHelpModel{
  final IconData icon;
  final String textName;
  ItemHelpModel({this.icon, this.textName});
  static List<ItemHelpModel> listItemHelpModel = [
    ItemHelpModel(
      icon: Icons.battery_full,
      textName: "Power"
    ),ItemHelpModel(
      icon: Icons.chat_bubble,
      textName: "Chat"
    ),ItemHelpModel(
      icon: Icons.apps,
      textName: "Application"
    ),ItemHelpModel(
      icon: Icons.phone_iphone,
      textName: "Phone"
    ),ItemHelpModel(
      icon: Icons.settings,
      textName: "Setting/system"
    ),ItemHelpModel(
      icon: Icons.g_translate,
      textName: "Language"
    ),ItemHelpModel(
      icon: Icons.radio,
      textName: "Radio"
    ),ItemHelpModel(
      icon: Icons.favorite,
      textName: "Life"
    ),ItemHelpModel(
      icon: Icons.home,
      textName: "Life"
    ),ItemHelpModel(
      icon: Icons.work,
      textName: "Life"
    ),
  ];
}