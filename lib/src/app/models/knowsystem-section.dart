import 'package:flutter/material.dart';

class KnowsystemSection {
  dynamic sLastUpdate;
  dynamic active;
  List<dynamic> articleIds;
  List<dynamic> childIds;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic description;
  dynamic displayName;
  dynamic hasRightTo;
  dynamic id;
  dynamic name;
  dynamic parentId;
  dynamic sequence;
  List<dynamic> userGroupIds;
  dynamic writeDate;
  List<dynamic> writeUid;
  Color color;
  String urlIcon;

  KnowsystemSection(
      {this.color,
      this.urlIcon,
      this.sLastUpdate,
      this.active,
      this.articleIds,
      this.childIds,
      this.createDate,
      this.createUid,
      this.description,
      this.displayName,
      this.hasRightTo,
      this.id,
      this.name,
      this.parentId,
      this.sequence,
      this.userGroupIds,
      this.writeDate,
      this.writeUid});

  KnowsystemSection.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    active = json['active'];
    articleIds = json['article_ids'] is bool ? [] : json['article_ids'];
    childIds = json['child_ids'] is bool ? [] : json['child_ids'];
    createDate = json['create_date'];
    createUid = json['create_uid'] is bool ? [] : json['create_uid'];
    description = json['description'];
    displayName = json['display_name'];
    hasRightTo = json['has_right_to'];
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    sequence = json['sequence'];
    userGroupIds = json['user_group_ids'] is bool ? [] : json['user_group_ids'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'] is bool ? [] : json['write_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.active != null) data['active'] = this.active;
    if (this.articleIds != null) data['article_ids'] = this.articleIds;
    if (this.childIds != null) data['child_ids'] = this.childIds;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.description != null) data['description'] = this.description;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.hasRightTo != null) data['has_right_to'] = this.hasRightTo;
    if (this.id != null) data['id'] = this.id;
    if (this.name != null) data['name'] = this.name;
    if (this.parentId != null) data['parent_id'] = this.parentId;
    if (this.sequence != null) data['sequence'] = this.sequence;
    if (this.userGroupIds != null) data['user_group_ids'] = this.userGroupIds;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
