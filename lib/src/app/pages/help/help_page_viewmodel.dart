import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_application_model.dart';
import 'package:ts24care/src/app/pages/help/faq/help_faq_page.dart';
import 'package:ts24care/src/app/pages/help/feedback/help_feedback_page.dart';
import 'package:ts24care/src/app/pages/help/helpChat/helpChat_page.dart';

class HelpPageViewModel extends ViewModelBase{
  List<ItemApplicationModel> listApplication = List();
  HelpPageViewModel(){
   listApplication.addAll(ItemApplicationModel.listApplicationActive);
  }
  onTapFAQ(){
    Navigator.pushNamed(context, FAQPage.routeName);
  }

  onTapFeedback() {
    Navigator.pushNamed(context, FeedbackPage.routeName);
  }

  onTapChat() {
    Navigator.pushNamed(context, HelpChatPage.routeName);
  }
}