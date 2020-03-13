import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';

class TutorialPageViewModel extends ViewModelBase {
  TutorialPageViewModel();

  onTapStart() {
    Navigator.pushNamed(context, LoginPage.routeName);
    // api
    //     .checkLogin(username: "luan.vm@ts24corp.com", password: "ssbblss")
    //     .then((onValue) {
    //   print(onValue);
    // });
  }
}
