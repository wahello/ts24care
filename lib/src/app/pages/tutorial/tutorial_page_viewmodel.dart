import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page.dart';

class TutorialPageViewModel extends ViewModelBase {
  TutorialPageViewModel();

  onTapStart() {
    //Navigator.pushNamed(context, LoginPage.routeName);
    // api
    //     .checkLogin(username: "luan.vm@ts24corp.com", password: "ssbblss")
    //     .then((onValue) {
    //   print(onValue);
    // });
    // api.getListBlogs(offset: 0, limit: 20).then((onValue) {
    //   print(onValue);
    // });
    // api.searchBlogs(keyword: "ab", offset: 0, limit: 20).then((onValue) {
    //   print(onValue);
    // });

    // api.getBlogById(55).then((onValue) {
    //   print(onValue);
    // });
    //Navigator.pushNamed(context, TabsPage.routeName);
    // api
    //     .checkLogin(username: "demo@ts24corp.com", password: "123456")
    //     .then((onValue) {
    //   // print(onValue);
    //   api.getCustomerInfoAfterLogin();
    //  });
    api.getStatusTicket().then((onValue) {
      print(onValue);
    });
  }
}
