import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/helpChat/helpChat_page_viewmodel.dart';
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
    super.initState();
    viewModel.loadHtmlFromAssets();
  }

  final kAndroidUserAgent =
      'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
//             return SafeArea(
//               child: TS24Scaffold(
//                 appBar: AppBar(
//                   title: Text(translation.text("HELP_PAGE.LIVE_CHAT")),
//                 ),
//                 body: Stack(
//                   children: <Widget>[
// //                     Container(
// //                       width: MediaQuery.of(context).size.width,
// //                       height: MediaQuery.of(context).size.height,
// //                       decoration: BoxDecoration(
// //                         image: decorationImageBackground(),
// //                       ),
// //                     ),
//                     WebView(
//                       initialUrl: viewModel.url,

//                       onPageStarted: (String url) {
//                         print('Page started loading: $url');
//                         viewModel.loading = true;
//                         viewModel.updateState();
//                       },
//                       onPageFinished: (String url) {
//                         print('Page finished loading: $url');
//                         viewModel.loading = false;
//                         viewModel.updateState();
//                       },
//                       javascriptMode: JavascriptMode.unrestricted,
//                       gestureNavigationEnabled: true,
//                     ),
//                     LoadingSpinner.loadingView(
//                         context: viewModel.context, loading: viewModel.loading),
//                   ],
//                 ),
//                 // floatingActionButtonLocation:
//                 //     FloatingActionButtonLocation.endTop,
//                 // floatingActionButton: FloatingActionButton(
//                 //   onPressed: () async {
//                 //     Navigator.of(context).pop();
//                 //   },
//                 //   child:  Icon(Icons.close),
//                 // ),
//               ),
//             );
            return
//              SafeArea(
//              child:
                WebviewScaffold(
              withLocalStorage: true,
              url: viewModel.url,
              ignoreSSLErrors: true,
              withJavascript: true,
              userAgent: kAndroidUserAgent,
              appBar: AppBar(
                title: Text(translation.text("HELP_PAGE.LIVE_CHAT")),
              ),
              // persistentFooterButtons: <Widget>[
              //   Container(
              //     width: MediaQuery.of(context).copyWith().size.width,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         InkWell(
              //             onTap: viewModel.onBack,
              //             child: Icon(
              //               Icons.arrow_back_ios,
              //               color: ThemePrimary.primaryColor,
              //             )),
              //         InkWell(
              //             onTap: viewModel.onBack,
              //             child: Text(
              //               "Quay lại",
              //               style: TextStyle(
              //                 color: ThemePrimary.primaryColor,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ))
              //       ],
              //     ),
              //   ),
              // ],
              // appCacheEnabled: true,
              hidden: true,
              resizeToAvoidBottomInset: true,
              initialChild: LoadingSpinner.loadingView(
                  context: viewModel.context, loading: true),
//              ),
            );

            // return SafeArea(
            //   child: TS24Scaffold(
            //     appBar: AppBar(
            //       title: Text(translation.text("HELP_PAGE.LIVE_CHAT")),
            //     ),
            //     body: InAppWebView(
            //       initialUrl: viewModel.url,
            //       initialOptions: InAppWebViewWidgetOptions(
            //           androidInAppWebViewOptions: AndroidInAppWebViewOptions()),
            //     ),
            //   ),
            // );
          }),
    );
  }
}
