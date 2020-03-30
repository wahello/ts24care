class HelpdeskTicket {
  dynamic sLastUpdate;
  dynamic active;
  List<dynamic> attachmentIds;
  dynamic cancel;
  dynamic categoryId;
  dynamic color;
  dynamic companyId;
  dynamic contactName;
  dynamic createDate;
  dynamic createUid;
  dynamic dateClosed;
  dynamic dateDb;
  dynamic dateDeadline;
  dynamic dateLastStageUpdate;
  dynamic dateSystem;
  dynamic description;
  dynamic displayName;
  dynamic email;
  dynamic id;
  dynamic kanbanState;
  dynamic messageAttachmentCount;
  dynamic messageChannelIds;
  dynamic messageFollowerIds;
  dynamic messageHasError;
  dynamic messageHasErrorCounter;
  List<dynamic> messageIds;
  dynamic messageIsFollower;
  dynamic messageMainAttachmentId;
  dynamic messageNeedaction;
  dynamic messageNeedactionCounter;
  dynamic messagePartnerIds;
  dynamic messageUnread;
  dynamic messageUnreadCounter;
  dynamic name;
  dynamic partnerId;
  dynamic priority;
  dynamic resolve;
  dynamic reviews;
  dynamic stageId;
  dynamic subject;
  dynamic teamId;
  dynamic topicId;
  dynamic userId;
  dynamic websiteMessageIds;
  dynamic writeDate;
  dynamic writeUid;

  HelpdeskTicket(
      {this.sLastUpdate,
      this.active,
      this.attachmentIds,
      this.cancel,
      this.categoryId,
      this.color,
      this.companyId,
      this.contactName,
      this.createDate,
      this.createUid,
      this.dateClosed,
      this.dateDb,
      this.dateDeadline,
      this.dateLastStageUpdate,
      this.dateSystem,
      this.description,
      this.displayName,
      this.email,
      this.id,
      this.kanbanState,
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
      this.partnerId,
      this.priority,
      this.resolve,
      this.reviews,
      this.stageId,
      this.subject,
      this.teamId,
      this.topicId,
      this.userId,
      this.websiteMessageIds,
      this.writeDate,
      this.writeUid});

  HelpdeskTicket.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    active = json['active'];
    attachmentIds = json['attachment_ids'];
    cancel = json['cancel'];
    categoryId = json['category_id'];
    color = json['color'];
    companyId = json['company_id'];
    contactName = json['contact_name'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    dateClosed = json['date_closed'];
    dateDb = json['date_db'];
    dateDeadline = json['date_deadline'];
    dateLastStageUpdate = json['date_last_stage_update'];
    dateSystem = json['date_system'];
    description = json['description'];
    displayName = json['display_name'];
    email = json['email'] is bool ? "" : json['email'];
    id = json['id'];
    kanbanState = json['kanban_state'];
    messageAttachmentCount = json['message_attachment_count'];
    messageChannelIds = json['message_channel_ids'];
    messageFollowerIds = json['message_follower_ids'];
    messageHasError = json['message_has_error'];
    messageHasErrorCounter = json['message_has_error_counter'];
    messageIds = json['message_ids'] is bool ? [] : json['message_ids'];
    messageIsFollower = json['message_is_follower'];
    messageMainAttachmentId = json['message_main_attachment_id'];
    messageNeedaction = json['message_needaction'];
    messageNeedactionCounter = json['message_needaction_counter'];
    messagePartnerIds = json['message_partner_ids'];
    messageUnread = json['message_unread'];
    messageUnreadCounter = json['message_unread_counter'];
    name = json['name'];
    partnerId = json['partner_id'] is bool ? [] : json['partner_id'];
    priority = json['priority'];
    resolve = json['resolve'];
    reviews = json['reviews'];
    stageId = json['stage_id'];
    subject = json['subject'];
    teamId = json['team_id'];
    topicId = json['topic_id'];
    userId = json['user_id'] is bool ? [] : json['user_id'];
    websiteMessageIds = json['website_message_ids'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.active != null) data['active'] = this.active;
    if (this.attachmentIds != null) data['attachment_ids'] = this.attachmentIds;
    if (this.cancel != null) data['cancel'] = this.cancel;
    if (this.categoryId != null) data['category_id'] = this.categoryId;
    if (this.color != null) data['color'] = this.color;
    if (this.companyId != null) data['company_id'] = this.companyId;
    if (this.contactName != null) data['contact_name'] = this.contactName;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.dateClosed != null) data['date_closed'] = this.dateClosed;
    if (this.dateDb != null) data['date_db'] = this.dateDb;
    if (this.dateDeadline != null) data['date_deadline'] = this.dateDeadline;
    if (this.dateLastStageUpdate != null)
      data['date_last_stage_update'] = this.dateLastStageUpdate;
    if (this.dateSystem != null) data['date_system'] = this.dateSystem;
    if (this.description != null) data['description'] = this.description;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.email != null) data['email'] = this.email;
    if (this.id != null) data['id'] = this.id;
    if (this.kanbanState != null) data['kanban_state'] = this.kanbanState;
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
    if (this.partnerId != null) data['partner_id'] = this.partnerId;
    if (this.priority != null) data['priority'] = this.priority;
    if (this.resolve != null) data['resolve'] = this.resolve;
    if (this.reviews != null) data['reviews'] = this.reviews;
    if (this.stageId != null) data['stage_id'] = this.stageId;
    if (this.subject != null) data['subject'] = this.subject;
    if (this.teamId != null) data['team_id'] = this.teamId;
    if (this.topicId != null) data['topic_id'] = this.topicId;
    if (this.userId != null) data['user_id'] = this.userId;
    if (this.websiteMessageIds != null)
      data['website_message_ids'] = this.websiteMessageIds;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
