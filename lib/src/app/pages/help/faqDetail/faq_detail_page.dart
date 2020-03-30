import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faq_detail_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faqArticleDetail/faq_article_detail_web_view_page.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24BottomScrollWithBackgroundWidget/ts24_bottom_scroll_with_background_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class FaqDetailPage extends StatefulWidget {
  static const String routeName = "/FeedbackPage";
  final Widget child;
  final Widget background;
  final String title;
  final bool shadow;

  final List<dynamic> listParams; // as that [categoryId, color, iconPath]

  const FaqDetailPage(
      {Key key,
      this.background,
      this.title,
      this.shadow = true,
      this.child,
      this.listParams})
      : super(key: key);

  @override
  _FaqDetailPageState createState() => _FaqDetailPageState();
}

class _FaqDetailPageState extends State<FaqDetailPage> {
  FaqDetailPageViewModel viewModel = FaqDetailPageViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getListFAQByCategoryId(
        widget.listParams[0]); // as that [categoryId, color, iconPath, name]
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    viewModel.context = context;

    Widget _appBar() {
      return TS24AppBar(
        backgroundColorEnd: ThemePrimary.backgroundColor,
        backgroundColorStart: ThemePrimary.backgroundColor,
        title: Text(
          '${translation.text('FAQ_DETAIL_PAGE.TITLE')} ${widget.listParams[3]}',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }

//EasyWebView(src: "https://web.ts24.com.vn/en_US/csrt",webAllowFullScreen: true,)

    Widget _body() {
      Widget __itemList(String text, int idArticle, String dateCreate) {
        // filter dateTime server valid flutter year-month-date time
        var dateStringFilter = dateCreate.replaceAll('/', '-');
        var year = dateStringFilter.split('-')[2].toString().split(' ')[0];
        var month = dateStringFilter.split('-')[1];
        var date = dateStringFilter.split('-')[0];
        var time = dateStringFilter
            .split('-')[2]
            .toString()
            .split(' ')[1]
            .substring(
                0,
                dateStringFilter.split('-')[2].toString().split(' ')[1].length -
                    3);
        var dateTimeValid = '$year-$month-$date $time';

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              try{
                KnowsystemArticle data =
                await viewModel.fetchHtmlByArticleId(idArticle);
                Navigator.pushNamed(context, FaqArticleDetailPage.routeName,
                    arguments: [
                      [data.description],
                      text
                    ]);
              }
              catch(e){
                print(e);
              }

            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: ListTile(
                    title: Text(
                      text,
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    subtitle: Text(
                      DateTime.now() == DateTime.parse(dateTimeValid)
                          ? 'Today $time'
                          : dateStringFilter.substring(
                              0, dateStringFilter.length - 3),
                      style: TextStyle(color: Colors.grey[500], fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey[300],
                )
              ],
            ),
          ),
        );
      }

      Widget __background() {
        return Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: Container(
                decoration: BoxDecoration(color: widget.listParams[1]),
              ),
            ),
            Positioned(
              top: 35,
              left: 150,
              right: 150,
              child: Image.network(
                widget.listParams[2],
                fit: BoxFit.cover, //as that  [categoryId, color, iconPath, name]
              ),
            )
          ],
        );
      }

      Widget __content() {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: viewModel.listArticle.length == 0
                ? <Widget>[Container(
              width: media.size.width,
              child: Center(child: Text(translation.text('FAQ_DETAIL_PAGE.NO_DATA'))),
            )]
                : viewModel.listArticle.map((item) {
                    return __itemList(item.name, item.id, item.createDate);
                  }).toList());
      }

//      fix height not full screen
      return TS24BottomScrollWithBackgroundWidget(
          shadow: false,
          title: translation.text('FAQ_DETAIL_PAGE.GUIDANCE_TITLE'),
          background: __background(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: media.size.height * .85),
            child: Container(
              height: viewModel.listArticle.length < 6 ? 580.0 : null,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: __content(),
            ),
          ));
    }

    Widget _renderResultSearch(List<KnowsystemArticle> listResultItem) {
      return ListView.builder(
        itemCount: listResultItem.length,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, FaqArticleDetailPage.routeName,
                    arguments: [
                      [listResultItem[index].description],
                      listResultItem[index].name
                    ]);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: ListTile(
                      title: Text(listResultItem[index].name.toString()),
                      subtitle: Text(
                        listResultItem[index].createDate.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: _appBar(),
            body: viewModel.listArticle != null
                ? _body()
                : LoadingIndicator.spinner(context: context, loading: true),
          );
//            TS24SearchBarWidget(
//            leading: IconButton(
//              icon: Icon(
//                Icons.arrow_back,
//                color: Colors.black87,
//              ),
//              onPressed: () {
//                Navigator.pop(context);
//              },
//            ),
//            title: Text(
//              translation.text('FAQ_DETAIL_PAGE.TITLE'),
//              style: TextStyle(color: Colors.black87),
//            ),
//            backgroundColor: ThemePrimary.backgroundColor,
//            primaryColor: ThemePrimary.primaryColor,
//            searchBarStateCallBack: (_) {},
//            onQueryChangedCallBack: (_) {},
//            onQuerySubmittedCallBack: viewModel.onQuerySubmitted,
//            countResult: viewModel.listResultSearch.length,
//            resultWidget: _renderResultSearch(viewModel.listResultSearch),
//            contentWidget:
//                viewModel.listArticle.length > 0 ? _body() : Offstage(),
//          );
        },
      ),
    );
  }
}
