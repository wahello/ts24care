import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faqWebview/web_html_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

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
        Html(
          data:kHtml == null? '' : kHtml,
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
      backgroundColor: Colors.white,
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

