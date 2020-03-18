import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/livezilla.dart';

class HelpChatPageViewModel extends ViewModelBase {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String url = "http://livechat.ts24.com.vn/livechat/chat.php?v=2&nct=MQ__";
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

  onBack() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}
