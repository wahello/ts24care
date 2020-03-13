import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/setting/userDetail/setting_user_detail_page.dart';
import 'settingsFeedback/settings_feedback_page.dart';
import 'settingsNotifications/settings_my_notifications.dart';

class SettingPageViewModel extends ViewModelBase {
  SettingPageViewModel();

  onTapSettingsNotifications() async {
    await Navigator.pushNamed(context, SettingsNotificationsPage.routeName,
        arguments: '')
        .then((_) {
      this.updateState();
    });

  }
  onTapFeedback() async {
    await Navigator.pushNamed(context, SettingsFeedbackPage.routeName,
        arguments: '')
        .then((_) {
      this.updateState();
    });

  }
  onTapUserDetail() async {
    await Navigator.pushNamed(context, UserDetailPage.routeName)
        .then((_) {
      this.updateState();
    });
  }

}
