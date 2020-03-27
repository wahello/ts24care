class ProductWarranty {
  dynamic sLastUpdate;
  dynamic accept1;
  dynamic comment;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic displayName;
  dynamic email;
  dynamic id;
  dynamic merchant;
  dynamic modelNo;
  List<dynamic> partnerId;
  dynamic phone;
  List<dynamic> productId;
  List<dynamic> productSerialId;
  dynamic renewNo;
  dynamic serialNo;
  dynamic state;
  List<dynamic> tagsW;
  List<dynamic> warrantyClaimIds;
  dynamic warrantyCost;
  dynamic warrantyCreateDate;
  dynamic warrantyEndDate;
  List<dynamic> warrantyHistoryIds;
  List<dynamic> warrantySalesPerson;
  dynamic warrantyTeam;
  dynamic warrantyType;
  dynamic writeDate;
  List<dynamic> writeUid;
  dynamic xCompanyAddress;
  dynamic xCompanyName;
  dynamic xContactEmail;
  dynamic xContactId;
  dynamic xContactPerson;
  dynamic xContactTel;
  dynamic xEmail;
  dynamic xLimitDate;
  dynamic xOrderType;
  dynamic xRemainAmount;
  dynamic xTokenId;
  dynamic name;

  ProductWarranty(
      {this.name,
        this.sLastUpdate,
      this.accept1,
      this.comment,
      this.createDate,
      this.createUid,
      this.displayName,
      this.email,
      this.id,
      this.merchant,
      this.modelNo,
      this.partnerId,
      this.phone,
      this.productId,
      this.productSerialId,
      this.renewNo,
      this.serialNo,
      this.state,
      this.tagsW,
      this.warrantyClaimIds,
      this.warrantyCost,
      this.warrantyCreateDate,
      this.warrantyEndDate,
      this.warrantyHistoryIds,
      this.warrantySalesPerson,
      this.warrantyTeam,
      this.warrantyType,
      this.writeDate,
      this.writeUid,
      this.xCompanyAddress,
      this.xCompanyName,
      this.xContactEmail,
      this.xContactId,
      this.xContactPerson,
      this.xContactTel,
      this.xEmail,
      this.xLimitDate,
      this.xOrderType,
      this.xRemainAmount,
      this.xTokenId});

  ProductWarranty.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    accept1 = json['accept1'];
    comment = json['comment'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    displayName = json['display_name'];
    email = json['email'];
    id = json['id'];
    merchant = json['merchant'];
    modelNo = json['model_no'];
    partnerId = json['partner_id'];
    phone = json['phone'];
    productId = json['product_id'];
    productSerialId = json['product_serial_id'];
    renewNo = json['renew_no'];
    serialNo = json['serial_no'];
    state = json['state'];
    tagsW = json['tags_w'];
    warrantyClaimIds = json['warranty_claim_ids'];
    warrantyCost = json['warranty_cost'];
    warrantyCreateDate = json['warranty_create_date'];
    warrantyEndDate = json['warranty_end_date'];
    warrantyHistoryIds = json['warranty_history_ids'];
    warrantySalesPerson = json['warranty_sales_person'];
    warrantyTeam = json['warranty_team'];
    warrantyType = json['warranty_type'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
    xCompanyAddress = json['x_company_address'];
    xCompanyName = json['x_company_name'];
    xContactEmail = json['x_contact_email'];
    xContactId = json['x_contact_id'];
    xContactPerson = json['x_contact_person'];
    xContactTel = json['x_contact_tel'];
    xEmail = json['x_email'];
    xLimitDate = json['x_limit_date'];
    xOrderType = json['x_order_type'];
    xRemainAmount = json['x_remain_amount'];
    xTokenId = json['x_token_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.accept1 != null) data['accept1'] = this.accept1;
    if (this.comment != null) data['comment'] = this.comment;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.email != null) data['email'] = this.email;
    if (this.id != null) data['id'] = this.id;
    if (this.merchant != null) data['merchant'] = this.merchant;
    if (this.modelNo != null) data['model_no'] = this.modelNo;
    if (this.partnerId != null) data['partner_id'] = this.partnerId;
    if (this.phone != null) data['phone'] = this.phone;
    if (this.productId != null) data['product_id'] = this.productId;
    if (this.productSerialId != null)
      data['product_serial_id'] = this.productSerialId;
    if (this.renewNo != null) data['renew_no'] = this.renewNo;
    if (this.serialNo != null) data['serial_no'] = this.serialNo;
    if (this.state != null) data['state'] = this.state;
    if (this.tagsW != null) data['tags_w'] = this.tagsW;
    if (this.warrantyClaimIds != null)
      data['warranty_claim_ids'] = this.warrantyClaimIds;
    if (this.warrantyCost != null) data['warranty_cost'] = this.warrantyCost;
    if (this.warrantyCreateDate != null)
      data['warranty_create_date'] = this.warrantyCreateDate;
    if (this.warrantyEndDate != null)
      data['warranty_end_date'] = this.warrantyEndDate;
    if (this.warrantyHistoryIds != null)
      data['warranty_history_ids'] = this.warrantyHistoryIds;
    if (this.warrantySalesPerson != null)
      data['warranty_sales_person'] = this.warrantySalesPerson;
    if (this.warrantyTeam != null) data['warranty_team'] = this.warrantyTeam;
    if (this.warrantyType != null) data['warranty_type'] = this.warrantyType;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    if (this.xCompanyAddress != null)
      data['x_company_address'] = this.xCompanyAddress;
    if (this.xCompanyName != null) data['x_company_name'] = this.xCompanyName;
    if (this.xContactEmail != null)
      data['x_contact_email'] = this.xContactEmail;
    if (this.xContactId != null) data['x_contact_id'] = this.xContactId;
    if (this.xContactPerson != null)
      data['x_contact_person'] = this.xContactPerson;
    if (this.xContactTel != null) data['x_contact_tel'] = this.xContactTel;
    if (this.xEmail != null) data['x_email'] = this.xEmail;
    if (this.xLimitDate != null) data['x_limit_date'] = this.xLimitDate;
    if (this.xOrderType != null) data['x_order_type'] = this.xOrderType;
    if (this.xRemainAmount != null)
      data['x_remain_amount'] = this.xRemainAmount;
    if (this.xTokenId != null) data['x_token_id'] = this.xTokenId;
    return data;
  }
}
