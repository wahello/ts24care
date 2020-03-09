import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/bottomSheetApp/help_bottom_sheet_app_page.dart';
import 'package:ts24care/src/app/widgets/ts24SlideWidget/ts24_slide_widget.dart';

class TS24SlideWidgetViewModel extends ViewModelBase {
  double positionDown = 0;
  double positionStart = 0;
  int indexCurrent = 0;
  List<dynamic> listApplication = List();
  List<dynamic> listApplicationFull = List();
  SwiperController controller = SwiperController();
  TS24SlideWidgetViewModel();
  onIndexChanged(int index, TS24SlideCallbackIndexChange callbackIndexChange) {
    indexCurrent = index;
    if (callbackIndexChange != null) {
      callbackIndexChange(index);
    }
    this.updateState();
  }

  onTapAll() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.8,
              child: BottomSheetAppPage(
                onTapItem: (index) {
                  Navigator.pop(context, index);
                  if (index != null) {
                    indexCurrent = index;
                    controller.move(index);
                    this.updateState();
                  }
                },
                listItemApplicationModel: this.listApplication,
              ));
        });
  }

  onTapAdd(TS24SlideCallback callback) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.8,
              child: BottomSheetAppPage(
                onTapItem: (index) {
                  Navigator.pop(context);
                  listApplication.add(listApplicationFull[index]);
                  if (callback != null) callback(listApplication);
                  this.updateState();
                },
                listItemApplicationModel: listApplicationFull,
              ));
        });
  }

  getPositionDragStar(double position) {
    positionStart = position;
  }

  getPositionDragDown(double position) {
    positionDown = position;
  }

  handleDrag() {
    if (positionDown < positionStart) {
      controller.move(indexCurrent - 1);
      if (indexCurrent > 0) {
        indexCurrent--;
//        controller.move(indexCurrent);
      }
    } else {
      controller.move(indexCurrent + 1);
      if (indexCurrent < listApplication.length - 1) {
        indexCurrent++;
//        controller.move(indexCurrent);
      }
    }
    this.updateState();
//    if (callbackIndexChange != null) callbackIndexChange(indexCurrent);
//    print("H1");
  }
}
