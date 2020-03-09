import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page.dart';

class TutorialPageViewModel extends ViewModelBase{
  TutorialPageViewModel();

  onTapStart() {
    Navigator.pushReplacementNamed(context, TabsPage.routeName);
  }
}