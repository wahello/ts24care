class IrAttachment {
  dynamic sLastUpdate;
  dynamic accessToken;
  dynamic active;
  dynamic checksum;
  List<dynamic> companyId;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic datas;
  dynamic datasFname;
  dynamic dbDatas;
  dynamic description;
  dynamic displayName;
  dynamic fileSize;
  dynamic id;
  dynamic indexContent;
  dynamic key;
  dynamic localUrl;
  dynamic mimetype;
  dynamic name;
  dynamic public;
  dynamic resField;
  dynamic resId;
  dynamic resModel;
  dynamic resModelName;
  dynamic resName;
  dynamic storeFname;
  dynamic temporary;
  dynamic themeTemplateId;
  dynamic thumbnail;
  dynamic type;
  dynamic url;
  List<dynamic> websiteId;
  dynamic websiteUrl;
  dynamic writeDate;
  List<dynamic> writeUid;

  IrAttachment(
      {this.sLastUpdate,
      this.accessToken,
      this.active,
      this.checksum,
      this.companyId,
      this.createDate,
      this.createUid,
      this.datas,
      this.datasFname,
      this.dbDatas,
      this.description,
      this.displayName,
      this.fileSize,
      this.id,
      this.indexContent,
      this.key,
      this.localUrl,
      this.mimetype,
      this.name,
      this.public,
      this.resField,
      this.resId,
      this.resModel,
      this.resModelName,
      this.resName,
      this.storeFname,
      this.temporary,
      this.themeTemplateId,
      this.thumbnail,
      this.type,
      this.url,
      this.websiteId,
      this.websiteUrl,
      this.writeDate,
      this.writeUid});

  IrAttachment.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    accessToken = json['access_token'];
    active = json['active'];
    checksum = json['checksum'];
    companyId = json['company_id'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    datas = json['datas'];
    datasFname = json['datas_fname'];
    dbDatas = json['db_datas'];
    description = json['description'];
    displayName = json['display_name'];
    fileSize = json['file_size'];
    id = json['id'];
    indexContent = json['index_content'];
    key = json['key'];
    localUrl = json['local_url'];
    mimetype = json['mimetype'];
    name = json['name'];
    public = json['public'];
    resField = json['res_field'];
    resId = json['res_id'];
    resModel = json['res_model'];
    resModelName = json['res_model_name'];
    resName = json['res_name'];
    storeFname = json['store_fname'];
    temporary = json['temporary'];
    themeTemplateId = json['theme_template_id'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    url = json['url'];
    websiteId = json['website_id'];
    websiteUrl = json['website_url'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.accessToken != null) data['access_token'] = this.accessToken;
    if (this.active != null) data['active'] = this.active;
    if (this.checksum != null) data['checksum'] = this.checksum;
    if (this.companyId != null) data['company_id'] = this.companyId;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.datas != null) data['datas'] = this.datas;
    if (this.datasFname != null) data['datas_fname'] = this.datasFname;
    if (this.dbDatas != null) data['db_datas'] = this.dbDatas;
    if (this.description != null) data['description'] = this.description;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.fileSize != null) data['file_size'] = this.fileSize;
    if (this.id != null) data['id'] = this.id;
    if (this.indexContent != null) data['index_content'] = this.indexContent;
    if (this.key != null) data['key'] = this.key;
    if (this.localUrl != null) data['local_url'] = this.localUrl;
    if (this.mimetype != null) data['mimetype'] = this.mimetype;
    if (this.name != null) data['name'] = this.name;
    if (this.public != null) data['public'] = this.public;
    if (this.resField != null) data['res_field'] = this.resField;
    if (this.resId != null) data['res_id'] = this.resId;
    if (this.resModel != null) data['res_model'] = this.resModel;
    if (this.resModelName != null) data['res_model_name'] = this.resModelName;
    if (this.resName != null) data['res_name'] = this.resName;
    if (this.storeFname != null) data['store_fname'] = this.storeFname;
    if (this.temporary != null) data['temporary'] = this.temporary;
    if (this.themeTemplateId != null)
      data['theme_template_id'] = this.themeTemplateId;
    if (this.thumbnail != null) data['thumbnail'] = this.thumbnail;
    if (this.type != null) data['type'] = this.type;
    if (this.url != null) data['url'] = this.url;
    if (this.websiteId != null) data['website_id'] = this.websiteId;
    if (this.websiteUrl != null) data['website_url'] = this.websiteUrl;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
