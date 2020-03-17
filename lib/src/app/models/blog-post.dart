class BlogPost {
  dynamic sLastUpdate;
  dynamic active;
  dynamic authorAvatar;
  List<dynamic> authorId;
  List<dynamic> blogId;
  dynamic content;
  dynamic coverProperties;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic displayName;
  dynamic id;
  dynamic isPublished;
  dynamic isSeoOptimized;
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
  dynamic postDate;
  dynamic publishedDate;
  dynamic ranking;
  dynamic subtitle;
  List<dynamic> tagIds;
  dynamic teaser;
  dynamic teaserManual;
  dynamic visits;
  dynamic websiteId;
  List<dynamic> websiteMessageIds;
  dynamic websiteMetaDescription;
  dynamic websiteMetaKeywords;
  dynamic websiteMetaOgImg;
  dynamic websiteMetaTitle;
  dynamic websitePublished;
  dynamic websiteUrl;
  dynamic writeDate;
  List<dynamic> writeUid;

  BlogPost(
      {this.sLastUpdate,
      this.active,
      this.authorAvatar,
      this.authorId,
      this.blogId,
      this.content,
      this.coverProperties,
      this.createDate,
      this.createUid,
      this.displayName,
      this.id,
      this.isPublished,
      this.isSeoOptimized,
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
      this.postDate,
      this.publishedDate,
      this.ranking,
      this.subtitle,
      this.tagIds,
      this.teaser,
      this.teaserManual,
      this.visits,
      this.websiteId,
      this.websiteMessageIds,
      this.websiteMetaDescription,
      this.websiteMetaKeywords,
      this.websiteMetaOgImg,
      this.websiteMetaTitle,
      this.websitePublished,
      this.websiteUrl,
      this.writeDate,
      this.writeUid});

  BlogPost.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    active = json['active'];
    authorAvatar = json['author_avatar'];
    authorId = json['author_id'];
    blogId = json['blog_id'];
    content = json['content'];
    coverProperties = json['cover_properties'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    displayName = json['display_name'];
    id = json['id'];
    isPublished = json['is_published'];
    isSeoOptimized = json['is_seo_optimized'];
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
    postDate = json['post_date'];
    publishedDate = json['published_date'];
    ranking = json['ranking'];
    subtitle = json['subtitle'];
    tagIds = json['tag_ids'];
    teaser = json['teaser'];
    teaserManual = json['teaser_manual'];
    visits = json['visits'];
    websiteId = json['website_id'];
    websiteMessageIds = json['website_message_ids'];
    websiteMetaDescription = json['website_meta_description'];
    websiteMetaKeywords = json['website_meta_keywords'];
    websiteMetaOgImg = json['website_meta_og_img'];
    websiteMetaTitle = json['website_meta_title'];
    websitePublished = json['website_published'];
    websiteUrl = json['website_url'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.active != null) data['active'] = this.active;
    if (this.authorAvatar != null) data['author_avatar'] = this.authorAvatar;
    if (this.authorId != null) data['author_id'] = this.authorId;
    if (this.blogId != null) data['blog_id'] = this.blogId;
    if (this.content != null) data['content'] = this.content;
    if (this.coverProperties != null)
      data['cover_properties'] = this.coverProperties;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.id != null) data['id'] = this.id;
    if (this.isPublished != null) data['is_published'] = this.isPublished;
    if (this.isSeoOptimized != null)
      data['is_seo_optimized'] = this.isSeoOptimized;
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
    if (this.postDate != null) data['post_date'] = this.postDate;
    if (this.publishedDate != null) data['published_date'] = this.publishedDate;
    if (this.ranking != null) data['ranking'] = this.ranking;
    if (this.subtitle != null) data['subtitle'] = this.subtitle;
    if (this.tagIds != null) data['tag_ids'] = this.tagIds;
    if (this.teaser != null) data['teaser'] = this.teaser;
    if (this.teaserManual != null) data['teaser_manual'] = this.teaserManual;
    if (this.visits != null) data['visits'] = this.visits;
    if (this.websiteId != null) data['website_id'] = this.websiteId;
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
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
