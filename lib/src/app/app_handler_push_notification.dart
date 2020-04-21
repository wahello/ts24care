import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:get/get.dart';
import 'package:ts24care/src/app/pages/ticket/detail/ticket_detail_page.dart';
import 'package:ts24care/src/app/services/onesingal-service.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class HandlerPushNotification {
  // StreamController streamController = StreamController.broadcast();
  // Stream get stream => streamController.stream;

  void dispose() {
    // streamController.close();
    // streamController = StreamController();
  }

  init() {
    OneSignalService.notificationOpenedHandler((oSNotification) {
      var addData = oSNotification.notification.payload.additionalData;
      _handlerNotificationInApp(addData, 0,
          title: oSNotification.notification.payload.title,
          body: oSNotification.notification.payload.body);
    });
    OneSignalService.notificationReceivedHandler((oSNotification) {
      var addData = oSNotification.payload.additionalData;
      _handlerNotificationInApp(addData, 1,
          title: oSNotification.payload.title,
          body: oSNotification.payload.body);
    });
  }

  _handlerNotificationInApp(Map<String, dynamic> additionalData, int type,
      {String title, String body}) {
    if (additionalData != null)
      additionalData.forEach((key, value) {
        switch (key) {
          //lấy theo model odoo
          case "model":
            switch (value) {
              case "helpdesk.ticket":
                HelpdeskTicket helpdeskTicket =
                    HelpdeskTicket.fromJsonPushNotification(additionalData);
                if (type == 0) {
                  print("push opened");
                  Future.delayed(Duration(milliseconds: 500), () {
                    return Get.toNamed(TicketDetailPage.routeName,
                        arguments: helpdeskTicket.id);
                  });
                } else {
                  //In App - show dialog
                  print("push received");
                  Get.dialog(LoadingDialog.dialogMessageWithButtonWidget(
                      content: body,
                      btnYes: translation.text("POPUP_CONFIRM.OPEN"),
                      btnNo: translation.text("POPUP_CONFIRM.CLOSE"),
                      onTapYes: () {
                        Get.back();
                        Get.toNamed(TicketDetailPage.routeName,
                            arguments: helpdeskTicket.id);
                      }));
                }
                break;
              default:
            }
            break;
          default:
        }
      });
    else {
      //do something with additionalData is null
      if (type == 1) {}
    }
  }
}
