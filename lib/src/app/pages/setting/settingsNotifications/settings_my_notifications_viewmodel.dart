import 'package:ts24care/src/app/core/baseViewModel.dart';

class SettingsNotificationsPageViewModel extends ViewModelBase {

  bool switchOn = true;

  onSwitchChanged(bool value) {
    switchOn = value;
    this.updateState();
  }

}