import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/setting/setting_viewmodel.dart';

import '../../app_localizations.dart';

class SettingPage extends StatefulWidget {
  static const String routeName = "/SettingsPage";
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with AutomaticKeepAliveClientMixin {
  SettingPageViewModel viewModel = SettingPageViewModel();

  double _sigmaX = 5.0; // from 0-10
  double _sigmaY = 5.0; // from 0-10
  double _opacity = 0.2; // from 0-1.0

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.context = context;
    /*Widget _appBar(){
      return TS24AppBar(
        backgroundColorStart: Colors.grey[200],
        backgroundColorEnd: Colors.grey[200],
        title: Text("Settings",style: TextStyle(color: Colors.black87),),
        elevation: 0,
      );
    }*/
    Widget _body() {
      Widget __userInfo() {
        return Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/user.png'),
                ),
              ),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  color: Colors.black.withOpacity(_opacity),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  viewModel.onTapUserDetail();
                },
                child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 40),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFDEDEDF),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFDEDEDF), width: 4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CircleAvatar(
                        child:
                            Image(image: AssetImage('assets/images/user.png')),
                      ),
                    )),
              ),
            ),
            Positioned.fill(
              top: 100,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tran Duc Thuan',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  )),
            )
          ],
        );
      }

      Widget __item(
          {@required String title,
          String subtitle,
          IconData iconTrailing,
          Function onTap}) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(
                title,
                style: TextStyle(color: Colors.grey[800], fontSize: 16),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    )
                  : null,
              trailing: iconTrailing != null
                  ? Icon(
                      iconTrailing,
                      color: Colors.grey[800],
                    )
                  : null,
              onTap: onTap,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 0.5,
              color: Colors.grey[300],
            )
          ],
        );
      }

      return ListView(
        children: <Widget>[
          __userInfo(),
          __item(
              title: translation.text("SETTINGS_PAGE.NOTIFICATIONS"),
              iconTrailing: Icons.navigate_next,
              onTap: () {
                viewModel.onTapSettingsNotifications();
              }),
          __item(
              title: translation.text("SETTINGS_PAGE.LEAVE_FEEDBACK"),
              iconTrailing: Icons.navigate_next,
              onTap: () {
                viewModel.onTapFeedback();
              }),
          __item(
              title: translation.text("SETTINGS_PAGE.LICENSES"),
              iconTrailing: Icons.navigate_next),
          __item(
              title: translation.text("SETTINGS_PAGE.PRIVACY_POLICY"),
              iconTrailing: Icons.navigate_next),
          __item(
              title: translation.text("SETTINGS_PAGE.HELP_CENTER"),
              iconTrailing: Icons.navigate_next),
          __item(
              title: translation.text("SETTINGS_PAGE.ZENDESK_SUPPORT"),
              subtitle: "${translation.text("VERSION")} 2.2.7",
              iconTrailing: Icons.navigate_next),
          __item(title: translation.text("SETTINGS_PAGE.SIGN_OUT")),
        ],
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Scaffold(
            body: _body(),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
