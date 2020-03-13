import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/login/forgetPassword/forget_password.dart';
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
    var orientation = MediaQuery.of(context).orientation;
    var ratioScreen = MediaQuery.of(context).devicePixelRatio;

    Widget _header({@required height}) {
      Widget __boundCircle() {
        return FittedBox(
          fit: BoxFit.cover,
          child: Container(
            padding: EdgeInsets.all(2),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  50,
                ),
                border: Border.all(color: Colors.white30, width: 5)),
            child: Container(
              padding: EdgeInsets.all(2),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                  border: Border.all(color: Colors.white70, width: 5)),
              child: Container(
                padding: EdgeInsets.all(2),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                    border: Border.all(color: Colors.white, width: 5)),
              ),
            ),
          ),
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
                      __boundCircle(),
                      Text(
                        translation.text("LOGIN_PAGE.WELCOME_TITLE"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(translation.text("LOGIN_PAGE.SUB_TITLE"),
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
                gradient: LinearGradient(
                  colors: [
                    ThemePrimary.primaryColor,
                    ThemePrimary.primaryColor
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(2.0)),
            child: Container(
              color: Colors.transparent,
              constraints: BoxConstraints(
                  maxWidth: double.infinity, minHeight: height > 550 ? 38 : 30),
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
//                  borderSide: BorderSide(width: 0, color: Colors.transparent),
                  onPressed: () {
//            viewModel.onTapCreateAccountButton(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Text(
                        translation.text("LOGIN_PAGE.NO_ACCOUNT"),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        translation.text("LOGIN_PAGE.CREATE_ACCOUNT_BUTTON"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ThemePrimary.primaryColor,
                            decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget __emailPasswordField() {
        return AspectRatio(
          aspectRatio: orientation == Orientation.landscape
              ? 3 / 2
              : height < 550 ? 1 : 1.27,
          child: Container(
            height: height < 550 ? height * .6 : height * .5,
            padding: EdgeInsets.only(right: 30, left: 30, top: 20),
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
                    viewModel.fieldFocusChange(context,
                        viewModel.emailFocusNode, viewModel.passwordFocusNode);
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
                      obscureText: true,
                      decoration: InputDecoration(
                          errorText: viewModel.errorPass,
                          hintText:
                              translation.text("LOGIN_PAGE.PASSWORD_HINT"),
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
                            viewModel.onForgetPasswordClicked();
                          },
                          child: Text(
                            translation.text("LOGIN_PAGE.PASSWORD_FORGET"),
                            style: TextStyle(
                                color: ThemePrimary.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: true,
                      checkColor: ThemePrimary.primaryColor,
                      activeColor: Colors.white,
                      onChanged: (value) {},
                    ),
                    Text(
                      translation.text("LOGIN_PAGE.PASSWORD_REMEMBER"),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                __loginButton(),
                orientation == Orientation.landscape
                    ? __createAccountButtonLandscape(
                        context: context, height: height)
                    : Offstage()
              ],
            ),
          ),
        );
      }

      return __emailPasswordField();
    }

    Widget _createAccountButtonPortrait({@required context, @required height}) {
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
                  Text(
                    translation.text("LOGIN_PAGE.NO_ACCOUNT"),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    translation.text("LOGIN_PAGE.CREATE_ACCOUNT_BUTTON"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ThemePrimary.primaryColor,
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _body({height}) {
      print(height);
      return SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _header(height: height),
              SizedBox(
                height: 15,
              ),
              _formLogin(height: height),
              orientation == Orientation.portrait
                  ? _createAccountButtonPortrait(
                      context: context, height: height)
                  : Text("")
            ],
          ),
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, _) {
          return TS24Scaffold(
            body: _body(height: height),
          );
        },
      ),
    );
  }
}