import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpChatPageViewModel extends ViewModelBase {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/files/chat.html');
    await flutterWebviewPlugin.launch(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}
