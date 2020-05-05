library appsetting;

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ts24care/src/app/app_handle_ticket_created.dart';
import 'package:ts24care/src/app/app_handler_push_notification.dart';
import 'package:ts24care/src/app/models/ticket_status_shared_preference.dart';
import 'package:ts24care/src/app/provider/api.dart';

final LocalStorage localStorage = new LocalStorage("localStorage");

// String domainApi = "https://www.bus2school.vn";
// String domainApi = "http://192.168.11.27:8069";

// const String client_id = '9QGhjXbApupARfpGGsskXUTQjoRD35';
// const String client_secret = '0wGQ7JkaLT68YMUQJFyUDKLsZutwbC';
//
// const String password_client_id = 'aeCf27wNJwtTrpO8v59OZNDcjPESyf';
// const String password_client_secret = 'SlcSGww1jUZPBEYFRPIMLHzDPcyv6z';
//
String domainApi = "https://web.ts24.com.vn";
String domainApiTS24pro = "https://www.ts24.com.vn/ts24id_ws/IDTS24.rest";

const String client_id = 'DwRtKASexsN40ucqk9LXcGcBcXzeEq';
const String client_secret = 'AOmu1kyDoPtvx2xveu36YoYtzqeD8z';

const String password_client_id = '3Ki6VT43wAjHZRI05A9SNC7JZdkR03';
const String password_client_secret = '5boqANLglN9TVxNEaPYwy2Hk3kNOOd';

final String ggKey = "AIzaSyCjB1Kh7OstaDns8ie6uPysWEWa_vwS3iw";

// //
const String admin_id = "bus2school";
const String admin_password = "B@S#2019";
const String oneSignal_appId = "290a061e-5450-4e20-a7f6-05cb9577a4d4";
const String oneSignal_restKey =
    "OGUwNDIwY2UtMTkzYy00YzYwLWIwMzgtMzhiNTIzNjQ3Yjlj";

const superKeyEncrypt = "b2s@#encrypt";

const emptyState = {
  'assetImage': AssetImage('assets/images/empty.png'),
  'assetPath': 'assets/images/empty.png',
};
const String version = "1.0.10";

Api api = new Api();
HandleTicketStatus handleTicketStatus = HandleTicketStatus();
HandlerPushNotification handlerPushNotification = HandlerPushNotification();
SharedPreferencesTicketStatus sharedPreferencesTicketStatus =
    SharedPreferencesTicketStatus();
