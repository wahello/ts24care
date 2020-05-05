class WkTeam {
  dynamic sLastUpdate;
  List<dynamic> childIds;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic departmentId;
  dynamic description;
  dynamic displayName;
  dynamic id;
  List<dynamic> manager;
  List<dynamic> members;
  dynamic messageAttachmentCount;
  List<dynamic> messageChannelIds;
  List<dynamic> messageFollowerIds;
  dynamic messageHasError;
  dynamic messageHasErrorCounter;
  List<dynamic> messageIds;
  dynamic messageIsFollower;
  dynamic messageMainAttachmentId;
  dynamic messageNeedaction;
  dynamic messageNeedactionCounter;
  List<dynamic> messagePartnerIds;
  dynamic messageUnread;
  dynamic messageUnreadCounter;
  dynamic name;
  dynamic parentId;
  dynamic projectCount;
  List<dynamic> projectIds;
  dynamic teamEmail;
  dynamic ticketCount;
  List<dynamic> ticketIds;
  List<dynamic> websiteMessageIds;
  dynamic writeDate;
  List<dynamic> writeUid;

  WkTeam(
      {this.sLastUpdate,
      this.childIds,
      this.createDate,
      this.createUid,
      this.departmentId,
      this.description,
      this.displayName,
      this.id,
      this.manager,
      this.members,
      this.messageAttachmentCount,
      this.messageChannelIds,
      this.messageFollowerIds,
      this.messageHasError,
      this.messageHasErrorCounter,
      this.messageIds,
      this.messageIsFollower,
      this.messageMainAttachmentId,
      this.messageNeedaction,
      this.messageNeedactionCounter,
      this.messagePartnerIds,
      this.messageUnread,
      this.messageUnreadCounter,
      this.name,
      this.parentId,
      this.projectCount,
      this.projectIds,
      this.teamEmail,
      this.ticketCount,
      this.ticketIds,
      this.websiteMessageIds,
      this.writeDate,
      this.writeUid});

  WkTeam.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    childIds = json['child_ids'] is bool ? [] : json["child_ids"];
    createDate = json['create_date'];
    createUid = json['create_uid'] is bool ? [] : json["create_uid"];
    departmentId = json['department_id'];
    description = json['description'];
    displayName = json['display_name'];
    id = json['id'];
    manager = json['manager'] is bool ? [] : json["manager"];
    members = json['members'] is bool ? [] : json["members"];
    messageAttachmentCount = json['message_attachment_count'];
    messageChannelIds =
        json['message_channel_ids'] is bool ? [] : json["message_channel_ids"];
    messageFollowerIds = json['message_follower_ids'] is bool
        ? []
        : json["message_follower_ids"];
    messageHasError = json['message_has_error'];
    messageHasErrorCounter = json['message_has_error_counter'];
    messageIds = json['message_ids'] is bool ? [] : json["message_ids"];
    messageIsFollower = json['message_is_follower'];
    messageMainAttachmentId = json['message_main_attachment_id'];
    messageNeedaction = json['message_needaction'];
    messageNeedactionCounter = json['message_needaction_counter'];
    messagePartnerIds =
        json['message_partner_ids'] is bool ? [] : json["message_partner_ids"];
    messageUnread = json['message_unread'];
    messageUnreadCounter = json['message_unread_counter'];
    name = json['name'];
    parentId = json['parent_id'];
    projectCount = json['project_count'];
    projectIds = json['project_ids'] is bool ? [] : json["project_ids"];
    teamEmail = json['team_email'];
    ticketCount = json['ticket_count'];
    ticketIds = json['ticket_ids'] is bool ? [] : json["ticket_ids"];
    websiteMessageIds =
        json['website_message_ids'] is bool ? [] : json["website_message_ids"];
    writeDate = json['write_date'];
    writeUid = json['write_uid'] is bool ? [] : json["write_uid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.childIds != null) data['child_ids'] = this.childIds;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.departmentId != null) data['department_id'] = this.departmentId;
    if (this.description != null) data['description'] = this.description;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.id != null) data['id'] = this.id;
    if (this.manager != null) data['manager'] = this.manager;
    if (this.members != null) data['members'] = this.members;
    if (this.messageAttachmentCount != null)
      data['message_attachment_count'] = this.messageAttachmentCount;
    if (this.messageChannelIds != null)
      data['message_channel_ids'] = this.messageChannelIds;
    if (this.messageFollowerIds != null)
      data['message_follower_ids'] = this.messageFollowerIds;
    if (this.messageHasError != null)
      data['message_has_error'] = this.messageHasError;
    if (this.messageHasErrorCounter != null)
      data['message_has_error_counter'] = this.messageHasErrorCounter;
    if (this.messageIds != null) data['message_ids'] = this.messageIds;
    if (this.messageIsFollower != null)
      data['message_is_follower'] = this.messageIsFollower;
    if (this.messageMainAttachmentId != null)
      data['message_main_attachment_id'] = this.messageMainAttachmentId;
    if (this.messageNeedaction != null)
      data['message_needaction'] = this.messageNeedaction;
    if (this.messageNeedactionCounter != null)
      data['message_needaction_counter'] = this.messageNeedactionCounter;
    if (this.messagePartnerIds != null)
      data['message_partner_ids'] = this.messagePartnerIds;
    if (this.messageUnread != null) data['message_unread'] = this.messageUnread;
    if (this.messageUnreadCounter != null)
      data['message_unread_counter'] = this.messageUnreadCounter;
    if (this.name != null) data['name'] = this.name;
    if (this.parentId != null) data['parent_id'] = this.parentId;
    if (this.projectCount != null) data['project_count'] = this.projectCount;
    if (this.projectIds != null) data['project_ids'] = this.projectIds;
    if (this.teamEmail != null) data['team_email'] = this.teamEmail;
    if (this.ticketCount != null) data['ticket_count'] = this.ticketCount;
    if (this.ticketIds != null) data['ticket_ids'] = this.ticketIds;
    if (this.websiteMessageIds != null)
      data['website_message_ids'] = this.websiteMessageIds;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
