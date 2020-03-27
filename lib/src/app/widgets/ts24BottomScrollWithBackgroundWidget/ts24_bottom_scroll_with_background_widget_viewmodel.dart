import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';

typedef OnFreshCallback = Future<void> Function();
class TS24BottomScrollWithBackgroundWidgetViewModel extends ViewModelBase {
  StreamController streamController111 = StreamController<double>();
  double heightImageBackgroundMax = 270;
  double heightImageBackgroundCurrent = 0;
  double heightViewBackground = 0;
  double heightAppbar = 80;
  ScrollController controller = ScrollController();
  double currentOffset = 0;
  TS24BottomScrollWithBackgroundWidgetViewModel();
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
  @override
  void dispose() {
    streamController111.close();
    super.dispose();
  }
}
