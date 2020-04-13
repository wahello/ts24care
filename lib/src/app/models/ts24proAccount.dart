class TS24PROAccount {
  dynamic mail;
  dynamic telephoneNumber;
  dynamic userPassword;
  dynamic uid;
  dynamic status;
  dynamic answer;
  dynamic codeactive;
  dynamic countblocked;
  dynamic countlogin;
  dynamic editeddate;
  dynamic fullname;
  dynamic permanentblocked;
  dynamic question;
  dynamic registeddate;
  dynamic timecodeactive;
  dynamic timetampleblocked;
  dynamic timecodereset;
  dynamic accounttype;
  dynamic tokenSocial;
  dynamic facebook;
  dynamic google;
  dynamic skype;
  dynamic zalo;
  dynamic viber;
  dynamic phuong;
  dynamic xa;
  dynamic quanhuyen;
  dynamic tinhtp;
  dynamic street;

  TS24PROAccount(
      {this.mail,
      this.telephoneNumber,
      this.userPassword,
      this.uid,
      this.status,
      this.answer,
      this.codeactive,
      this.countblocked,
      this.countlogin,
      this.editeddate,
      this.fullname,
      this.permanentblocked,
      this.question,
      this.registeddate,
      this.timecodeactive,
      this.timetampleblocked,
      this.timecodereset,
      this.accounttype,
      this.tokenSocial,
      this.facebook,
      this.google,
      this.skype,
      this.zalo,
      this.viber,
      this.phuong,
      this.xa,
      this.quanhuyen,
      this.tinhtp,
      this.street});

  TS24PROAccount.fromJson(Map<String, dynamic> json) {
    mail = json['mail'];
    telephoneNumber = json['telephoneNumber'];
    userPassword = json['userPassword'];
    uid = json['uid'];
    status = json['status'];
    answer = json['answer'];
    codeactive = json['codeactive'];
    countblocked = json['countblocked'];
    countlogin = json['countlogin'];
    editeddate = json['editeddate'];
    fullname = json['fullname'];
    permanentblocked = json['permanentblocked'];
    question = json['question'];
    registeddate = json['registeddate'];
    timecodeactive = json['timecodeactive'];
    timetampleblocked = json['timetampleblocked'];
    timecodereset = json['timecodereset'];
    accounttype = json['accounttype'];
    tokenSocial = json['tokenSocial'];
    facebook = json['facebook'];
    google = json['google'];
    skype = json['skype'];
    zalo = json['zalo'];
    viber = json['viber'];
    phuong = json['phuong'];
    xa = json['xa'];
    quanhuyen = json['quanhuyen'];
    tinhtp = json['tinhtp'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mail != null) data['mail'] = this.mail;
    if (this.telephoneNumber != null)
      data['telephoneNumber'] = this.telephoneNumber;
    if (this.userPassword != null) data['userPassword'] = this.userPassword;
    if (this.uid != null) data['uid'] = this.uid;
    if (this.status != null) data['status'] = this.status;
    if (this.answer != null) data['answer'] = this.answer;
    if (this.codeactive != null) data['codeactive'] = this.codeactive;
    if (this.countblocked != null) data['countblocked'] = this.countblocked;
    if (this.countlogin != null) data['countlogin'] = this.countlogin;
    if (this.editeddate != null) data['editeddate'] = this.editeddate;
    if (this.fullname != null) data['fullname'] = this.fullname;
    if (this.permanentblocked != null)
      data['permanentblocked'] = this.permanentblocked;
    if (this.question != null) data['question'] = this.question;
    if (this.registeddate != null) data['registeddate'] = this.registeddate;
    if (this.timecodeactive != null)
      data['timecodeactive'] = this.timecodeactive;
    if (this.timetampleblocked != null)
      data['timetampleblocked'] = this.timetampleblocked;
    if (this.timecodereset != null) data['timecodereset'] = this.timecodereset;
    if (this.accounttype != null) data['accounttype'] = this.accounttype;
    if (this.tokenSocial != null) data['tokenSocial'] = this.tokenSocial;
    if (this.facebook != null) data['facebook'] = this.facebook;
    if (this.google != null) data['google'] = this.google;
    if (this.skype != null) data['skype'] = this.skype;
    if (this.zalo != null) data['zalo'] = this.zalo;
    if (this.viber != null) data['viber'] = this.viber;
    if (this.phuong != null) data['phuong'] = this.phuong;
    if (this.xa != null) data['xa'] = this.xa;
    if (this.quanhuyen != null) data['quanhuyen'] = this.quanhuyen;
    if (this.tinhtp != null) data['tinhtp'] = this.tinhtp;
    if (this.street != null) data['street'] = this.street;
    return data;
  }
}
