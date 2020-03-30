class MailMessage {
  dynamic sLastUpdate;
  dynamic addSign;
  List<dynamic> attachmentIds;
  dynamic authorAvatar;
  dynamic authorId;
  dynamic body;
  dynamic channelIds;
  dynamic childIds;
  dynamic createDate;
  dynamic createUid;
  dynamic date;
  dynamic description;
  dynamic displayName;
  dynamic emailFrom;
  dynamic hasError;
  dynamic id;
  dynamic layout;
  dynamic mailActivityTypeId;
  dynamic mailServerId;
  dynamic messageId;
  dynamic messageType;
  dynamic model;
  dynamic moderationStatus;
  dynamic moderatorId;
  dynamic needModeration;
  dynamic needaction;
  dynamic needactionPartnerIds;
  dynamic noAutoThread;
  dynamic notificationIds;
  dynamic parentId;
  dynamic partnerIds;
  dynamic ratingIds;
  dynamic ratingValue;
  dynamic recordName;
  dynamic replyTo;
  dynamic resId;
  dynamic starred;
  dynamic starredPartnerIds;
  dynamic subject;
  dynamic subtypeId;
  dynamic websitePublished;
  dynamic writeDate;
  dynamic writeUid;

  MailMessage(
      {this.sLastUpdate,
      this.addSign,
      this.attachmentIds,
      this.authorAvatar,
      this.authorId,
      this.body,
      this.channelIds,
      this.childIds,
      this.createDate,
      this.createUid,
      this.date,
      this.description,
      this.displayName,
      this.emailFrom,
      this.hasError,
      this.id,
      this.layout,
      this.mailActivityTypeId,
      this.mailServerId,
      this.messageId,
      this.messageType,
      this.model,
      this.moderationStatus,
      this.moderatorId,
      this.needModeration,
      this.needaction,
      this.needactionPartnerIds,
      this.noAutoThread,
      this.notificationIds,
      this.parentId,
      this.partnerIds,
      this.ratingIds,
      this.ratingValue,
      this.recordName,
      this.replyTo,
      this.resId,
      this.starred,
      this.starredPartnerIds,
      this.subject,
      this.subtypeId,
      this.websitePublished,
      this.writeDate,
      this.writeUid});

  MailMessage.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    addSign = json['add_sign'];
    attachmentIds = json['attachment_ids'];
    authorAvatar = json['author_avatar'];
    authorId = json['author_id'];
    body = json['body'];
    channelIds = json['channel_ids'];
    childIds = json['child_ids'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    date = json['date'];
    description = json['description'];
    displayName = json['display_name'];
    emailFrom = json['email_from'];
    hasError = json['has_error'];
    id = json['id'];
    layout = json['layout'];
    mailActivityTypeId = json['mail_activity_type_id'];
    mailServerId = json['mail_server_id'];
    messageId = json['message_id'];
    messageType = json['message_type'];
    model = json['model'];
    moderationStatus = json['moderation_status'];
    moderatorId = json['moderator_id'];
    needModeration = json['need_moderation'];
    needaction = json['needaction'];
    needactionPartnerIds = json['needaction_partner_ids'];
    noAutoThread = json['no_auto_thread'];
    notificationIds = json['notification_ids'];
    parentId = json['parent_id'];
    partnerIds = json['partner_ids'];
    ratingIds = json['rating_ids'];
    ratingValue = json['rating_value'];
    recordName = json['record_name'];
    replyTo = json['reply_to'];
    resId = json['res_id'];
    starred = json['starred'];
    starredPartnerIds = json['starred_partner_ids'];
    subject = json['subject'];
    subtypeId = json['subtype_id'];
    websitePublished = json['website_published'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.addSign != null) data['add_sign'] = this.addSign;
    if (this.attachmentIds != null) data['attachment_ids'] = this.attachmentIds;
    if (this.authorAvatar != null) data['author_avatar'] = this.authorAvatar;
    if (this.authorId != null) data['author_id'] = this.authorId;
    if (this.body != null) data['body'] = this.body;
    if (this.channelIds != null) data['channel_ids'] = this.channelIds;
    if (this.childIds != null) data['child_ids'] = this.childIds;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.date != null) data['date'] = this.date;
    if (this.description != null) data['description'] = this.description;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.emailFrom != null) data['email_from'] = this.emailFrom;
    if (this.hasError != null) data['has_error'] = this.hasError;
    if (this.id != null) data['id'] = this.id;
    if (this.layout != null) data['layout'] = this.layout;
    if (this.mailActivityTypeId != null)
      data['mail_activity_type_id'] = this.mailActivityTypeId;
    if (this.mailServerId != null) data['mail_server_id'] = this.mailServerId;
    if (this.messageId != null) data['message_id'] = this.messageId;
    if (this.messageType != null) data['message_type'] = this.messageType;
    if (this.model != null) data['model'] = this.model;
    if (this.moderationStatus != null)
      data['moderation_status'] = this.moderationStatus;
    if (this.moderatorId != null) data['moderator_id'] = this.moderatorId;
    if (this.needModeration != null)
      data['need_moderation'] = this.needModeration;
    if (this.needaction != null) data['needaction'] = this.needaction;
    if (this.needactionPartnerIds != null)
      data['needaction_partner_ids'] = this.needactionPartnerIds;
    if (this.noAutoThread != null) data['no_auto_thread'] = this.noAutoThread;
    if (this.notificationIds != null)
      data['notification_ids'] = this.notificationIds;
    if (this.parentId != null) data['parent_id'] = this.parentId;
    if (this.partnerIds != null) data['partner_ids'] = this.partnerIds;
    if (this.ratingIds != null) data['rating_ids'] = this.ratingIds;
    if (this.ratingValue != null) data['rating_value'] = this.ratingValue;
    if (this.recordName != null) data['record_name'] = this.recordName;
    if (this.replyTo != null) data['reply_to'] = this.replyTo;
    if (this.resId != null) data['res_id'] = this.resId;
    if (this.starred != null) data['starred'] = this.starred;
    if (this.starredPartnerIds != null)
      data['starred_partner_ids'] = this.starredPartnerIds;
    if (this.subject != null) data['subject'] = this.subject;
    if (this.subtypeId != null) data['subtype_id'] = this.subtypeId;
    if (this.websitePublished != null)
      data['website_published'] = this.websitePublished;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
