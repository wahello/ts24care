class LiveZilla {
  ///name
  dynamic ptn;

  ///email
  dynamic pte;

  ///company
  dynamic ptc;

  ///question / subject
  dynamic ptq;

  ///phone
  dynamic ptp;

  ///language
  dynamic ptl;

  ///overwrite
  dynamic pto;
  LiveZilla(
      {this.ptn,
      this.pte,
      this.ptc,
      this.ptq,
      this.ptp,
      this.ptl = "vi",
      this.pto = true});

  LiveZilla.fromJson(Map<String, dynamic> json) {
    ptn = json['ptn'];
    pte = json['pte'];
    ptc = json['ptc'];
    ptq = json['ptq'];
    ptp = json['ptp'];
    ptl = json['ptl'];
    pto = json['pto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ptn != null) data['ptn'] = this.ptn;
    if (this.pte != null) data['pte'] = this.pte;
    if (this.ptc != null) data['ptc'] = this.ptc;
    if (this.ptq != null) data['ptq'] = this.ptq;
    if (this.ptp != null) data['ptp'] = this.ptp;
    if (this.ptl != null) data['ptl'] = this.ptl;
    if (this.pto != null) data['pto'] = this.pto;
    // data['pth'] =
    //     "https://web.ts24.com.vn/web/image/res.company/1/logo?unique=5e39e00";
    return data;
  }
}
