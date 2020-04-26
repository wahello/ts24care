import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/onesignal-notification-messages.dart';
import 'package:ts24care/src/app/pages/notification/notification_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/item_notification_widget.dart';
import 'package:ts24care/src/app/widgets/shimmer/shimmer_item_ticket.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

import '../../app_localizations.dart';

class NotificationsPage extends StatefulWidget {
  static const String routeName = "/NotificationPage";

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with AutomaticKeepAliveClientMixin {
  NotificationPageViewModel viewModel = NotificationPageViewModel();
  double heightAppbar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //viewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.context = context;

    Widget _appBar() {
      AppBar appBar = AppBar(
        // leading: IconButton(icon: Icon(Icons.menu, color: Colors.black)),
        //backgroundColor: ThemePrimary.backgroundColor,
        elevation: 0,
        title: Text(
          translation.text("NOTIFICATIONS_PAGE.TITLE"),
        ),
//        bottom: PreferredSize(
//          child: Container(
//            padding: EdgeInsets.all(20),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
////                        Text(
////                          "Status: Open",
////                          style: TextStyle(
////                              color: Colors.grey[800],
////                              fontSize: 18,
////                              fontWeight: FontWeight.w600),
////                        ),
//                Text('Lựa chọn'),
//                InkWell(
//                  onTap: () {
//                    //_scaffoldKey.currentState.openEndDrawer();
//                  },
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Text(
//                        translation.text("NOTIFICATIONS_PAGE.ALL"),
//                        style: TextStyle(color: ThemePrimary.primaryColor),
//                      ),
//                      Icon(
//                        Icons.keyboard_arrow_down,
//                        color: ThemePrimary.primaryColor,
//                      )
//                    ],
//                  ),
//                )
//              ],
//            ),
//          ),
//          preferredSize: Size(MediaQuery.of(context).size.width, 55),
//        ),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.search,
//              color: Colors.black,
//            ),
//          )
//        ],
      );
      heightAppbar = appBar.preferredSize.height;
      return appBar;
    }

    Widget _listNotification(
        List<OneSignalNotificationMessages> listNotification,
        {bool loadMore = false}) {
      return
//        viewModel.listNotification.length > 0
        Stack(
          children: <Widget>[
            Container(
              color: ThemePrimary.backgroundPrimaryColor,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
//            decoration: BoxDecoration(
//              image: decorationImageBackground(),
//            ),
            ),
            viewModel.initLoading == 0
                ? LoadingIndicator.spinner(context: context, loading: true)
                : viewModel.listNotification.length > 0
                ? SingleChildScrollView(
              controller:
              loadMore ? viewModel.controller : ScrollController(),
              child: Container(
                  constraints: BoxConstraints(
                      minHeight:
                      MediaQuery
                          .of(context)
                          .size
                          .height * 0.9),
                  child: Column(
//        itemExtent: 110,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      ...listNotification.map((itemNotification) {
                        return TS24Button(
                          onTap: () {
                            viewModel
                                .onTapNotification(itemNotification);
                          },
//                                  margin: EdgeInsets.only(
//                                      top: 5, bottom: 5, left: 10, right: 10),
                          margin: EdgeInsets.only(top: 5, bottom: 5),
//                        padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
//                                      borderRadius: BorderRadius.all(
//                                          Radius.circular(10))
                          ),
//                height: 90,
                          child: ItemNotificationWidget(
                            notification: itemNotification,
                            //listNotification: viewModel.choices[0].list,
                            color: Colors.grey,
                          ),
                        );
                      }).toList(),
                      if (viewModel.loadingMore)
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 50,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation<Color>(
                                    ThemePrimary.primaryColor),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                translation.text("COMMON.LOADING_DATA"),
                                style: TextStyle(
                                    color: Color(0xFF999999)),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )),
            )
                : SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                      minHeight: MediaQuery
                          .of(context)
                          .size
                          .height -
                          heightAppbar -
                          80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.notifications,
                          size: 50, color: const Color(0xff666666)
                        //const Color(0xff666666)
                      ),
                      SizedBox(height: 15),
                      Text(
                        translation.text(
                            'NOTIFICATIONS_PAGE.NO_NOTIFICATIONS'),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff666666)),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
//          : SingleChildScrollView(
//              child: Container(
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                    image: AssetImage('assets/images/bgd.png'),
//                    fit: BoxFit.cover,
//                  ),
//                ),
//                constraints: BoxConstraints(
//                    maxHeight: MediaQuery.of(context).size.height * 0.9),
//              ),
//            );
    }

    Widget _itemShimmer() {
      return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 110,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ShimmerItemTicketsWidget(),
      );
    }

    Widget _content() {
      return RefreshIndicator(
          onRefresh: () async {
            print('refresh');
            viewModel.onLoad();
          },
          child: viewModel.loading
              ? Stack(
            children: <Widget>[
              Container(
                color: ThemePrimary.backgroundPrimaryColor,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
//                      decoration: BoxDecoration(
//                        image: decorationImageBackground(),
//                      ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                constraints: BoxConstraints(
                    minHeight: MediaQuery
                        .of(context)
                        .size
                        .height * 0.8),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    _itemShimmer(),
                    _itemShimmer(),
                    _itemShimmer(),
                    _itemShimmer(),
                  ],
                ),
              )
            ],
          )
              : Stack(
            children: <Widget>[
              Container(
                color: ThemePrimary.backgroundPrimaryColor,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
//                      decoration: BoxDecoration(
//                        image: decorationImageBackground(),
//                      ),
              ),
              _listNotification(viewModel.listNotification,
                  loadMore: true)
            ],
          ));
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            appBar: _appBar(),
//              body: EmptyWidget(
//                message: "Chưa có thông báo mới.",
//              )
            body: _content(),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
