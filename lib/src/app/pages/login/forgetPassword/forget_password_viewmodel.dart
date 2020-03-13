import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/index.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/pages/login/createAccount/create_new_password.dart';

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

  void onSubmitClicked() {
    isValidEmail();
//    if(isValidEmail())
    Navigator.pushReplacementNamed(context, CreateNewPasswordPage.routeName);
  }
}
