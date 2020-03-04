import 'package:flutter/cupertino.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';

class TS24BottomScrollWithBackgroundViewModel extends ViewModelBase {
  double heightImageBackgroundMax = 270;
  double heightImageBackgroundCurrent = 0;
  double heightViewBackground = 0;
  double heightAppbar = 80;
  ScrollController controller = ScrollController();
  double currentOffset = 0;
  TS24BottomScrollWithBackgroundViewModel();
  getHeightImageBackground(double input) {
    if (currentOffset > input) {
      heightImageBackgroundCurrent = heightImageBackgroundMax -
          (heightViewBackground - (input - heightAppbar)).abs();
      currentOffset = input;
    }
    else {
      heightImageBackgroundCurrent = heightImageBackgroundMax -
          (heightViewBackground - (input - heightAppbar)).abs();
      currentOffset = input;
    }
    this.updateState();
  }
}
