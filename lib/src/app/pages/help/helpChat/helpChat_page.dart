import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/helpChat/helpChat_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class HelpChatPage extends StatefulWidget {
  static const String routeName = '/helpChat';
  @override
  _HelpChatPageState createState() => _HelpChatPageState();
}

class _HelpChatPageState extends State<HelpChatPage> {
  HelpChatPageViewModel viewModel = HelpChatPageViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     viewModel.loadHtmlFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return WebviewScaffold(
              url: viewModel.url,
//               url: Uri.dataFromString("""
//  <html>

//  <head>
//     <meta charset="utf-8" />
// <script type="text/javascript">
//         var lz_data = {
//             'overwrite': true,
//             111: "Vuong Minh Luân",
//             112: 'luanvm@ts24corp.com',
//             113: 'TS24',
//             114: '',
//             116: '03033',
//         };
//     </script>
// <!-- <script type="text/javascript" id="f0512c9fd83d905a40e0943ada9b218f" src="http://livechat.ts24.com.vn/livechat/script.php?id=f0512c9fd83d905a40e0943ada9b218f" defer></script>
// -->
//     <script type="text/javascript" id="3baf3e69f7d601c10ecba98720635323" src="http://demo.livezilla.info/demo_0c1e5ea0/script.php?id=3baf3e69f7d601c10ecba98720635323" defer></script>
//  </head>
//  <body>

//  </body>

//  </html>
//                 """,
//                       mimeType: 'text/html',
//                       encoding: Encoding.getByName("utf-8"))
//                   .toString(),
              appBar: AppBar(
                title: Text("Chat"),
              ),
//              appCacheEnabled: true,
              withJavascript: true,
              hidden: true,
              resizeToAvoidBottomInset: true,
              initialChild: LoadingSpinner.loadingView(
                  context: viewModel.context, loading: true),
            );
          }),
    );
  }
}
