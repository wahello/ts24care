import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/faq/help_faq_page.dart';
import 'package:ts24care/src/app/pages/help/feedback/help_feedback_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24BottomScrollWithBackgroundWidget/ts24_bottom_scroll_with_background_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class FeedbackPage extends StatefulWidget {
  static const String routeName = "/FeedbackPage";
  final Widget child;
  final Widget background;
  final String title;
  final bool shadow;

  const FeedbackPage(
      {Key key, this.background, this.title, this.shadow = true, this.child})
      : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  FeedbackPageViewModel viewModel = FeedbackPageViewModel();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    final List<dynamic> categoryId = ModalRoute.of(context).settings.arguments;
    viewModel.getListFAQByCategoryId(categoryId[0]);
    viewModel.context = context;
    Widget _appBar() {
      return TS24AppBar(
        backgroundColorEnd: ThemePrimary.backgroundColor,
        backgroundColorStart: ThemePrimary.backgroundColor,
        title: Text(
          "Feedback",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, FAQPage.routeName);
          },
        ),
      );
    }

//EasyWebView(src: "https://web.ts24.com.vn/en_US/csrt",webAllowFullScreen: true,)

    Widget _body() {
      Widget __itemList(String text) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
//              height: media.size.height * .7,
//              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                text,
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.grey[300],
            )
          ],
        );
      }

      Widget __background() {
        return Image.network(
          "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg",
          fit: BoxFit.fitWidth,
        );
      }

      Widget __content() {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: viewModel.listArticle.length == 0
                ? <Widget>[Text('No data')]
                : viewModel.listArticle.map((item) {
                    return __itemList(item.name);
                  }).toList()
//          <Widget>[
//            __itemList(
//                "While charging the device, device seems to heat up. Why is this?"),
//
//          ],
            );
      }

      return TS24BottomScrollWithBackgroundWidget(
          shadow: true,
          title: "Choose your question from the list",
          background: __background(),
          child: Container(
//                  margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: __content(),
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
