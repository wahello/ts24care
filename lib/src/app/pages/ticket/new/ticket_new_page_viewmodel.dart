import 'package:flutter/cupertino.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';

class TicketNewPageViewModel extends ViewModelBase{
  TicketNewPageViewModel();

  onTapBack() {
    Navigator.pop(context);
  }
}