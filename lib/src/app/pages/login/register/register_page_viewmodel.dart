import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/validator-helper.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/services/apple-service.dart';
import 'package:ts24care/src/app/services/googleplus-service.dart';
import '../../../app_localizations.dart';
import '../login_page_viewmodel.dart';
import 'package:ts24care/src/app/models/res-partner.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class RegisterPageViewModel extends ViewModelBase {
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passEditingController = new TextEditingController();
  TextEditingController passConfirmEditingController =
      new TextEditingController();
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();
  TextEditingController genderEditingController = new TextEditingController();

  String errorName;
  String errorEmail;
  String errorPass;
  String errorPassConfirm;
  String errorPhone;
  String errorAddress;

  bool isSend = false;
  ScrollController scrollController = ScrollController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode passConfirmFocus = FocusNode();
  final FocusNode mailFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();

  TypeLogin typeLogin;

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  RegisterPageViewModel() {
    createEvent();
  }

  getAccountSocial() {
    print(typeLogin);
    switch (typeLogin) {
      case TypeLogin.google:
        emailEditingController.text = GooglePlusService.currentUser.email;
        nameEditingController.text = GooglePlusService.currentUser.displayName;
        this.updateState();
        break;
      case TypeLogin.apple:
        emailEditingController.text = AppleService.currentUser.email;
        nameEditingController.text = AppleService.currentUser.fullName.toString();
        this.updateState();
        break;
      default:
    }
  }

  createEvent() {
    nameEditingController.addListener(() => {isValidName()});
    emailEditingController.addListener(() => {isValidEmail()});
    passEditingController.addListener(() => {isValidPass()});
    passConfirmEditingController.addListener(() => {isValidPassConfirm()});
    phoneEditingController.addListener(() => {isValidPhone()});
//    addressEditingController.addListener(() => {isValidAddress()});
  }

  bool isValidEmail() {
    errorEmail = null;
    var resultEmail = Validator.validateEmail(emailEditingController.text);
    if (resultEmail != null) {
      errorEmail = resultEmail;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidPass() {
    errorPass = null;
    var resultPass = Validator.validatePassword(passEditingController.text);
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
    if (passEditingController.text != passConfirmEditingController.text) {
      errorPassConfirm = translation.text("COMMON.PASS_NOT_TRUE");
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidPhone() {
    errorPhone = null;
    var resultPhone = Validator.validatePhone(phoneEditingController.text);
    if (resultPhone != null) {
      errorPhone = resultPhone;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidName() {
    errorName = null;
    var resultName = Validator.validateName(nameEditingController.text);
    if (resultName != null) {
      errorName = resultName.toString();
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidAddress() {
    errorAddress = null;
    var result = Validator.validAddress(addressEditingController.text);
    if (result != null) {
      errorAddress = result;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    nameEditingController.dispose();
    phoneEditingController.dispose();
    passEditingController.dispose();
    passConfirmEditingController.dispose();
    emailEditingController.dispose();
    addressEditingController.dispose();
  }

  bool isValidInfo() {
    if (isValidEmail() &&
            isValidPass() &&
            isValidPassConfirm() &&
            isValidName() &&
            isValidPhone()
        // && checkPolicy /* && isValidAddress()*/
        ) {
      this.updateState();
      return true;
    }
    return false;
  }

  _socialRegisterAsLogin(String email) async {
//    print('email $email');
//    LoadingDialog.showLoadingDialog(
//        context, translation.text("WAITING_MESSAGE.AUTH_ACCOUNT"));
//    var _checkExist = await api.checkUserExist(email);
//    if (_checkExist != null) {
//      //Đổ data vào parent model
//      await api.getParentInfo(_checkExist.id);
//      //Lấy danh sách children đã mua vé
//      await api.getTicketOfListChildren();
//      //Gửi tags đến onesignal
//      Parent _parent = Parent();
//      print("_parent.email");
//      print(_parent.email);
//      print("_parent.toJsonOneSignal()");
//      print(_parent.toJsonOneSignal());
//      OneSignalService.sendTags(_parent.toJsonOneSignal());
//      LoadingDialog.hideLoadingDialog(context);
//      ToastController.show(
//          context: context,
//          duration: Duration(milliseconds: 300),
//          message: translation.text("WAITING_MESSAGE.PERMISSION_CONNECT"));
//
//      Future.delayed(const Duration(milliseconds: 300), () {
//        Navigator.pushReplacementNamed(context, TabsPage.routeName,
//            arguments: TabsArgument(routeChildName: HomePage.routeName));
//      });
//    } else {
//      LoadingDialog.hideLoadingDialog(context);
//      LoadingDialog.showMsgDialog(context, translation.text("COMMON.FAIL"));
//    }
  }

  onTapCreateAccount() async {
    isSend = true;
    if (!isValidInfo()) return;
    LoadingDialog.showLoadingDialog(
        context, translation.text("COMMON.IN_PROCESS"));
    ResPartner resPartner = new ResPartner();
    resPartner.email = emailEditingController.text;
    resPartner.name = nameEditingController.text;
    resPartner.password = passEditingController.text;
    resPartner.phone = phoneEditingController.text;
    dynamic result = await api.insertUserPortal(resPartner);
    if (result != null) {
      LoadingDialog.hideLoadingDialog(context);
//      _socialRegisterAsLogin(emailEditingController.text);
//      Future.delayed(const Duration(milliseconds: 300), () {
//        Navigator.pushReplacementNamed(context, TabsPage.routeName,
//            arguments: TabsArgument(routeChildName: HomePage.routeName));
//      });
      LoadingDialog.showLoadingDialog(
          context, translation.text("COMMON.REGISTER_SUCCESS"));
      Future.delayed(Duration(seconds: 2)).then((_) {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pop(
            context, [emailEditingController.text, passEditingController.text]);
        //Navigator.pop(context, emailEditingController.text);
      });
    } else {
      LoadingDialog.hideLoadingDialog(context);
      LoadingDialog.showMsgDialog(
          context, translation.text("COMMON.REGISTER_FAIL"));
//      LoadingDialog.showLoadingDialog(
//          context, translation.text("COMMON.REGISTER_FAIL"));
//      Future.delayed(Duration(seconds: 2)).then((_) {
//        LoadingDialog.hideLoadingDialog(context);
//      });
    }
  }
}
