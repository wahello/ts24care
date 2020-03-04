library appsetting;

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ts24care/src/app/provider/api.dart';

final LocalStorage localStorage = new LocalStorage("localStorage");

String domainApi = "https://www.bus2school.vn";

const String client_id = 'XUanvRsb5NvRscvMfc6wNtgiHOF8F0';
const String client_secret = 'c665Xgd3mt3SLbPVLdVjRawJg4kzd5';

const String password_client_id = 'jwLXOqcQ14QD68jUrVlnfQiYXgAPyn';
const String password_client_secret = 'a2EEtXnVfjf1QPRy7CAzkdPpbiYP0m';

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
