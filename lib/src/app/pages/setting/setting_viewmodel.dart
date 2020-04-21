import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/customer.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/pages/help/help_page_v2.dart';
import 'package:ts24care/src/app/pages/login/login_page.dart';
import 'package:ts24care/src/app/pages/setting/userDetail/setting_user_detail_page.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/popupConfirm.dart';
import 'package:ts24care/src/app/widgets/restart_widget.dart';
import 'web_view_page.dart';
import 'settingsFeedback/settings_feedback_page.dart';
import 'settingsNotifications/settings_my_notifications.dart';
import 'package:ts24care/src/app/app_localizations.dart';

class SettingPageViewModel extends ViewModelBase {
  Customer customer;
  String urlLicenses = 'https://web.ts24.com.vn/en_US/dksd';
  String urlPolicy = 'https://web.ts24.com.vn/en_US/csrt';
  CustomPopupMenu selectedLanguage;
  TabsPageViewModel tabsPageViewModel = TabsPageViewModel();
  List<CustomPopupMenu> listLanguages;

  SettingPageViewModel() {
    customer = new Customer();

    listLanguages = [
      CustomPopupMenu(id: 0, title: "Tiếng Việt", subTitle: "vi"),
      CustomPopupMenu(id: 1, title: "English", subTitle: "en")
    ];
    selectedLanguage = (translation.currentLanguage == 'vi')
        ? listLanguages[0]
        : listLanguages[1];
  }

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

  onTapLicenses() async {
    await Navigator.pushNamed(context, WebViewPage.routeName,
            arguments: WebViewArg(
                url: urlLicenses,
                title: '${translation.text("SETTINGS_PAGE.LICENSES")}'))
        .then((_) {
      this.updateState();
    });
  }

  onTapPolicy() async {
    await Navigator.pushNamed(context, WebViewPage.routeName,
            arguments: WebViewArg(
                url: urlPolicy,
                title: '${translation.text("SETTINGS_PAGE.PRIVACY_POLICY")}'))
        .then((_) {
      this.updateState();
    });
  }

  onTapLogout() {
    popupConfirm(
        context: context,
        title: translation.text("POPUP_CONFIRM.TITLE"),
        desc: translation.text("POPUP_CONFIRM.DESC_LOG_OUT"),
        yes: translation.text("POPUP_CONFIRM.YES"),
        no: translation.text("POPUP_CONFIRM.NO"),
        onTap: () {
          Navigator.pop(context);
          customer.clearLocal();
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
          //  api.getListNotification(offset: 0, limit: 10);
        });
  }

  onTapUserDetail() async {
    await Navigator.pushNamed(context, UserDetailPage.routeName,
            arguments: customer)
        .then((_) {
      this.updateState();
    });
  }

  onChangeLanguage(String language) async {
    await translation.setNewLanguage(language, true);
    //OneSignalService.sendTags(parent.toJsonOneSignal(language: language));
    CustomPopupMenu.reLoad();
    RestartWidget.restartApp(context);
  }

  onTapListService() {
    Navigator.pushNamed(context, HelpPage.routeName).then((result) {
      try {
        if (result) {
          tabsPageViewModel.onTap(1);
        }
      } catch (e) {}
    });
  }
}
