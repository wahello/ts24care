import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/login/forgetPassword/forget_password_viewmodel.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/app_localizations.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const String routeName = "/forgetPassword";

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  ForgetPasswordPageViewModel viewModel = ForgetPasswordPageViewModel();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var rotate = MediaQuery.of(context).orientation;
    const double kBottomNavigationBarHeight = 56.0;
    viewModel.context = context;

    Widget _titleForgetPassword({title}) {
      return Text(
        title,
        style: TextStyle(
          color: ThemePrimary.primaryColor,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget _descriptionForgetPassword({subTitle}) {
      return Container(
        padding: EdgeInsets.only(right: 50, left: 50, bottom: 30, top: 7),
        child: Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    Widget _textFieldEmail({text}) {
      return Container(
        padding: EdgeInsets.only(right: 50, left: 50, bottom: 5, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Text(
//              text,
//              style: TextStyle(fontWeight: FontWeight.bold),
//            ),
            TextFormField(
              focusNode: viewModel.emailNode,
              controller: viewModel.emailController,
              decoration: InputDecoration(
                hintText: translation.text("FORGET_PASSWORD_PAGE.EMAIL_HINT"),
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
                errorText: viewModel.errorEmail,
              ),
              onFieldSubmitted: (_) {
                viewModel.onSubmitClicked();
              },
            )
          ],
        ),
      );
    }

    Widget _submitButton({title}) {
      return RaisedButton(
        onPressed: () {
          viewModel.onSubmitClicked();
        },
        color: ThemePrimary.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget _appBar() {
      return AppBar(
        //leading: Container(),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      );
    }

    Widget _body({size}) {
      return SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Image.asset("assets/images/key.png"),
                    ),
                    _titleForgetPassword(
                      title: translation.text("FORGET_PASSWORD_PAGE.TITLE"),
                    ),
                    _descriptionForgetPassword(
                      subTitle:
                          translation.text("FORGET_PASSWORD_PAGE.SUB_TITLE"),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    _textFieldEmail(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: <Widget>[
                        _submitButton(
                          title: translation
                              .text("FORGET_PASSWORD_PAGE.SUBMIT_BUTTON"),
                        ),
//                        Container(
//                            padding: EdgeInsets.only(top: 5),
//                            child: FlatButton(
//                              onPressed: () {},
//                              child: Column(
//                                children: <Widget>[
//                                  Text(
//                                    translation.text(
//                                        "FORGET_PASSWORD_PAGE.NO_ACCOUNT"),
//                                    style: TextStyle(color: Colors.grey),
//                                  ),
//                                  Text(
//                                    translation.text(
//                                        "FORGET_PASSWORD_PAGE.CREATE_ACCOUNT"),
//                                    style: TextStyle(
//                                        color: ThemePrimary.primaryColor,
//                                        fontWeight: FontWeight.bold,
//                                        decoration: TextDecoration.underline),
//                                  ),
//                                ],
//                              ),
//                            ))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _appBar(),
            body: _body(size: size),
          );
        },
      ),
    );
  }
}
