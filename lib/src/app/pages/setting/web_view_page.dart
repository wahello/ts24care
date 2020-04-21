import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class WebViewArg {
  final String title;
  final String url;

  WebViewArg({this.title, this.url});
}

class WebViewPage extends StatefulWidget {
  static const String routeName = "/webViewPage";

  final WebViewArg arg;
  const WebViewPage({Key key, this.arg}) : super(key: key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String selectUrl = '';
  String title = '';

  @override
  void initState() {
    super.initState();
    selectUrl = widget.arg.url;
    title = widget.arg.title;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
        url: selectUrl,
        mediaPlaybackRequiresUserGesture: false,
        appBar: AppBar(
            // backgroundColor: ThemePrimary.backgroundColor,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back, color: Colors.black54),
            //   onPressed: (){
            //     Navigator.of(context).pop();
            //   },
            // ),
            // centerTitle: true,
            // elevation: 0,
            // title:  Text(title, style: TextStyle(fontSize: 18, color: ThemePrimary.primaryColor),),
            title: Text(title)),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild:
            LoadingSpinner.loadingView(context: context, loading: true));
  }
}
