import 'package:flutter/material.dart';

class TS24ProductCategory {
  String name;
  String photo;
  Color color;

  TS24ProductCategory({this.name, this.photo, this.color});
  static final _url = "https://web.ts24.com.vn";
  static final List<TS24ProductCategory> list = [
    TS24ProductCategory(
      name: "Default",
      photo: "$_url/web/image/megamenu.links/22/image?unique=49f1ecd",
      color: Colors.grey
    ),
    TS24ProductCategory(
        name: "Sales24",
        photo: "$_url/web/image/megamenu.links/18/image?unique=01deb10",
        color: Color(0xffF9B715)
    ),
    TS24ProductCategory(
        name: "SM24",
        photo: "$_url/web/image/megamenu.links/11/image?unique=fc37f6c",
        color: Color(0xffF25022)
    ),
    TS24ProductCategory(
      name: "iKeToan",
      photo: "$_url/web/image/megamenu.links/16/image?unique=0f6f528",
        color: Color(0xff7D40B2)
    ),
    TS24ProductCategory(
      name: "iThongKe",
      photo: "$_url/web/image/megamenu.links/12/image?unique=30aca31",
        color: Color(0xffF93E7D)
    ),
    TS24ProductCategory(
      name: "iXHD",
      photo: "$_url/web/image/megamenu.links/17/image?unique=5f41f84",
        color: Color(0xffBC0202)
    ),
    TS24ProductCategory(
      name: "HR24",
      photo: "$_url/web/image/megamenu.links/19/image?unique=02ed51d",
        color: Color(0xff6AA644)
    ),
    TS24ProductCategory(
      name: "iHaiQuan",
      photo: "$_url/web/image/megamenu.links/5/image?unique=33c269f",
        color: Color(0xff1462C1)
    ),
    TS24ProductCategory(
      name: "iBHXH",
      photo: "$_url/web/image/megamenu.links/6/image?unique=33c269f",
        color: Color(0xff66A73D)
    ),
    TS24ProductCategory(
      name: "TaxOnline",
      photo: "$_url/web/image/megamenu.links/4/image?unique=13d2733",
        color: Color(0xff4285F4)
    ),
  ];
}
