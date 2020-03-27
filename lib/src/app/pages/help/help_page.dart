import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_application_model.dart';
import 'package:ts24care/src/app/models/product-warranty.dart';
import 'package:ts24care/src/app/pages/help/help_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/help/productWarrantyDetail/product_warranty_detail_page.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/group_content_widget.dart';
import 'package:ts24care/src/app/widgets/item_help_widget.dart';
import 'package:ts24care/src/app/widgets/ts24SlideWidget/ts24_slide_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'faqDetail/faqArticleDetail/faq_article_detail_web_view_page.dart';

class HelpPage extends StatefulWidget {
  static const String routeName = "/helpPage";

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage>
    with AutomaticKeepAliveClientMixin {
  HelpPageViewModel viewModel = HelpPageViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.fetchCategoryTS24Product();
  }

  final _style = TextStyle(
    fontSize: 16,
  );

  Widget _categoryDetail(
      {int id,
      String createDate,
      String expireDate,
      String nameService,
      ProductWarranty fullObject}) {
    var dateFormat = expireDate.split('-');
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductWarrantyDetailPage.routeName,
              arguments: fullObject);
        },
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                nameService,
                style: TextStyle(color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                  '${translation.text('HELP_PAGE.EXPIRE_DATE')}: ${dateFormat[2] + '-' + dateFormat[1] + '-' + dateFormat[0]}',
                  style: TextStyle(color: Colors.grey)),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderArticleHaveData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'FAQ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              child: GestureDetector(
                  onTap: () {
                    viewModel.onTapFAQ();
                  },
                  child: Text(
                    translation.text('HELP_PAGE.VIEW_MORE'),
                    style: TextStyle(
                        color: ThemePrimary.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: <Widget>[
              ...viewModel.listArticle.map((item) {
                var dateStringFilter = item.createDate.replaceAll('/', '-');
                var year =
                    dateStringFilter.split('-')[2].toString().split(' ')[0];
                var month = dateStringFilter.split('-')[1];
                var date = dateStringFilter.split('-')[0];
                var time = dateStringFilter
                    .split('-')[2]
                    .toString()
                    .split(' ')[1]
                    .substring(
                        0,
                        dateStringFilter
                                .split('-')[2]
                                .toString()
                                .split(' ')[1]
                                .length -
                            3);
                var dateTimeValid = '$year-$month-$date $time';
                return Material(
                  color: Colors.white10,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    hoverColor: Colors.white10,
                    onTap: () {
                      Navigator.pushNamed(
                          context, FaqArticleDetailPage.routeName,
                          arguments: [
                            [item.description],
                            item.name
                          ]);
                    },
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15, top: 10),
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.name.toString(),
                              style: TextStyle(color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                                DateTime.now() == DateTime.parse(dateTimeValid)
                                    ? 'Today $time'
                                    : dateStringFilter.substring(
                                        0, dateStringFilter.length - 3),
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                  ),
                );
              })
            ],
          ),
        )
      ],
    );
  }

  Widget _renderTitleArticleNotHaveData() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'FAQ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              child: GestureDetector(
                  onTap: () {
                    viewModel.onTapFAQ();
                  },
                  child: Text(
                    translation.text('HELP_PAGE.VIEW_MORE'),
                    style: TextStyle(
                        fontSize: 15,
                        color: ThemePrimary.primaryColor,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white70),
          child: Row(
            children: <Widget>[
              Text(translation.text("HELP_PAGE.GROUP_SUBTITLE_1"))
            ],
          ),
        )
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        color: ThemePrimary.backgroundColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            viewModel.listArticle.length == 0
                ? _renderTitleArticleNotHaveData()
                : _renderArticleHaveData(),

            //            remove feedback and add category detail customer pay
            GroupContentWidget(
                title: translation.text('HELP_PAGE.SERVICE_LIST'),
//              tapMore: () {
//                viewModel.onTapFAQ();
//              },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...viewModel.listProductWarranty.map((item) {
                      return _categoryDetail(
                          fullObject: item,
                          id: item.id,
                          nameService: item.productId[1],
                          createDate: item.warrantyCreateDate,
                          expireDate: item.warrantyEndDate);
                    }).toList()
                  ],
                )),

            Container(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TS24Button(
                      onTap: () {
                        // add call launcher
                        launch("tel://0902123123");
                      },
                      child: ItemHelpWidget(
                        icons: Icons.phone_in_talk,
                        text: translation.text("HELP_PAGE.CALL_SERVICE"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: TS24Button(
                      onTap: () {
                        viewModel.onTapChat();
                      },
                      child: ItemHelpWidget(
                        icons: Icons.chat_bubble,
                        text: translation.text("HELP_PAGE.LIVE_CHAT"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      // leading: Offstage(),
      backgroundColor: ThemePrimary.backgroundColor,
      elevation: 0,
      title: Text(
        translation.text("HELP_PAGE.TITLE"),
        style: TextStyle(color: Colors.black87),
      ),
    );
  }

// phát triển

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            backgroundColor: ThemePrimary.backgroundColor,
            appBar: _appBar(),
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  viewModel.fetchCategoryTS24Product();
                  viewModel.getListCategory();
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: Container(),
                      expandedHeight: 220.0,
                      floating: false,
                      pinned: false,
                      snap: false,
                      elevation: 50,
                      backgroundColor: Colors.transparent,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
//                        background: TS24SlideWidget(
////                          listCurrentObject: viewModel.dataListApplication,
////                          listFullObject: TS24ProductCategory.list,
////                          onChange: (index) {
////                            print(index);
////                          },
////                        ),
                          background: viewModel.listApplication.length > 0
                              ? TS24SlideWidget(
                                  listCurrentObject: viewModel.listApplication,
                                  listFullObject:
                                      ItemApplicationModel.listApplication,
                                  onChange: (index) {
                                    var idCategoryProduct = viewModel.listApplication[index]
                                        .idCategoryServices;
                                    viewModel.onCategoryIndexChanged(idCategoryProduct);
                                    var categoryArticleId = viewModel
                                        .listApplication[index]
                                        .idCategoryArticle;
                                    viewModel.getListFAQByCategoryId(
                                        categoryArticleId);
                                  },
                                )
                              : LoadingIndicator.spinner(
                                  context: context, loading: true)),
                    ),
                    new SliverList(
                        delegate: new SliverChildListDelegate([_body()])),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
