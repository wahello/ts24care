import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/login/login_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:flutter/services.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPageViewModel viewModel = LoginPageViewModel();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
//    viewModel.emailSetter = 'demo@ts24corp.com';
//    viewModel.passSetter = '123456';
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  void deactivate() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    Widget _header({@required height}) {
      Widget __boundCircle({double size, Widget child, Color color}) {
        return Container(
          padding: EdgeInsets.all(2),
          height: size,
          width: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                50,
              ),
              border: Border.all(color: color, width: 5)),
          child: child,
        );
      }

      Widget __textHeader({text, TextStyle style}) {
        return Text(
          text,
          style: style,
        );
      }

      return AspectRatio(
        aspectRatio: orientation == Orientation.landscape ? 2.7 : 4 / 2,
        child: Container(
            height: height < 550 ? height * .22 : height * .3,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xff000000).withOpacity(0.1),
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/header.jpg",
                    ),
                    fit: BoxFit.cover)),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      __boundCircle(
                          size: 50.0,
                          color: Colors.white30,
                          child: __boundCircle(
                              size: 40.0,
                              color: Colors.white70,
                              child: __boundCircle(
                                size: 30.0,
                                color: Colors.white,
                              ))),
                      __textHeader(
                          text: translation.text("LOGIN_PAGE.WELCOME_TITLE"),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          )),
                      __textHeader(
                          text: translation.text("LOGIN_PAGE.SUB_TITLE"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            )),
      );
    }

    Widget _formLogin({@required height}) {
      Widget __loginButton() {
        return RaisedButton(
          padding: EdgeInsets.all(0),
          color: Colors.white,
          elevation: 0,
          onPressed: () {
            viewModel.onLoginButtonClicked();
          },
          child: Ink(
            decoration: BoxDecoration(
                color: ThemePrimary.primaryColor,
                borderRadius: BorderRadius.circular(2.0)),
            child: Container(
              color: Colors.transparent,
//              constraints: BoxConstraints(
//                  maxWidth: double.infinity, minHeight: height > 550 ? 38 : 30),
              alignment: Alignment.center,
              child: Text(
                translation.text("LOGIN_PAGE.LOGIN_BUTTON"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }

      __formLoginText({String text, TextStyle style}) {
        return Text(
          text,
          style: style,
        );
      }

      Widget __createAccountButtonLandscape(
          {@required context, @required height}) {
        return Container(
//          height: height * .18,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                    maxWidth: double.infinity,
                    minHeight: height > 550 ? 38 : 30),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
//            viewModel.onTapCreateAccountButton(context);
                  },
                  child: Column(
                    children: <Widget>[
                      __formLoginText(
                          text: translation.text("LOGIN_PAGE.NO_ACCOUNT"),
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      __formLoginText(
                          text: translation.text("LOGIN_PAGE.REGISTER"),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemePrimary.primaryColor,
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget __emailPasswordField() {
        return Container(
//            height: height < 550 ? height * .6 : height * .5,
          padding: EdgeInsets.only(right: 30, left: 30, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                translation.text("LOGIN_PAGE.EMAIL"),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                focusNode: viewModel.emailFocusNode,
                controller: viewModel.emailController,
                decoration: InputDecoration(
                    errorText: viewModel.errorEmail,
                    hintText: translation.text("LOGIN_PAGE.EMAIL_HINT"),
                    hintStyle: TextStyle(
                      fontSize: 13,
                    )),
                onFieldSubmitted: (_) {
                  viewModel.fieldFocusChange(context, viewModel.emailFocusNode,
                      viewModel.passwordFocusNode);
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                translation.text("LOGIN_PAGE.PASSWORD"),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Stack(
                children: <Widget>[
                  TextFormField(
                    focusNode: viewModel.passwordFocusNode,
                    controller: viewModel.passController,
                    obscureText: viewModel.isSecurePass,
                    decoration: InputDecoration(
                        errorText: viewModel.errorPass,
                        hintText: translation.text("LOGIN_PAGE.PASSWORD_HINT"),
                        hintStyle: TextStyle(
                          fontSize: 13,
                        )),
                    onFieldSubmitted: (_) {
                      viewModel.onLoginButtonClicked();
                    },
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                        onTap: () {
                          viewModel.onShowPasswordClicked();
                        },
                        child: Text(
                          viewModel.isSecurePass
                              ? translation.text("LOGIN_PAGE.PASSWORD_SHOW")
                              : translation.text("LOGIN_PAGE.PASSWORD_HIDE"),
                          style: TextStyle(
                              color: ThemePrimary.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        )),
                  )
                ],
              ),

// remember password
//              Row(
//                children: <Widget>[
//                  Checkbox(
//                    value: true,
//                    checkColor: ThemePrimary.primaryColor,
//                    activeColor: Colors.white,
//                    onChanged: (value) {},
//                  ),
//                  Text(
//                    translation.text("LOGIN_PAGE.PASSWORD_REMEMBER"),
//                    style: TextStyle(
//                      color: Colors.grey,
//                      fontSize: 12,
//                    ),
//                  )
//                ],
//              ),
              SizedBox(
                height: 30,
              ),
              __loginButton(),
//              orientation == Orientation.landscape
//                  ? __createAccountButtonLandscape(
//                      context: context, height: height)
//                  : Offstage()
            ],
          ),
        );
      }

      return __emailPasswordField();
    }

    Widget _createAccountButtonPortrait({@required context, @required height}) {
      __createAccountButtonPortrait({text, style}) {
        return Text(
          text,
          style: style,
        );
      }

      return Container(
        height: height * .15,
        child: Column(
          mainAxisAlignment:
              height < 600 ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
//            viewModel.onTapCreateAccountButton(context);
              },
              child: Column(
                children: <Widget>[
                  __createAccountButtonPortrait(
                      text:
                          translation.text("LOGIN_PAGE.CREATE_ACCOUNT_BUTTON"),
                      style: TextStyle(
                        color: Colors.grey,
                      )),

// create button lanscapse

//                  __createAccountButtonPortrait(
//                      text:
//                          translation.text("LOGIN_PAGE.CREATE_ACCOUNT_BUTTON"),
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          color: ThemePrimary.primaryColor,
//                          decoration: TextDecoration.underline)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _socialLogin() {
      List<BoxShadow> __initBoxShadow() {
        return [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),
        ];
      }

      Widget _loginGoogle() {
        return Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: Color(0xffDC4E41),
            //pe: BoxShape.circle,
            borderRadius: BorderRadius.circular(5),
            boxShadow: __initBoxShadow(),
          ),
          child: Material(
              color: Colors.transparent,
              child: Center(
                child: Icon(
                  FontAwesomeIcons.googlePlusG,
                  color: Colors.white,
                  size: 30,
                ),
              )),
        );
      }

      Widget _loginApple() {
        return
            //Platform.isIOS ?
            Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            boxShadow: __initBoxShadow(),
          ),
          child: Material(
              color: Colors.transparent,
              child: Center(
                child: Icon(
                  FontAwesomeIcons.apple,
                  color: Colors.white,
                  size: 33,
                ),
              )),
        );
        //: Container();
      }

      return Container(
        width: MediaQuery.of(context).size.width,
//        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 2,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  translation.text('LOGIN_PAGE.SOCIAL_LOGIN'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.grey[400]),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 2,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                _loginFacebook(),
//                SizedBox(
//                  width: 10,
//                ),
                _loginGoogle(),
                SizedBox(
                  width: 10,
                ),
                _loginApple(),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            // Center(
            //   child: InkWell(
            //     onTap: () {
            //       viewModel.onTapForgotPassword();
            //     },
            //     child: Text(
            //       '${translation.text("LOGIN_PAGE.FORGOT_PASS")}?',
            //       style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w700,
            //           color: Colors.grey[500],
            //           decoration: TextDecoration.underline),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${translation.text("LOGIN_PAGE.NO_ACCOUNT")}?',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () {
                      viewModel.onTapRegister();
                    },
                    child: Text(
                      translation.text("LOGIN_PAGE.REGISTER"),
                      style: TextStyle(
                          color: ThemePrimary.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      );
    }

//    Widget _body({height}) {
//      return SingleChildScrollView(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            _header(height: height),
//            SizedBox(
//              height: 15,
//            ),
//            _formLogin(height: height),
//            _socialLogin()
//
//// create account
////            orientation == Orientation.portrait
////                ? _createAccountButtonPortrait(
////                    context: context, height: height)
////                : Offstage()
//          ],
//        ),
//      );
//    }
    Widget _body() {
      Widget __header() {
        return Container(
          margin: EdgeInsets.only(left: 15, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                translation.text("LOGIN_PAGE.WELCOME_TITLE"),
                style:
                    TextStyle(color: ThemePrimary.primaryColor, fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                translation.text("LOGIN_PAGE.SUB_TITLE"),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }

      Widget __middle() {
        Widget ___loginButton() {
          return Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: RaisedButton(
              padding: EdgeInsets.all(0),
              color: Colors.white,
              elevation: 0,
              onPressed: () {
                viewModel.onLoginButtonClicked();
              },
              child: Ink(
                decoration: BoxDecoration(
                    color: ThemePrimary.primaryColor,
                    borderRadius: BorderRadius.circular(2.0)),
                child: Container(
                  color: ThemePrimary.primaryColor,
                  constraints:
                      BoxConstraints(maxWidth: double.infinity, minHeight: 38
//                      height > 550 ? 38 : 30
                          ),
                  alignment: Alignment.center,
                  child: Text(
                    translation.text("LOGIN_PAGE.LOGIN_BUTTON"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        Widget ___socialLogin() {
          List<BoxShadow> __initBoxShadow() {
            return [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 5.0),
                  blurRadius: 5.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -3.0),
                  blurRadius: 3.0),
            ];
            return [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ];
          }

          Widget _loginGoogle() {
            return Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffDC4E41),
                //shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: __initBoxShadow(),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24.0),
                  onTap: viewModel.googleLogin,
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.googlePlusG,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }

          Widget _loginApple() {
            return Platform.isIOS
                ? Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
//                      color: Color(0xffDC4E41),
                      //shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
//                      shape: BoxShape.circle,
                      boxShadow: __initBoxShadow(),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24.0),
                        onTap: () {
                          viewModel.appleLogin();
                        },
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.apple,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container();
          }

          return Container(
            margin: EdgeInsets.only(top: 25),
            width: MediaQuery.of(context).size.width,
//        height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//              SizedBox(
//                height: 15,
//              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                    SizedBox(
//                      width: 30,
//                    ),
//                    Expanded(
//                      flex: 1,
//                      child: Container(
//                        height: 2,
//                        color: Colors.grey[400],
//                      ),
//                    ),
//                    SizedBox(
//                      width: 5,
//                    ),
                    Text(
//                      translation.text('LOGIN_PAGE.SOCIAL_LOGIN'),
                      'Hoặc đăng nhập bằng tài khoản',
                      style: TextStyle(
                          //fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.grey[400]),
                    ),
//                    SizedBox(
//                      width: 5,
//                    ),
//                    Expanded(
//                      flex: 1,
//                      child: Container(
//                        height: 2,
//                        color: Colors.grey[400],
//                      ),
//                    ),
//                    SizedBox(
//                      width: 30,
//                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                _loginFacebook(),
//                SizedBox(
//                  width: 10,
//                ),
                    _loginGoogle(),
                    SizedBox(
                      width: 10,
                    ),
                    _loginApple(),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                // Center(
                //   child: InkWell(
                //     onTap: () {
                //       viewModel.onTapForgotPassword();
                //     },
                //     child: Text(
                //       '${translation.text("LOGIN_PAGE.FORGOT_PASS")}?',
                //       style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w700,
                //           color: Colors.grey[500],
                //           decoration: TextDecoration.underline),
                //     ),
                //   ),
                // ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    '${translation.text("LOGIN_PAGE.NO_ACCOUNT")}?',
//                    style: TextStyle(fontSize: 15),
//                  ),
//                  SizedBox(
//                    width: 5,
//                  ),
//                  InkWell(
//                      onTap: () {
//                        viewModel.onTapRegister();
//                      },
//                      child: Text(
//                        translation.text("LOGIN_PAGE.REGISTER"),
//                        style: TextStyle(
//                            color: ThemePrimary.primaryColor,
//                            fontSize: 16,
//                            fontWeight: FontWeight.w700,
//                            decoration: TextDecoration.underline,
//                            decorationThickness: 2),
//                      ))
//                ],
//              ),
              ],
            ),
          );
        }

        Widget __formLogin() {
          return Container(
              color: ThemePrimary.backgroundPrimaryColor,
              margin: EdgeInsets.only(top: 15),
              //constraints: BoxConstraints.expand(width: width),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
//                    margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                    margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.mail_outline,
                            color: ThemePrimary.primaryColor,
                            size: 30,
                          ),
                        ),
//                        Expanded(
//                          flex: 2,
//                          child: Text(
//                            translation.text("LOGIN_PAGE.EMAIL"),
//                            style: TextStyle(
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                        ),
                        Flexible(
                            flex: 4,
                            child: TextField(
                              focusNode: viewModel.emailFocusNode,
                              controller: viewModel.emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: viewModel.errorEmail,
                                  hintText:
//                                      translation.text("LOGIN_PAGE.EMAIL_HINT"),
                                      translation.text("LOGIN_PAGE.EMAIL"),
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                  )),
                              keyboardType: TextInputType.emailAddress,
                              onSubmitted: (_) {
                                viewModel.fieldFocusChange(
                                    context,
                                    viewModel.emailFocusNode,
                                    viewModel.passwordFocusNode);
                              },
//                      onFieldSubmitted: (_) {
//                        viewModel.fieldFocusChange(context, viewModel.emailFocusNode,
//                            viewModel.passwordFocusNode);
//                      },
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.lock_outline,
                            color: ThemePrimary.primaryColor,
                            size: 30,
                          ),
                        ),
//                        Expanded(
//                          flex: 2,
//                          child: Text(
//                            translation.text("LOGIN_PAGE.PASSWORD"),
//                            style: TextStyle(
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                        ),

                        Flexible(
                            flex: 4,
                            child: Stack(
                              children: <Widget>[
                                TextFormField(
                                  focusNode: viewModel.passwordFocusNode,
                                  controller: viewModel.passController,
                                  obscureText: viewModel.isSecurePass,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorText: viewModel.errorPass,
                                      hintText:
//                                      translation.text("LOGIN_PAGE.PASSWORD_HINT"),
                                          translation
                                              .text("LOGIN_PAGE.PASSWORD"),
                                      hintStyle: TextStyle(
                                        fontSize: 13,
                                      )),
                                  onFieldSubmitted: (_) {
                                    print('OKOK');
                                    viewModel.onLoginButtonClicked();
                                  },
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                      onTap: () {
                                        viewModel.onShowPasswordClicked();
                                      },
                                      child: Icon(
                                        viewModel.isSecurePass
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                        size: 22,
                                      )
//                                      Text(
//                                        viewModel.isSecurePass
//                                            ? translation.text(
//                                                "LOGIN_PAGE.PASSWORD_SHOW")
//                                            : translation.text(
//                                                "LOGIN_PAGE.PASSWORD_HIDE"),
//                                        style: TextStyle(
//                                            color: ThemePrimary.primaryColor,
//                                            fontWeight: FontWeight.bold,
//                                            fontSize: 12),
//                                      )
                                      ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  ___loginButton(),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Text(
                              translation.text('LOGIN_PAGE.CREATE_ACCOUNT'),
                              style:
                                  TextStyle(color: ThemePrimary.primaryColor)),
                          onTap: () {
                            viewModel.onTapRegister();
                          },
                        ),
                        InkWell(
                          child: Text(
                              translation.text('LOGIN_PAGE.FORGOT_PASSWORD'),
                              style:
                                  TextStyle(color: ThemePrimary.primaryColor)),
                          onTap: () {
                            viewModel.onForgetPasswordClicked();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ___socialLogin()
                ],
              ));
        }

        return Container(
          //height: 1000,
          //color: Colors.red,
          //constraints: BoxConstraints.expand(height: 160),
          child: Stack(
            children: <Widget>[
              Center(child: __formLogin()),
//              Align(
//                alignment: Alignment.topCenter,
//                child: Image.asset('assets/images/TS24care-logo.png',
//                    width: 50, height: 50),
//              ),
            ],
          ),
        );
      }

      return OrientationBuilder(builder: (context, orientation) {
        return Stack(children: <Widget>[
          Container(
            color: ThemePrimary.backgroundPrimaryColor,
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage("assets/images/bgd.png"),
//                fit: BoxFit.cover,
//              ),
//            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                Container(
//                  height: orientation == Orientation.portrait
//                      ? MediaQuery.of(context).size.height * 0.25
//                      : MediaQuery.of(context).size.width * 0.25,
//                  child: __header(),
//                ),
                Container(
                  color: ThemePrimary.primaryColor,
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * 0.25 + 40
                      : MediaQuery.of(context).size.width * 0.25,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Đăng nhập vào TS24care',
                            style:
                                TextStyle(color: Colors.white, fontSize: 22)),
                      )
//                    Image.asset('assets/images/Ts24care-text.png',
//                        width: 150, height: 30),
                      ),
                ),
                __middle(),
              ],
            ),
          )
        ]);
      });
//       SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/bgd.png"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               __header(),
//               // __middle(),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Image.asset('assets/images/Ts24care-text.png',
//                     width: 150, height: 30),
//               ),
//               SizedBox(height: 10)
//               // Expanded(flex: 2, child: __header()),
//               // Expanded(
//               //   flex: 4,
//               //   child: __middle(),
//               // ),
//               // Expanded(
//               //   flex: 1,
//               //   child: Align(
//               //     alignment: Alignment.bottomCenter,
//               //     child: Image.asset('assets/images/Ts24care-text.png',
//               //         width: 150, height: 30),
//               //   ),
//               // ),

//               //Image.asset('assets/images/Ts24care-text.jpg')
//             ],
//           ) /* add child content here */,
//         ),
//       );

//       return SingleChildScrollView(
//         child: Container(
//           constraints: BoxConstraints(minWidth: width, minHeight: height),
// //          child: Column(
// //            mainAxisSize: MainAxisSize.max,
// //            crossAxisAlignment: CrossAxisAlignment.start,
// //            children: <Widget>[
// //              Expanded(
// //                flex: 2,
// //                child: __header()
// //              ),
// //              Expanded(
// //                flex: 4,
// //                child: __middle(),
// //              ),
// //              Expanded(
// //                flex: 1,
// //                child: Align(
// //                  alignment: Alignment.bottomCenter,
// //                  child: Image.asset('assets/images/Ts24care-text.png',
// //                      width: 150, height: 30),
// //                ),
// //              ),
// //
// //
// //              //Image.asset('assets/images/Ts24care-text.jpg')
// //            ],
// //          ),
//         ),
//       );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, _) {
          return TS24Scaffold(
            resizeToAvoidBottomPadding: false,
            body: _body(),
          );
        },
      ),
    );
  }
}
