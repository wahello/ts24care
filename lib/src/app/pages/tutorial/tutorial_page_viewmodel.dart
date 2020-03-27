import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page.dart';

class TutorialPageViewModel extends ViewModelBase {
  TutorialPageViewModel();

  onTapStart() {
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
    // api
    //     .checkLogin(username: "luan.vm@ts24corp.com", password: "ssbblss")
    //     .then((onValue) {
    //   print(onValue);
    // });
    // api.getListBlogs(offset: 0, limit: 20).then((onValue) {
    //   print(onValue);
    // });
    // api.searchBlogs(keyword: "de", offset: 0, limit: 20).then((onValue) {
    //   print(onValue);
    // });

    // api.getBlogById(55).then((onValue) {
    //   print(onValue);
    // });
    //Navigator.pushNamed(context, TabsPage.routeName);
    // api
    //     .checkLogin(username: "demo@ts24corp.com", password: "123456")
    //     .then((onValue) async {
    //   // print(onValue);
    //   await api.getCustomerInfoAfterLogin();
    //   api.getListTicketByStatus(offset: 0, limit: 20).then((value) {
    //     print(value);
    //   });
    // });
    // api.getStatusTicket().then((onValue) {
    //   print(onValue);
    // });
    // HelpdeskTicket ticket = HelpdeskTicket();
    // ticket.partnerId = [8];
    // ticket.subject = "Test1";
    // ticket.description = "abcd";
    // api.insertTickets(ticket: ticket, listAttachmentId: [949]);
  }
}
