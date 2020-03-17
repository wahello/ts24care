import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:html/parser.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/livezilla.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpChatPageViewModel extends ViewModelBase {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String url = "http://livechat.ts24.com.vn/livechat/chat.php?v=2";
  // String url = "http://demo.livezilla.info/demo_18e1917e/chat.php?v=2";
  Map params = Map();
  loadHtmlFromAssets() async {
    // String fileText = await rootBundle.loadString('assets/files/chat.html');
    // var document = parse(fileText);
    // print(document.outerHtml);
    // var script = document.createElement("script");
    // script.attributes["type"] = "text/javascript";
    // script.text = """ var lz_data = {
    //         'overwrite': true,
    //         111: 'Vuowng Minh Luân',
    //         112: 'luanvm@ts24corp.com',
    //         113: 'TS24',
    //         114: '',
    //         116: '03033',
    //     };""";

    // document.getElementsByTagName('head')[0].append(script);
    // url = Uri.dataFromString(document.outerHtml,
    //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
    //     .toString();
    url += "&";
    LiveZilla live = LiveZilla();
    live.ptn = "VuongMinhLuan1";
    live.pte = "luanvm@ts24corp.com";
    live.ptq = "hi";
    live.ptp = "090788458";
    url += api.convertSerialize(live.toJson());
    print(url);
    this.updateState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}
