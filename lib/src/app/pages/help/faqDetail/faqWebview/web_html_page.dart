import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faqWebview/web_html_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class WebHtmlPage extends StatefulWidget {
  static const String routeName = '/webHtml';
  @override
  _WebHtmlPageState createState() => _WebHtmlPageState();
}

class _WebHtmlPageState extends State<WebHtmlPage> {
  WebHtmlPageViewModel viewModel = WebHtmlPageViewModel();

  Widget _body(kHtml){
    return ListView(
      children: <Widget>[
        HtmlWidget(
          kHtml == null? '' : kHtml,
          webView: true,
        )
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _appBar(String title){
    return AppBar(
      title: Text(title ==  null ? '': title,overflow: TextOverflow.ellipsis, ),
    );
  }


  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    List<dynamic> htmlData = ModalRoute.of(context).settings.arguments;
    return ViewModelProvider(
        viewmodel: viewModel,
        child: StreamBuilder(
          stream: viewModel.stream,
          builder: (context, snapshot){
            return TS24Scaffold(
              appBar: _appBar(htmlData[1]),
              body: _body(htmlData[0][0]),
            );
          },
        )
    );
  }
}

