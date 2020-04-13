import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/index.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

import '../../../app_localizations.dart';

class ForgetPasswordPageViewModel extends ViewModelBase {
  TextEditingController _emailController = new TextEditingController();

  get emailController => _emailController;

  FocusNode emailNode = FocusNode();

  String _errorEmail;

  get errorEmail => _errorEmail;

  ForgetPasswordPageViewModel() {
    _emailController.addListener(() {
      if (_emailController.text.length > 1) isValidEmail();
    });
  }

  bool isValidEmail() {
    _errorEmail = null;
    var resultemail = Validator.validateEmail(_emailController.text);
    if (resultemail != null) {
      _errorEmail = resultemail;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  Future<void> onSubmitClicked() async {
    isValidEmail();
    if (!isValidEmail()) return;
    LoadingDialog.showLoadingDialog(
        context, translation.text("COMMON.IN_PROCESS"));
    bool result = await api.resetPassword(_emailController.text.toString());
    if (result) {
      LoadingDialog.hideLoadingDialog(context);
      LoadingDialog.showMsgDialog(
          context, 'Đã gửi password mới tới địa chỉ email của bạn');
    } else {
      LoadingDialog.hideLoadingDialog(context);
      LoadingDialog.showMsgDialog(context, translation.text("COMMON.FAIL"));
    }
//    Navigator.pushReplacementNamed(context, CreateNewPasswordPage.routeName);
  }
}
