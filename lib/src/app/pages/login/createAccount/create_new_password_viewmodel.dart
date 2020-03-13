import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/helper/index.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';

import '../../../app_localizations.dart';

class CreateAccountPageViewModel extends ViewModelBase {
  TextEditingController _passController = TextEditingController();

  get passController => _passController;

  String errorPass;
  TextEditingController _passControllerConfirm = TextEditingController();

  get passControllerConfirm => _passControllerConfirm;
  bool showPassConfirm = true;
  String errorPassConfirm;
  final FocusNode passFocus = FocusNode();
  final FocusNode passConfirmFocus = FocusNode();

  CreateAccountPageViewModel() {
    passController.addListener(() => {isValidPass()});
    passControllerConfirm.addListener(() => {isValidPassConfirm()});
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool isValidPass() {
    errorPass = null;
    var resultPass = Validator.validatePassword(passController.text);
    if (resultPass != null) {
      errorPass = resultPass;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidPassConfirm() {
    errorPassConfirm = null;
    if (passControllerConfirm.text != passController.text) {
      errorPassConfirm = translation.text("COMMON.PASS_NOT_TRUE");
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  void onDoneButtonClicked(context) {
    isValidPass();
    isValidPassConfirm();
    if (isValidPass() && isValidPassConfirm())
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }
}
