import 'package:flutter/material.dart';

class ItemNewFeedModel {
  int id;
  String avatarUrl;
  String title;
  String subTitle;
  String name;
  String createDate;
  String postDate;
  String writeDate;
  String content;
  ItemNewFeedModel(
      {@required this.id,
      this.avatarUrl,
      this.title,
      this.subTitle,
      this.name,
      this.createDate,
      this.postDate,
      this.writeDate,
      this.content});
  copyWith(ItemNewFeedModel itemNewFeedModel){
    id = itemNewFeedModel.id;
    avatarUrl = itemNewFeedModel.avatarUrl;
    title = itemNewFeedModel.title;
    subTitle = itemNewFeedModel.subTitle;
    name = itemNewFeedModel.name;
    createDate = itemNewFeedModel.createDate;
    postDate = itemNewFeedModel.postDate;
    writeDate = itemNewFeedModel.writeDate;
    content = itemNewFeedModel.content;
  }
  static List<ItemNewFeedModel> listItemNewFeedModel = [
    ItemNewFeedModel(
        title: "Alway on care, for your device",
        avatarUrl:
            "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg"),
    ItemNewFeedModel(
        title: "Samsung keyboard",
        avatarUrl:
            "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg"),
    ItemNewFeedModel(
        title: "Scene optimize mode",
        avatarUrl:
            "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg"),
    ItemNewFeedModel(
        title: "The framming effect",
        avatarUrl:
            "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg"),
    ItemNewFeedModel(
        title: "Alway on care, for your device",
        avatarUrl:
            "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg"),
  ];
}
