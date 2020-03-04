import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_application_model.dart';
import 'package:ts24care/src/app/pages/help/bottomSheetApp/help_bottom_sheet_app_page.dart';
import 'package:ts24care/src/app/pages/help/faq/help_faq_page.dart';
import 'package:ts24care/src/app/pages/help/feedback/help_feedback_page.dart';

class HelpPageViewModel extends ViewModelBase{
  int indexCurrent = 0;
  SwiperController controller = SwiperController();
  List<ItemApplicationModel> listApplication = List();
  HelpPageViewModel(){
   listApplication.addAll(ItemApplicationModel.listApplicationActive);
  }
  onIndexChanged(int index){
    indexCurrent = index;
    this.updateState();
  }
  onTapFAQ(){
    Navigator.pushNamed(context, FAQPage.routeName);
  }

  onTapFeedback() {
    Navigator.pushNamed(context, FeedbackPage.routeName);
  }
  onTapAll() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return FractionallySizedBox(
            heightFactor: 0.8,
              child: BottomSheetAppPage(
                onTapItem: (index) {
                  Navigator.pop(context,index);
                  if(index != null) {
                    indexCurrent = index;
                    controller.move(index);
                    this.updateState();
                  }
                },
                listItemApplicationModel: this.listApplication,
              )
          );
        }
    );
  }
  onTapAdd() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return FractionallySizedBox(
              heightFactor: 0.8,
              child: BottomSheetAppPage(
                onTapItem: (index) {
                  Navigator.pop(context);
                  listApplication.add(ItemApplicationModel.listApplication[index]);
                  this.updateState();
                },
                listItemApplicationModel: ItemApplicationModel.listApplication,
              )
          );
        }
    );
  }
}