import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/setting/settingsNotifications/settings_my_notifications_viewmodel.dart';

import '../../../app_localizations.dart';

class SettingsNotificationsPage extends StatefulWidget {
  static const String routeName = "/settingsNotficationsPage";
  @override
  SettingsNotificationsPageState createState() =>
      SettingsNotificationsPageState();
}

class SettingsNotificationsPageState extends State<SettingsNotificationsPage> {
  SettingsNotificationsPageViewModel viewModel =
      SettingsNotificationsPageViewModel();

  @override
  Widget build(BuildContext context) {

    Widget _itemSwitchInNotifications(String label, bool switchOn,
        {Function onSwitchChanged}) {
      return Padding(
        padding: EdgeInsets.all(2),
        child: ListTile(
          title: Text(label),
          trailing: Switch(
            onChanged: (value){
              onSwitchChanged(value);
            },
            value: switchOn,
          ),
        ),
      );
    }

    Widget _itemCheckInNotifications(String label, bool showIcon) {
      return ListTile(
        title: Text(label),
        trailing: Visibility(
          visible: showIcon,
          child: Icon(
            Icons.check,
            size: 25,
            color: Colors.blue,
          ),
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return Scaffold(
                appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    centerTitle: true,
                    elevation: 1,
                    backgroundColor: Colors.white,
                    title: Text(translation.text("SETTINGS_NOTIFICATIONS_PAGE.TITLE"),
                        style: TextStyle(color: Colors.black))),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _itemSwitchInNotifications(
                          translation.text("SETTINGS_NOTIFICATIONS_PAGE.ENABLE_NOTIFICATIONS"), viewModel.switchOn,
                          onSwitchChanged: (value) {
                        viewModel.onSwitchChanged(value);
                      }),
                      Padding(
                        padding: EdgeInsets.fromLTRB(2, 5, 2, 2),
                        child: ListTile(
                          title: Text(translation.text("SETTINGS_NOTIFICATIONS_PAGE.NOTIFY_ME_ABOUT"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                      _itemSwitchInNotifications(translation.text("SETTINGS_NOTIFICATIONS_PAGE.ALL_NEW_TICKETS"), true, onSwitchChanged: (value){}),
                      _itemSwitchInNotifications(translation.text("SETTINGS_NOTIFICATIONS_PAGE.TICKETS_I'M_FOLLOWING"), true,  onSwitchChanged: (value){}),
                      _itemSwitchInNotifications(translation.text("SETTINGS_NOTIFICATIONS_PAGE.TICKETS_I'M_CC'D_ON"), true,  onSwitchChanged: (value){}),
                      _itemSwitchInNotifications(translation.text("SETTINGS_NOTIFICATIONS_PAGE.TICKETS_ASSIGNED_TO_ME"), true,  onSwitchChanged: (value){}),
                      _itemSwitchInNotifications(translation.text("SETTINGS_NOTIFICATIONS_PAGE.TICKETS_ASSIGNED_TO_MY_GROUPS"), true, onSwitchChanged: (value){}),
                      Padding(
                        padding: EdgeInsets.fromLTRB(2, 5, 2, 2),
                        child: ListTile(
                          title: Text(translation.text("SETTINGS_NOTIFICATIONS_PAGE.TICKETS_ASSIGNED_TO_MY_GROUPS"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                      _itemCheckInNotifications(translation.text("SETTINGS_NOTIFICATIONS_PAGE.All_GROUPS"), true),
                      _itemCheckInNotifications(translation.text("SETTINGS_NOTIFICATIONS_PAGE.SELECT_GROUPS"), false),
                      Padding(
                        padding: EdgeInsets.fromLTRB(2, 5, 2, 2),
                        child: ListTile(
                          title: Text(translation.text("SETTINGS_NOTIFICATIONS_PAGE.NOTIFICATION_FREQUENCY"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                      _itemCheckInNotifications(translation.text("SETTINGS_NOTIFICATIONS_PAGE.ALWAYS"), true),
                      _itemCheckInNotifications(translation.text("SETTINGS_NOTIFICATIONS_PAGE.DURING_SPECIFIC_HOURS"), false),
                    ],
                  ),
                ));
          }),
    );
  }


}
