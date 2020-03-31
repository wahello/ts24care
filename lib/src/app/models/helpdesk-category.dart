class HelpDeskCategory {
  dynamic sLastUpdate;
  List<dynamic> categoriesTopicIds;
  dynamic createDate;
  List<dynamic> createUid;
  List<dynamic> defaultTeamId;
  dynamic description;
  dynamic displayName;
  dynamic id;
  List<dynamic> managerId;
  dynamic name;
  dynamic sequence;
  dynamic writeDate;
  List<dynamic> writeUid;

  HelpDeskCategory(
      {this.sLastUpdate,
      this.categoriesTopicIds,
      this.createDate,
      this.createUid,
      this.defaultTeamId,
      this.description,
      this.displayName,
      this.id,
      this.managerId,
      this.name,
      this.sequence,
      this.writeDate,
      this.writeUid});

  HelpDeskCategory.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    categoriesTopicIds = json['categories_topic_ids'] is bool
        ? []
        : json["categories_topic_ids"];
    createDate = json['create_date'];
    createUid = json['create_uid'] is bool ? [] : json["create_uid"];
    defaultTeamId =
        json['default_team_id'] is bool ? [] : json["default_team_id"];
    description = json['description'];
    displayName = json['display_name'];
    id = json['id'];
    managerId = json['manager_id'] is bool ? [] : json["manager_id"];
    name = json['name'];
    sequence = json['sequence'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'] is bool ? [] : json["write_uid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.categoriesTopicIds != null)
      data['categories_topic_ids'] = this.categoriesTopicIds;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.defaultTeamId != null)
      data['default_team_id'] = this.defaultTeamId;
    if (this.description != null) data['description'] = this.description;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.id != null) data['id'] = this.id;
    if (this.managerId != null) data['manager_id'] = this.managerId;
    if (this.name != null) data['name'] = this.name;
    if (this.sequence != null) data['sequence'] = this.sequence;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
