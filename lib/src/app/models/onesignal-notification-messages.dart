class OneSignalNotificationMessages {
  dynamic sLastUpdate;
  List<dynamic> appId;
  List<dynamic> companyId;
  dynamic contents;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic cronJob;
  dynamic data;
  dynamic displayName;
  List<dynamic> email;
  dynamic excludedSegments;
  dynamic externalId;
  dynamic filter;
  dynamic headings;
  dynamic id;
  dynamic includedSegments;
  List<dynamic> includedSegmentsM2m;
  dynamic oneSignalNotificationId;
  dynamic reason;
  dynamic recipientsCount;
  dynamic specificDevices;
  dynamic status;
  dynamic targetParameters;
  List<dynamic> userIds;
  dynamic writeDate;
  List<dynamic> writeUid;

  OneSignalNotificationMessages(
      {this.sLastUpdate,
      this.appId,
      this.companyId,
      this.contents,
      this.createDate,
      this.createUid,
      this.cronJob,
      this.data,
      this.displayName,
      this.email,
      this.excludedSegments,
      this.externalId,
      this.filter,
      this.headings,
      this.id,
      this.includedSegments,
      this.includedSegmentsM2m,
      this.oneSignalNotificationId,
      this.reason,
      this.recipientsCount,
      this.specificDevices,
      this.status,
      this.targetParameters,
      this.userIds,
      this.writeDate,
      this.writeUid});

  OneSignalNotificationMessages.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    appId = json['app_id'] is bool ? [] : json["app_id"];
    companyId = json['company_id'] is bool ? [] : json["company_id"];
    contents = json['contents'];
    createDate = json['create_date'];
    createUid = json['create_uid'] is bool ? [] : json["create_uid"];
    cronJob = json['cron_job'];
    data = json['data'];
    displayName = json['display_name'];
    email = json['email'] is bool ? [] : json["email"];
    excludedSegments = json['excluded_segments'];
    externalId = json['external_id'];
    filter = json['filter'];
    headings = json['headings'];
    id = json['id'];
    includedSegments = json['included_segments'];
    includedSegmentsM2m = json['included_segments_m2m'] is bool
        ? []
        : json["included_segments_m2m"];
    oneSignalNotificationId = json['one_signal_notification_id'];
    reason = json['reason'];
    recipientsCount = json['recipients_count'];
    specificDevices = json['specific_devices'];
    status = json['status'];
    targetParameters = json['target_parameters'];
    userIds = json['user_ids'] is bool ? [] : json["user_ids"];
    writeDate = json['write_date'];
    writeUid = json['write_uid'] is bool ? [] : json["write_uid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.appId != null) data['app_id'] = this.appId;
    if (this.companyId != null) data['company_id'] = this.companyId;
    if (this.contents != null) data['contents'] = this.contents;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.cronJob != null) data['cron_job'] = this.cronJob;
    if (this.data != null) data['data'] = this.data;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.email != null) data['email'] = this.email;
    if (this.excludedSegments != null)
      data['excluded_segments'] = this.excludedSegments;
    if (this.externalId != null) data['external_id'] = this.externalId;
    if (this.filter != null) data['filter'] = this.filter;
    if (this.headings != null) data['headings'] = this.headings;
    if (this.id != null) data['id'] = this.id;
    if (this.includedSegments != null)
      data['included_segments'] = this.includedSegments;
    if (this.includedSegmentsM2m != null)
      data['included_segments_m2m'] = this.includedSegmentsM2m;
    if (this.oneSignalNotificationId != null)
      data['one_signal_notification_id'] = this.oneSignalNotificationId;
    if (this.reason != null) data['reason'] = this.reason;
    if (this.recipientsCount != null)
      data['recipients_count'] = this.recipientsCount;
    if (this.specificDevices != null)
      data['specific_devices'] = this.specificDevices;
    if (this.status != null) data['status'] = this.status;
    if (this.targetParameters != null)
      data['target_parameters'] = this.targetParameters;
    if (this.userIds != null) data['user_ids'] = this.userIds;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
