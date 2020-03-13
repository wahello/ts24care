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
  Widget build(BuildContext context) {
    viewModel.context = context;
    //viewModel.loadHtmlFromAssets();
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return WebviewScaffold(
              url: "about:bank",
//               url: Uri.dataFromString("""
//  <html>

//  <head>
//  <script type="text/javascript" id="70a8d57a09a82a36c61acd840046028a" src="https://demo.livezilla.info/demo_dcc7ed08/script.php?id=70a8d57a09a82a36c61acd840046028a" defer></script>

//  </head>
//  <body>

//  </body>

//  </html>
//                 """, mimeType: 'text/html').toString(),
              appBar: AppBar(
                title: Text("Chat"),
              ),

              withJavascript: true,
              //hidden: true,
              resizeToAvoidBottomInset: true,
              initialChild: LoadingSpinner.loadingView(
                  context: viewModel.context, loading: true),
            );
          }),
    );
    // return TS24Scaffold(
    //   appBar: AppBar(
    //     title: Text("Chat"),
    //   ),
    //   body: ViewModelProvider(
    //     viewmodel: viewModel,
    //     child: StreamBuilder<Object>(
    //         stream: viewModel.stream,
    //         builder: (context, snapshot) {
    //           return WebView(
    //             initialUrl:
    //                 'http://res24-m2-20-1.s2.odoo24.vn/im_livechat/support/2',
    //             javascriptMode: JavascriptMode.unrestricted,
    //             onWebViewCreated: (WebViewController webViewController) {
    //               viewModel.controller = webViewController;
    //             },
    //           );
    //         }),
    //   ),
    // );
  }
}
