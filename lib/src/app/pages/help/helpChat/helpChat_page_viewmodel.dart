import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpChatPageViewModel extends ViewModelBase {
  WebViewController controller;
  loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/files/chat.html');
    controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
