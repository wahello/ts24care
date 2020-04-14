import 'dart:async';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ts24care/src/app/services/onesingal-service.dart';

class HandlerPushNotification {
  StreamController streamController = StreamController.broadcast();
  Stream get stream => streamController.stream;

  void dispose() {
    streamController.close();
    streamController = StreamController();
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
          //Chat messages
          case "senderId":
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
