import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/helpChat/helpChat_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
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

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return SafeArea(
              child: WebviewScaffold(
                url: viewModel.url,
                persistentFooterButtons: <Widget>[
                  Container(
                    width: MediaQuery.of(context).copyWith().size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                            onTap: viewModel.onBack,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: ThemePrimary.primaryColor,
                            )),
                        InkWell(
                            onTap: viewModel.onBack,
                            child: Text(
                              "Quay lại",
                              style: TextStyle(
                                color: ThemePrimary.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
//              appCacheEnabled: true,
                withJavascript: true,
                hidden: true,
                resizeToAvoidBottomInset: true,
                initialChild: LoadingSpinner.loadingView(
                    context: viewModel.context, loading: true),
              ),
            );
          }),
    );
  }
}
