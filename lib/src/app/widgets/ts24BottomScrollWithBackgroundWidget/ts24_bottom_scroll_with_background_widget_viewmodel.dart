import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';

typedef OnFreshCallback = Future<void> Function();
typedef ScrollControllerCallback = void Function(ScrollController controller);
class TS24BottomScrollWithBackgroundWidgetViewModel extends ViewModelBase {
  StreamController streamControllerBottomScrollWidget = StreamController<double>();
  double heightImageBackgroundMax = 270;
  double heightImageBackgroundCurrent = 0;
  double heightViewBackground = 0;
  double heightAppbar = 80;
  ScrollController controller = ScrollController();
  double currentOffset = 0;
  TS24BottomScrollWithBackgroundWidgetViewModel();
//  getHeightImageBackground(double input) {
//    if (currentOffset > input) {
//      heightImageBackgroundCurrent = heightImageBackgroundMax -
//          (heightViewBackground - (input)).abs();
//      currentOffset = input;
//    }
//    else {
//      heightImageBackgroundCurrent = heightImageBackgroundMax -
//          (heightViewBackground - (input)).abs();
//      currentOffset = input;
//    }
//    this.updateState();
//  }
  @override
  void dispose() {
    streamControllerBottomScrollWidget.close();
    controller.dispose();
    super.dispose();
  }
}
