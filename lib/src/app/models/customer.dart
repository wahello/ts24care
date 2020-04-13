import 'dart:convert';
import 'dart:typed_data';

import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/res-partner.dart';

class Customer {
  int id;
  int userId;
  dynamic name;
  dynamic photo;
  dynamic email;
  dynamic phone;
  dynamic contactAddress;
  dynamic companyName;
  dynamic companyId;
  dynamic tin; //Tax identification number
  static dynamic aliasName = "Customer";
  static Customer _singleton;

  factory Customer() {
    if (_singleton != null)
      return _singleton;
    else
      return _singleton = new Customer._internal();
  }

  Customer._internal();

  Customer.newInstance(
      {this.id,
      this.userId,
      this.name,
      this.photo,
      this.email,
      this.phone,
      this.contactAddress,
      this.companyName,
      this.companyId,
      this.tin}) {
    id = id;
    userId = userId;
    name = name;
    photo = photo;
    email = email;
    phone = phone;
    contactAddress = contactAddress;
    companyName = companyName;
    companyId = companyId;
    tin = tin;
  }

  fromResPartner(ResPartner resPartner) {
    id = resPartner.id;
    if (resPartner.userIds is List) if (resPartner.userIds.length > 0)
      userId = resPartner.userIds[0];
    name = (resPartner.name is bool) ? "" : resPartner.name;
    photo = resPartner.image;
    email = (resPartner.email is bool) ? "" : resPartner.email;
    phone = (resPartner.phone is bool) ? "" : resPartner.phone;
    contactAddress = (resPartner.street is bool) ? "" : resPartner.street;
    if (resPartner.companyId is List) if (resPartner.companyId.length > 0) {
      companyId = resPartner.companyId[0];

      companyName = resPartner.companyId[1];
    }
    tin = (resPartner.vat is bool) ? "" : resPartner.vat;
  }

  fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    if (json['photo'] is List) {
      List photoUint8 = json['photo'];
      photoUint8 = photoUint8.cast<int>();
      photo = Uint8List.fromList(photoUint8);
    } else if (!(json['photo'] is bool)) photo = json['photo'];
    email = json['email'];
    phone = json['phone'];
    contactAddress = json['contactAddress'];
    companyName = json['companyName'];
    companyId = json['companyId'];
    tin = json['tin'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['contactAddress'] = this.contactAddress;
    data['companyName'] = this.companyName;
    data['companyId'] = this.companyId;
    data['tin'] = this.tin;
    return data;
  }

  Map<String, dynamic> toJsonOneSignal({String language: "vi"}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    // data['photo'] = this.photo;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data["language"] = language;
    return data;
  }

  Future<dynamic> saveLocal() async {
    return localStorage.setItem(Customer.aliasName, json.encode(this));
  }

  Future<dynamic> clearLocal() async {
    bool ready = await localStorage.ready;
    if (ready) {
      if (localStorage.getItem(Customer.aliasName) != null) {
        localStorage.deleteItem(Customer.aliasName);
        api.expiresIn = null;
        _singleton = null;
      }
    }
  }

  Future<Customer> reloadData() async {
    bool ready = await localStorage.ready;
    if (ready) {
      if (localStorage.getItem(Customer.aliasName) != null) {
        print(jsonDecode(localStorage.getItem(Customer.aliasName)));
        this.fromJson(jsonDecode(localStorage.getItem(Customer.aliasName)));

        return this;
      }
    }
    return this;
  }

  Future<bool> checkCustomerExist() async {
    await reloadData();
    if (id != null) return true;
    return false;
  }
}
