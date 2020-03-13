
import 'package:ts24care/src/app/core/baseViewModel.dart';

class SettingsFeedbackPageViewModel extends ViewModelBase {
  int radioValue = -1;

  handleRadioValueChange(int value) {
    radioValue = value;
    this.updateState();
  }
}