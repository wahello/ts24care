import 'package:flutter/cupertino.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page.dart';

class TicketPageViewModel extends ViewModelBase{
  TicketPageViewModel();

  onTapCreateTicket() {
    Navigator.pushNamed(context, TicketNewPage.routeName);
  }
}