import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';

class TutorialPageViewModel extends ViewModelBase {
  List<String> urlImageSlide = [
    "https://web.ts24.com.vn/web/image/363417/main_pic.png",
    "https://web.ts24.com.vn/web/image/356272/graphic_gov.png",
    "https://web.ts24.com.vn/web/image/341769/sodo_biz_main.png",
    "https://web.ts24.com.vn/web/image/341830/sodo_pro_main.png"
  ];
  List<String> title = [
    "GIẢI PHÁP \nQUẢN LÝ TỔNG THỂ CHO DOANH NGHIỆP",
    "TS24gov",
    "TS24biz",
    "TS24pro"
  ];
  List<String> subTitle = [
    "",
    "Dịch vụ chính phủ điện tử cho doanh nghiệp",
    "Dịch vụ quản lý theo nghiệp vụ",
    "Dịch vụ quản lý tổng thể"
  ];
  List<String> imageSlide = [
    "assets/images/TS24Care_BannerApp-01.jpg",
    "assets/images/TS24Care_BannerApp-02.jpg",
    "assets/images/TS24Care_BannerApp-03.jpg",
  ];
  TutorialPageViewModel();

  onTapStart() {
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
    //  api.checkLoginTS24Pro(
    //      username: "ktpm.ts24@gmail.com", password: "Tm!123789!t");
    // ResPartner resPartner = ResPartner();
    // resPartner.email = "ktpm.ts24@gmail.com";
    // resPartner.password = "123456";
    // resPartner.name = "KTest";
    // resPartner.phone = "09312312333";
    // api.insertUserPortal(resPartner);
    // var a = "0xff" + "ebebeb";
    // var b = Color(int.parse(a));
    // print(b);
  }
}
