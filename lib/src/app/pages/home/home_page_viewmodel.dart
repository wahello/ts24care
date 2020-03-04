import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/home/newsAndTips/home_news_and_tips_page.dart';

class HomePageViewModel extends ViewModelBase{
  HomePageViewModel();
  tapMoreNewAndTips(){
    Navigator.pushNamed(context, NewsAndTipsPage.routeName);
  }
}