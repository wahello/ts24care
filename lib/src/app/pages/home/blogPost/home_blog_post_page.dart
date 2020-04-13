import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_newfeed_model.dart';
import 'package:ts24care/src/app/pages/home/blogPost/home_blog_post_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class BlogPostPage extends StatefulWidget {
  static const String routeName = "/blogPostPage";
  final ItemNewFeedModel itemNewFeedModel;

  const BlogPostPage({Key key, this.itemNewFeedModel}) : super(key: key);
  @override
  _BlogPostPageState createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  BlogPostPageViewModel viewModel = BlogPostPageViewModel();
  @override
  void initState() {
    viewModel.onGetContentById(widget.itemNewFeedModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar() {
      return TS24AppBar(
        elevation: 0,
        backgroundColorEnd: ThemePrimary.backgroundColor,
        backgroundColorStart: ThemePrimary.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.itemNewFeedModel.title,
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    Widget _body() {
      return viewModel.loading
          ? LoadingSpinner.loadingView(
              context: context, loading: viewModel.loading)
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: (widget.itemNewFeedModel.content != null &&
                        widget.itemNewFeedModel.content != '')
                    ? Column(
                        children: <Widget>[
//            Container(
//              alignment: Alignment.center,
//              margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 10),
//              child: Text(widget.itemNewFeedModel.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
//            ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                                widget.itemNewFeedModel.postDate.substring(
                                    0,
                                    widget.itemNewFeedModel.postDate.length -
                                        3),
                                style: TextStyle(fontStyle: FontStyle.italic)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              widget.itemNewFeedModel.subTitle,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          HtmlWidget(
                            addDomainHtml(widget.itemNewFeedModel.content),
                            webViewJs: true,
                          )
                        ],
                      )
                    : Container(),
              ),
            );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            appBar: _appBar(),
            body: _body(),
          );
        },
      ),
    );
  }
}
