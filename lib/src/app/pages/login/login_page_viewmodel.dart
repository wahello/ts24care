import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/helper/validator-helper.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page.dart';
import 'forgetPassword/forget_password.dart';
import 'package:ts24care/src/app/app_localizations.dart';

class LoginPageViewModel extends ViewModelBase {
  final formKey = GlobalKey<FormState>();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  TextEditingController _emailController = new TextEditingController();

  get emailController => _emailController;
  TextEditingController _passController = new TextEditingController();

  get passController => _passController;

  String _errorEmail;

  get errorEmail => _errorEmail;

  String _errorPass;

  get errorPass => _errorPass;

  LoginPageViewModel() {
    _emailController.addListener(() {
      if (_emailController.text.length > 1) isValidEmail();
    });
    _passController.addListener(() {
      if (_passController.text.length > 1) isValidPass();
    });
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentNode, FocusNode nextNode) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

  bool isValidEmail() {
    _errorEmail = null;
    var resultEmail = Validator.validateEmail(_emailController.text);

    if (resultEmail != null) {
      print(resultEmail);
      _errorEmail = resultEmail;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidPass() {
    _errorPass = null;
    var resultpass = Validator.validatePassword(_passController.text);
    if (resultpass != null) {
      _errorPass = resultpass;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

//  bool isValidInfo() {
//    if (isValidEmail() && isValidPass()) {
//      this.updateState();
//      return true;
//    }
//    return false;
//  }

  void onForgetPasswordClicked() {
    Navigator.pushReplacementNamed(context, ForgetPasswordPage.routeName);
  }

  void onLoginButtonClicked() {
//    passwordFocusNode.unfocus();
    isValidEmail();
    isValidPass();
//    if(isValidEmail() && isValidPass())
//    Navigator.pushReplacementNamed(context, TutorialPage.routeName);
//    passwordFocusNode.unfocus();
    Navigator.pushReplacementNamed(context, TabsPage.routeName);
  }

//  void onTapCreateAccountButton(context){
//    Navigator.pushNamed(context, CreateNewPasswordPage.routeName);
//  }

}
