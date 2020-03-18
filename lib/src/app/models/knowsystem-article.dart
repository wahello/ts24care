class KnowsystemArticle {
  dynamic sLastUpdate;
  dynamic accessToken;
  dynamic accessUrl;
  List<dynamic> accessUserIds;
  dynamic accessWarning;
  dynamic active;
  dynamic activityDateDeadline;
  List<dynamic> activityIds;
  dynamic activityState;
  dynamic activitySummary;
  dynamic activityTypeId;
  dynamic activityUserId;
  List<dynamic> attachmentIds;
  List<dynamic> contributorIds;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic description;
  List<dynamic> dislikeUserIds;
  dynamic dislikesNumber;
  dynamic displayName;
  List<dynamic> favouriteUserIds;
  dynamic id;
  dynamic indexedDescription;
  dynamic internalUrl;
  dynamic isPublished;
  dynamic isSeoOptimized;
  dynamic kanbanDescription;
  List<dynamic> likeUserIds;
  dynamic likesNumber;
  dynamic likesScore;
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
  dynamic portalHasRightTo;
  List<dynamic> revisionIds;
  List<dynamic> sectionId;
  List<dynamic> tagIds;
  dynamic thisUserLikeState;
  dynamic usedInEmailCompose;
  List<dynamic> userGroupIds;
  dynamic viewsNumberInternal;
  List<dynamic> websiteMessageIds;
  dynamic websiteMetaDescription;
  dynamic websiteMetaKeywords;
  dynamic websiteMetaOgImg;
  dynamic websiteMetaTitle;
  dynamic websitePublished;
  dynamic websiteUrl;
  dynamic writeDate;
  dynamic writeRevisionDate;
  List<dynamic> writeRevisionUid;
  List<dynamic> writeUid;

  KnowsystemArticle(
      {this.sLastUpdate,
      this.accessToken,
      this.accessUrl,
      this.accessUserIds,
      this.accessWarning,
      this.active,
      this.activityDateDeadline,
      this.activityIds,
      this.activityState,
      this.activitySummary,
      this.activityTypeId,
      this.activityUserId,
      this.attachmentIds,
      this.contributorIds,
      this.createDate,
      this.createUid,
      this.description,
      this.dislikeUserIds,
      this.dislikesNumber,
      this.displayName,
      this.favouriteUserIds,
      this.id,
      this.indexedDescription,
      this.internalUrl,
      this.isPublished,
      this.isSeoOptimized,
      this.kanbanDescription,
      this.likeUserIds,
      this.likesNumber,
      this.likesScore,
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
      this.portalHasRightTo,
      this.revisionIds,
      this.sectionId,
      this.tagIds,
      this.thisUserLikeState,
      this.usedInEmailCompose,
      this.userGroupIds,
      this.viewsNumberInternal,
      this.websiteMessageIds,
      this.websiteMetaDescription,
      this.websiteMetaKeywords,
      this.websiteMetaOgImg,
      this.websiteMetaTitle,
      this.websitePublished,
      this.websiteUrl,
      this.writeDate,
      this.writeRevisionDate,
      this.writeRevisionUid,
      this.writeUid});

  KnowsystemArticle.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    accessToken = json['access_token'];
    accessUrl = json['access_url'];
    accessUserIds = json['access_user_ids'];
    accessWarning = json['access_warning'];
    active = json['active'];
    activityDateDeadline = json['activity_date_deadline'];
    activityIds = json['activity_ids'];
    activityState = json['activity_state'];
    activitySummary = json['activity_summary'];
    activityTypeId = json['activity_type_id'];
    activityUserId = json['activity_user_id'];
    attachmentIds = json['attachment_ids'];
    contributorIds = json['contributor_ids'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    description = json['description'];
    dislikeUserIds = json['dislike_user_ids'];
    dislikesNumber = json['dislikes_number'];
    displayName = json['display_name'];
    favouriteUserIds = json['favourite_user_ids'];
    id = json['id'];
    indexedDescription = json['indexed_description'];
    internalUrl = json['internal_url'];
    isPublished = json['is_published'];
    isSeoOptimized = json['is_seo_optimized'];
    kanbanDescription = json['kanban_description'];
    likeUserIds = json['like_user_ids'];
    likesNumber = json['likes_number'];
    likesScore = json['likes_score'];
    messageAttachmentCount = json['message_attachment_count'];
    messageChannelIds = json['message_channel_ids'];
    messageFollowerIds = json['message_follower_ids'];
    messageHasError = json['message_has_error'];
    messageHasErrorCounter = json['message_has_error_counter'];
    messageIds = json['message_ids'];
    messageIsFollower = json['message_is_follower'];
    messageMainAttachmentId = json['message_main_attachment_id'];
    messageNeedaction = json['message_needaction'];
    messageNeedactionCounter = json['message_needaction_counter'];
    messagePartnerIds = json['message_partner_ids'];
    messageUnread = json['message_unread'];
    messageUnreadCounter = json['message_unread_counter'];
    name = json['name'];
    portalHasRightTo = json['portal_has_right_to'];
    revisionIds = json['revision_ids'];
    sectionId = json['section_id'];
    tagIds = json['tag_ids'];
    thisUserLikeState = json['this_user_like_state'];
    usedInEmailCompose = json['used_in_email_compose'];
    userGroupIds = json['user_group_ids'];
    viewsNumberInternal = json['views_number_internal'];
    websiteMessageIds = json['website_message_ids'];
    websiteMetaDescription = json['website_meta_description'];
    websiteMetaKeywords = json['website_meta_keywords'];
    websiteMetaOgImg = json['website_meta_og_img'];
    websiteMetaTitle = json['website_meta_title'];
    websitePublished = json['website_published'];
    websiteUrl = json['website_url'];
    writeDate = json['write_date'];
    writeRevisionDate = json['write_revision_date'];
    writeRevisionUid = json['write_revision_uid'];
    writeUid = json['write_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.accessToken != null) data['access_token'] = this.accessToken;
    if (this.accessUrl != null) data['access_url'] = this.accessUrl;
    if (this.accessUserIds != null)
      data['access_user_ids'] = this.accessUserIds;
    if (this.accessWarning != null) data['access_warning'] = this.accessWarning;
    if (this.active != null) data['active'] = this.active;
    if (this.activityDateDeadline != null)
      data['activity_date_deadline'] = this.activityDateDeadline;
    if (this.activityIds != null) data['activity_ids'] = this.activityIds;
    if (this.activityState != null) data['activity_state'] = this.activityState;
    if (this.activitySummary != null)
      data['activity_summary'] = this.activitySummary;
    if (this.activityTypeId != null)
      data['activity_type_id'] = this.activityTypeId;
    if (this.activityUserId != null)
      data['activity_user_id'] = this.activityUserId;
    if (this.attachmentIds != null) data['attachment_ids'] = this.attachmentIds;
    if (this.contributorIds != null)
      data['contributor_ids'] = this.contributorIds;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.description != null) data['description'] = this.description;
    if (this.dislikeUserIds != null)
      data['dislike_user_ids'] = this.dislikeUserIds;
    if (this.dislikesNumber != null)
      data['dislikes_number'] = this.dislikesNumber;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.favouriteUserIds != null)
      data['favourite_user_ids'] = this.favouriteUserIds;
    if (this.id != null) data['id'] = this.id;
    if (this.indexedDescription != null)
      data['indexed_description'] = this.indexedDescription;
    if (this.internalUrl != null) data['internal_url'] = this.internalUrl;
    if (this.isPublished != null) data['is_published'] = this.isPublished;
    if (this.isSeoOptimized != null)
      data['is_seo_optimized'] = this.isSeoOptimized;
    if (this.kanbanDescription != null)
      data['kanban_description'] = this.kanbanDescription;
    if (this.likeUserIds != null) data['like_user_ids'] = this.likeUserIds;
    if (this.likesNumber != null) data['likes_number'] = this.likesNumber;
    if (this.likesScore != null) data['likes_score'] = this.likesScore;
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
    if (this.portalHasRightTo != null)
      data['portal_has_right_to'] = this.portalHasRightTo;
    if (this.revisionIds != null) data['revision_ids'] = this.revisionIds;
    if (this.sectionId != null) data['section_id'] = this.sectionId;
    if (this.tagIds != null) data['tag_ids'] = this.tagIds;
    if (this.thisUserLikeState != null)
      data['this_user_like_state'] = this.thisUserLikeState;
    if (this.usedInEmailCompose != null)
      data['used_in_email_compose'] = this.usedInEmailCompose;
    if (this.userGroupIds != null) data['user_group_ids'] = this.userGroupIds;
    if (this.viewsNumberInternal != null)
      data['views_number_internal'] = this.viewsNumberInternal;
    if (this.websiteMessageIds != null)
      data['website_message_ids'] = this.websiteMessageIds;
    if (this.websiteMetaDescription != null)
      data['website_meta_description'] = this.websiteMetaDescription;
    if (this.websiteMetaKeywords != null)
      data['website_meta_keywords'] = this.websiteMetaKeywords;
    if (this.websiteMetaOgImg != null)
      data['website_meta_og_img'] = this.websiteMetaOgImg;
    if (this.websiteMetaTitle != null)
      data['website_meta_title'] = this.websiteMetaTitle;
    if (this.websitePublished != null)
      data['website_published'] = this.websitePublished;
    if (this.websiteUrl != null) data['website_url'] = this.websiteUrl;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeRevisionDate != null)
      data['write_revision_date'] = this.writeRevisionDate;
    if (this.writeRevisionUid != null)
      data['write_revision_uid'] = this.writeRevisionUid;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
