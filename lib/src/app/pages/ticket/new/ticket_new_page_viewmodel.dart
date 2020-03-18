import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/widgets/ts24CameraWidget/ts24_camera_widget.dart';

class TicketNewPageViewModel extends ViewModelBase{
  TicketNewPageViewModel();

  onTapBack() {
    Navigator.pop(context);
  }
  onSelected(MenuAttachmentState attachmentState){
     switch(attachmentState){
       case MenuAttachmentState.CAMERA:
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => TS24CameraWidget()),
         );
         break;
       case MenuAttachmentState.IMAGE:
         // TODO: Handle this case.
         break;
       case MenuAttachmentState.FILE:
         // TODO: Handle this case.
         break;
     }
  }
}