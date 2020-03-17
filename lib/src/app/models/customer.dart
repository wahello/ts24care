import 'dart:convert';
import 'dart:typed_data';

import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/res-partner.dart';

class Customer {
  int id;
  dynamic name;
  dynamic photo;
  dynamic email;
  dynamic phone;
  dynamic contactAddress;
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
      this.name,
      this.photo,
      this.email,
      this.phone,
      this.contactAddress}) {
    id = id;
    name = name;
    photo = photo;
    email = email;
    phone = phone;
    contactAddress = contactAddress;
  }

  fromResPartner(ResPartner resPartner) {
    id = resPartner.id;
    name = (resPartner.name is bool) ? "" : resPartner.name;
    photo = resPartner.image;
    email = (resPartner.email is bool) ? "" : resPartner.email;
    phone = (resPartner.phone is bool) ? "" : resPartner.phone;
    contactAddress = (resPartner.street is bool) ? "" : resPartner.street;
  }

  fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['photo'] is List) {
      List photoUint8 = json['photo'];
      photoUint8 = photoUint8.cast<int>();
      photo = Uint8List.fromList(photoUint8);
    } else if (!(json['photo'] is bool)) photo = json['photo'];
    email = json['email'];
    phone = json['phone'];
    contactAddress = json['contactAddress'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['contactAddress'] = this.contactAddress;
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
