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

  final List<dynamic> listParams; // as that [categoryId, color, iconPath, name]

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
//    viewModel.getListFAQByCategoryId(
//        widget.listParams[0]); // as that [categoryId, color, iconPath, name]

//    viewModel.idCategoryForFetchArticle = widget.listParams[0];
    viewModel.updateIdCategoryForFetchArticle(widget.listParams[0]);
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
          '${translation.text('FAQ_DETAIL_PAGE.TITLE')} ${widget.listParams[3]}', // as that [categoryId, color, iconPath, name]
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

    Widget _body() {
      Widget __itemList(String text, int idArticle, String dateCreate) {
        // format dateTime server valid flutter year-month-date time
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
            onTap: () {
              Navigator.pushNamed(context, FaqArticleDetailPage.routeName,
                  arguments: [idArticle, text]);
//              try {
//                KnowsystemArticle data =
//                    await viewModel.fetchHtmlByArticleId(idArticle);
//                Navigator.pushNamed(context, FaqArticleDetailPage.routeName,
//                    arguments: [
//                      [data.description],
//                      text
//                    ]);
//              } catch (e) {
//                print(e);
//              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 0, bottom: 0),
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
                Center(
                  child: Container(
                    height: 0.5,
                    width: media.size.width - 50,
                    color: Colors.grey[400],
                  ),
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
              top: media.orientation == Orientation.landscape ? 15 : 35,
              left: media.orientation == Orientation.landscape
                  ? media.size.width / 2 - 30
                  : 150,
              right: media.orientation == Orientation.landscape
                  ? media.size.width / 2 - 30
                  : 150,
              child: Image.network(
                widget.listParams[2],
                fit:
                    BoxFit.cover, //as that  [categoryId, color, iconPath, name]
              ),
            ),
            viewModel.listArticle.length == 0
                ? Container(
              width: media.size.width,
              child: Center(
                  child: Text(viewModel.isLoading && viewModel.isNoData
                      ? translation.text('FAQ_DETAIL_PAGE.LOADING')
                      : translation.text('FAQ_DETAIL_PAGE.NO_DATA'), style: TextStyle(color: Colors.white),)),
            )
                : DraggableScrollableSheet(
              initialChildSize: .7,
              builder: (context, scrollController) {
                scrollController.addListener((){
                  viewModel.onScrollHappened(scrollController);
                });
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)
                    )
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: viewModel.listArticle.length,
                    itemBuilder: (context, index) {
                      List<KnowsystemArticle> list = viewModel.listArticle;
                      return __itemList(list[index].name, list[index].id,
                          list[index].createDate);
                    },
                  ),
                );
              },
            )
          ],
        );
      }

      Widget __content() {
        return viewModel.listArticle.length == 0
            ? Container(
                width: media.size.width,
                child: Center(
                    child: Text(viewModel.isLoading
                        ? translation.text('FAQ_DETAIL_PAGE.LOADING')
                        : translation.text('FAQ_DETAIL_PAGE.NO_DATA'))),
              )
            : DraggableScrollableSheet(
                builder: (context, _) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      controller: viewModel.controller,
                      itemCount: viewModel.listArticle.length,
                      itemBuilder: (context, index) {
                        List<KnowsystemArticle> list = viewModel.listArticle;
                        return __itemList(list[index].name, list[index].id,
                            list[index].createDate);
                      },
                    ),
                  );
                },
              );
      }

//      Widget __content() {
//        return Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: viewModel.listArticle.length == 0
//                ? <Widget>[
//                    Container(
//                      width: media.size.width,
//                      child: Center(
//                          child: Text(viewModel.isLoading
//                              ? translation.text('FAQ_DETAIL_PAGE.LOADING')
//                              : translation.text('FAQ_DETAIL_PAGE.NO_DATA'))),
//                    )
//                  ]
//                : viewModel.listArticle.map((item) {
//                    return __itemList(item.name, item.id, item.createDate);
//                  }).toList());
//      }

//      fix height not full screen

      return __background();

//      return TS24BottomScrollWithBackgroundWidget(
//          shadow: false,
//          controllerCallback: viewModel.onFunction,
//          background: __background(),
//          child: ConstrainedBox(
//            constraints: BoxConstraints(minHeight: media.size.height * .85),
//            child: __content(),
//          ));
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
        },
      ),
    );
  }
}
