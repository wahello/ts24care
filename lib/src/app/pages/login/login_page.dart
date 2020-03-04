import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return TS24Scaffold(
//      appBar: AppBar(
//        title: Text("Chat"),
//      ),
      body: WebView(
        initialUrl: 'http://192.168.11.27:8069',
//        initialUrl: Uri.dataFromString("""<html><head>
//                  <meta name="viewport" content="width=device-width, initial-scale=2">
//                <link rel="stylesheet" href="http://192.168.11.27:8069/im_livechat/external_lib.css"/>
//             <script type="text/javascript" src="http://192.168.11.27:8069/im_livechat/external_lib.js"></script>
//             <script type="text/javascript" src="http://192.168.11.27:8069/im_livechat/loader/2"></script>
//               </head>
//                <body>sss3</body>
//         </html>
//         """, mimeType: 'text/html').toString(),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          //_controller.complete(webViewController);
          //   webViewController.loadUrl(Uri.dataFromString("""<html><head>
          //           <meta name="viewport" content="width=device-width, initial-scale=2">
          //         <link rel="stylesheet" href="http://192.168.11.27:8069/im_livechat/external_lib.css"/>
          //      <script type="text/javascript" src="http://192.168.11.27:8069/im_livechat/external_lib.js"></script>
          //      <script type="text/javascript" src="http://192.168.11.27:8069/im_livechat/loader/2"></script>
          //        </head>
          //         <body>sss3</body>
          //  </html>
          //  """, mimeType: 'text/html').toString());
        },
      ),
    );
  }
}
