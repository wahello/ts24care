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
  TutorialPageViewModel();

  onTapStart() {
    Navigator.pushNamed(context, LoginPage.routeName);
  }
}
