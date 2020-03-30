import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faqArticleDetail/faq_article_detail_web_view_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FaqArticleDetailPage extends StatefulWidget {
  static const String routeName = '/webHtml';
  final List<dynamic> htmlData;

  FaqArticleDetailPage({this.htmlData});

  @override
  _FaqArticleDetailPageState createState() => _FaqArticleDetailPageState();
}

class _FaqArticleDetailPageState extends State<FaqArticleDetailPage> {
  FaqArticleDetailPageViewModel viewModel = FaqArticleDetailPageViewModel();

  Widget _body(kHtml) {
    return ListView(
      children: <Widget>[
        HtmlWidget(
          kHtml == null ? '' : kHtml,
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

  Widget _appBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      title: Text(
        title == null ? '' : title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black87, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
        viewmodel: viewModel,
        child: StreamBuilder(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return TS24Scaffold(
              appBar: _appBar(widget.htmlData[1]),
              body: _body(widget.htmlData[0][0]),
            );
          },
        ));
  }
}
// update message
