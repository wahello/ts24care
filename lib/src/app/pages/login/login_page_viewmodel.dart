import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/helper/validator-helper.dart';
import 'package:ts24care/src/app/pages/help/help_page.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page.dart';
import 'package:ts24care/src/app/provider/api_master.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';
import 'forgetPassword/forget_password.dart';
import 'package:ts24care/src/app/app_localizations.dart';

class LoginPageViewModel extends ViewModelBase {
  final formKey = GlobalKey<FormState>();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool isSecurePass = true;

  TextEditingController _emailController = TextEditingController();

  set emailSetter(email) {
    _emailController.text = email;
  }

  set passSetter(pass) {
    _passController.text = pass;
  }

  get emailController => _emailController;
  TextEditingController _passController = TextEditingController();

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
    var resultPass = Validator.validatePassword(_passController.text);
    if (resultPass != null) {
      _errorPass = resultPass;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidInfo() {
    if (isValidEmail() && isValidPass()) {
      this.updateState();
      return true;
    }
    return false;
  }

  // check login
  void onLoginButtonClicked() async {
    if (isValidInfo()) {
      //Show loading message
      LoadingDialog.showLoadingDialog(
          context, translation.text("WAITING_MESSAGE.AUTH_ACCOUNT"));

      // check login
      var _checkLogin = await api.checkLogin(
        username: _emailController.text.trim(),
        password: _passController.text.trim(),
      );

      if (_checkLogin == StatusCodeGetToken.TRUE) {
//        Navigator.pushReplacementNamed(context, TabsPage.routeName);

        // get info customer
        var customerInfo = await api.getCustomerInfoAfterLogin();
        if (customerInfo != null) {
          print("LOGIN OK");
        }
        LoadingDialog.hideLoadingDialog(context);
        ToastController.show(
            context: context,
            duration: Duration(milliseconds: 300),
            message: translation.text("WAITING_MESSAGE.PERMISSION_CONNECT"));

        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushReplacementNamed(context, TabsPage.routeName,
              arguments: TabsArgument(routeChildName: HelpPage.routeName));
        });
//         Navigator.popAndPushNamed(context, TabsPage.routeName,
//             arguments: TabsArgument(routeChildName: HomePage.routeName));
      } else {
        LoadingDialog.hideLoadingDialog(context);
        return LoadingDialog.showMsgDialog(
            context, translation.text("ERROR_MESSAGE.WRONG_LOGIN"));
      }
    }
  }

  void onShowPasswordClicked() {
    isSecurePass = !isSecurePass;
    this.updateState();
  }


  void onForgetPasswordClicked() {
    Navigator.pushReplacementNamed(context, ForgetPasswordPage.routeName);
  }
}
