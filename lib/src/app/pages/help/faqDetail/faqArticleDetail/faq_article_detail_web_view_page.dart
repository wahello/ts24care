import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faqArticleDetail/faq_article_detail_web_view_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class FaqArticleDetailPage extends StatefulWidget {
  static const String routeName = '/webHtml';
  final List<dynamic> htmlData; //[idCategory, title]

  FaqArticleDetailPage({this.htmlData});

  @override
  _FaqArticleDetailPageState createState() => _FaqArticleDetailPageState();
}

class _FaqArticleDetailPageState extends State<FaqArticleDetailPage> {
  FaqArticleDetailPageViewModel viewModel = FaqArticleDetailPageViewModel();

  Widget _body(kHtml) {
    return ListView(
      children: <Widget>[
        Html(
          data:kHtml == null ? '' : kHtml,
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.fetchArticleHtmlContent(widget.htmlData[0]);
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
              body: viewModel.htmlData != null
                  ? _body(viewModel.htmlData.description)
                  : Offstage(),
            );
          },
        ));
  }
}
// update message
