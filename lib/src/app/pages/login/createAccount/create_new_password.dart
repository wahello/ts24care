import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/login/createAccount/create_new_password_viewmodel.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/app_localizations.dart';

class CreateNewPasswordPage extends StatefulWidget {
  static const String routeName = "/createAccount";

  @override
  _CreateNewPasswordPageState createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  CreateAccountPageViewModel viewModel = CreateAccountPageViewModel();

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    viewModel.context = context;

    Widget _titleCreateNewPassword({title}) {
      return Text(
        title,
        style: TextStyle(
            color: ThemePrimary.primaryColor,
            fontSize: 19,
            fontWeight: FontWeight.bold),
      );
    }

    Widget _textDescriptionCreateNewPassword({subTitle}) {
      return Container(
        padding: EdgeInsets.only(right: 50, left: 50, bottom: 30, top: 5),
        child: Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    Widget _doneButton({title}) {
      return RaisedButton(
        onPressed: () {
          viewModel.onDoneButtonClicked(context);
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

    Widget _textFieldPassword({tile, hint}) {
      return Container(
        padding: EdgeInsets.only(right: 50, left: 50, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              tile,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              obscureText: true,
              controller: viewModel.passController,
              focusNode: viewModel.passFocus,
              decoration: InputDecoration(
                  errorText: viewModel.errorPass,
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold)),
              onFieldSubmitted: (_) {
                viewModel.fieldFocusChange(
                    context, viewModel.passFocus, viewModel.passConfirmFocus);
              },
            )
          ],
        ),
      );
    }

    Widget _textFieldPassConfirm({title, hint}) {
      return Container(
        padding: EdgeInsets.only(right: 50, left: 50, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              obscureText: true,
              focusNode: viewModel.passConfirmFocus,
              controller: viewModel.passControllerConfirm,
              decoration: InputDecoration(
                  errorText: viewModel.errorPassConfirm,
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold)),
              onFieldSubmitted: (_) {
                viewModel.onDoneButtonClicked(context);
              },
            )
          ],
        ),
      );
    }

    Widget _appBar() {
      return AppBar(
        leading: GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, LoginPage.routeName),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      );
    }

    Widget _body({@required orientation}) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Image.asset(
                    "assets/images/key.png",
                  ),
                ),
                _titleCreateNewPassword(
                  title: translation.text("CREATE_NEW_PASSWORD_PAGE.TITLE"),
                ),
                _textDescriptionCreateNewPassword(
                  subTitle:
                      translation.text("CREATE_NEW_PASSWORD_PAGE.SUB_TITLE"),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: orientation == Orientation.landscape
                      ? EdgeInsets.only(top: 0)
                      : EdgeInsets.only(bottom: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _textFieldPassword(
                            tile: translation
                                .text("CREATE_NEW_PASSWORD_PAGE.PASSWORD"),
                            hint: translation.text(
                                "CREATE_NEW_PASSWORD_PAGE.PASSWORD_HINT")),
                        _textFieldPassConfirm(
                          title: translation.text(
                              "CREATE_NEW_PASSWORD_PAGE.PASSWORD_CONFIRM"),
                          hint: translation.text(
                              "CREATE_NEW_PASSWORD_PAGE.PASSWORD_CONFIRM_HINT"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: _doneButton(
                  title:
                      translation.text("CREATE_NEW_PASSWORD_PAGE.DONE_BUTTON"),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Column(
                    children: <Widget>[
                      Text(
                        translation.text("CREATE_NEW_PASSWORD_PAGE.NO_ACCOUNT"),
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        translation
                            .text("CREATE_NEW_PASSWORD_PAGE.CREATE_ACCOUNT"),
                        style: TextStyle(
                            color: ThemePrimary.primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _appBar(),
            body: _body(orientation: orientation),
          );
        },
      ),
    );
  }
}
