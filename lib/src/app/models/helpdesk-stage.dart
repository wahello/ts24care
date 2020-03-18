class HelpDeskStage {
  dynamic sLastUpdate;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic displayName;
  dynamic fold;
  dynamic id;
  dynamic legendBlocked;
  dynamic legendDone;
  dynamic legendNormal;
  dynamic name;
  dynamic requirements;
  dynamic sequence;
  dynamic writeDate;
  List<dynamic> writeUid;

  HelpDeskStage(
      {this.sLastUpdate,
      this.createDate,
      this.createUid,
      this.displayName,
      this.fold,
      this.id,
      this.legendBlocked,
      this.legendDone,
      this.legendNormal,
      this.name,
      this.requirements,
      this.sequence,
      this.writeDate,
      this.writeUid});

  HelpDeskStage.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    displayName = json['display_name'];
    fold = json['fold'];
    id = json['id'];
    legendBlocked = json['legend_blocked'];
    legendDone = json['legend_done'];
    legendNormal = json['legend_normal'];
    name = json['name'];
    requirements = json['requirements'];
    sequence = json['sequence'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.fold != null) data['fold'] = this.fold;
    if (this.id != null) data['id'] = this.id;
    if (this.legendBlocked != null) data['legend_blocked'] = this.legendBlocked;
    if (this.legendDone != null) data['legend_done'] = this.legendDone;
    if (this.legendNormal != null) data['legend_normal'] = this.legendNormal;
    if (this.name != null) data['name'] = this.name;
    if (this.requirements != null) data['requirements'] = this.requirements;
    if (this.sequence != null) data['sequence'] = this.sequence;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
