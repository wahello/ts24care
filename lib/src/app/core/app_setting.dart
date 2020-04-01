library appsetting;

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ts24care/src/app/provider/api.dart';

final LocalStorage localStorage = new LocalStorage("localStorage");

// String domainApi = "https://www.bus2school.vn";
// String domainApi = "http://14.187.122.118:8069";

// const String client_id = '9QGhjXbApupARfpGGsskXUTQjoRD35';
// const String client_secret = '0wGQ7JkaLT68YMUQJFyUDKLsZutwbC';

// const String password_client_id = 'aeCf27wNJwtTrpO8v59OZNDcjPESyf';
// const String password_client_secret = 'SlcSGww1jUZPBEYFRPIMLHzDPcyv6z';

String domainApi = "https://web.ts24.com.vn";

const String client_id = 'DwRtKASexsN40ucqk9LXcGcBcXzeEq';
const String client_secret = 'AOmu1kyDoPtvx2xveu36YoYtzqeD8z';

const String password_client_id = '3Ki6VT43wAjHZRI05A9SNC7JZdkR03';
const String password_client_secret = '5boqANLglN9TVxNEaPYwy2Hk3kNOOd';

const String admin_id = "bus2school";
const String admin_password = "B@S#2019";

const String oneSignal_appId = "0d392a06-3088-43ab-9a7d-1b4370822434";
const String oneSignal_restKey =
    "MjM3Y2Y4NDgtYTJkNy00NTA2LWE3YzAtZjM0NTJiOGM3ZWVl";

const superKeyEncrypt = "b2s@#encrypt";

const emptyState = {
  'assetImage': AssetImage('assets/images/empty.png'),
  'assetPath': 'assets/images/empty.png',
};
const String version = "1.0.0";

Api api = new Api();
