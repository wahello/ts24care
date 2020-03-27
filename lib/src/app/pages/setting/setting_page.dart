import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
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

  void _handleSelectLanguage(CustomPopupMenu choice) {
    viewModel.selectedLanguage = choice;
    viewModel.onChangeLanguage(choice.subTitle);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.context = context;

//    final userImage = CachedNetworkImage(
//      imageUrl: viewModel.customer.photo,
//      imageBuilder: (context, imageProvider) => Container(
//        height: 100.0,
//        width: 100.0,
//        decoration: BoxDecoration(
//          // color: Colors.red,
//          image: DecorationImage(
//              image: imageProvider,
//              // MemoryImage(viewModel.parent.photo)
//              fit: BoxFit.cover),
//          shape: BoxShape.circle,
//        ),
//      ),
//    );

    Widget _body() {
      Widget __userInfo() {
        return Stack(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: viewModel.customer.photo,
              imageBuilder: (context, imageProvider) => Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      // MemoryImage(viewModel.parent.photo)
                      fit: BoxFit.cover),
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
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    viewModel.onTapUserDetail();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    //margin: EdgeInsets.only(top: 20, bottom: 40),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFDEDEDF),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFDEDEDF), width: 4),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: viewModel.customer.photo,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                // MemoryImage(viewModel.parent.photo)
                                fit: BoxFit.cover),
                            shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: 130,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    viewModel.customer.name,
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

      //viewModel.selectedLanguage.title
      Widget _buildIconTileLanguages(
          IconData icon, String title, String currentLang) {
        return PopupMenuButton<CustomPopupMenu>(
          child: Column(
            children: <Widget>[
              ListTile(
                  title: Text(
                    title,
                    style: TextStyle(color: Colors.grey[800], fontSize: 16),
                  ),
                  subtitle: Text(currentLang,
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                  trailing: Icon(icon, color: Colors.grey[800])),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 0.5,
                color: Colors.grey[300],
              )
            ],
          ),
//          elevation:  30.2,
          initialValue: viewModel.selectedLanguage,
          onSelected: _handleSelectLanguage,
          offset: Offset(50, viewModel.selectedLanguage.id == 0 ? 50 : 100),
          itemBuilder: (BuildContext context) {
            return viewModel.listLanguages.map((CustomPopupMenu vehicle) {
              return PopupMenuItem<CustomPopupMenu>(
                height: 50,
                value: vehicle,
                child: Text(
                  vehicle.title.toString(),
                  style: TextStyle(fontSize: 14),
                ),
              );
            }).toList();
          },
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            __userInfo(),
//          __item(
//              title: translation.text("SETTINGS_PAGE.NOTIFICATIONS"),
//              iconTrailing: Icons.navigate_next,
//              onTap: () {
//                viewModel.onTapSettingsNotifications();
//              }),
//          __item(
//              title: translation.text("SETTINGS_PAGE.LEAVE_FEEDBACK"),
//              iconTrailing: Icons.navigate_next,
//              onTap: () {
//                viewModel.onTapFeedback();
//              }),
            __item(
                title: translation.text("SETTINGS_PAGE.LICENSES"),
                iconTrailing: Icons.navigate_next,
                onTap: () {
                  viewModel.onTapLicenses();
                }),
            __item(
                title: translation.text("SETTINGS_PAGE.PRIVACY_POLICY"),
                iconTrailing: Icons.navigate_next,
                onTap: () {
                  viewModel.onTapPolicy();
                }),
//          __item(
//              title: translation.text("SETTINGS_PAGE.HELP_CENTER"),
//              iconTrailing: Icons.navigate_next),
//          __item(
//              title: translation.text("SETTINGS_PAGE.ZENDESK_SUPPORT"),
//              subtitle: "${translation.text("VERSION")} 2.2.7",
//              iconTrailing: Icons.navigate_next),
            _buildIconTileLanguages(
                Icons.navigate_next,
                translation.text("SETTINGS_PAGE.LANGUAGES"),
                viewModel.selectedLanguage.title),
            __item(
                title: translation.text("SETTINGS_PAGE.SIGN_OUT"),
                onTap: () {
                  viewModel.onTapLogout();
                }),
            SizedBox(height: 150),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                "${translation.text("VERSION")} $version",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
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
