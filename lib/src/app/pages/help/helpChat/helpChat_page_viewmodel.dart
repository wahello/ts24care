import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/customer.dart';
import 'package:ts24care/src/app/models/livezilla.dart';

class HelpChatPageViewModel extends ViewModelBase {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
//  String url = "https://livechat.ts24.com.vn/chat.php?v=2&nct=MQ__";
   String url = "http://livechat.ts24.com.vn/livechat/chat.php?v=2&nct=MQ__";
//  String url =
//      "https://demo.livezilla.info/demo_1aba4d35/chat.php?v=2&nct=MQ__";
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
    Customer customer = Customer();
    LiveZilla live = LiveZilla();
    live.ptn = customer.name;
    live.pte = customer.email;
    live.ptq = "";
    live.ptp = customer.phone;
    live.ptc = customer.tin;
    live.ptl = "vi";
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
