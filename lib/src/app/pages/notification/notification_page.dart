import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/pages/notification/notification_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/empty_widget.dart';
import 'package:ts24care/src/app/widgets/item_notification_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

import '../../app_localizations.dart';

class NotificationsPage extends StatefulWidget {
  static const String routeName = "/NotificationPage";

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with AutomaticKeepAliveClientMixin {
  NotificationPageViewModel viewModel = NotificationPageViewModel();

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
      return AppBar(
        // leading: IconButton(icon: Icon(Icons.menu, color: Colors.black)),
        backgroundColor: ThemePrimary.backgroundColor,
        elevation: 0,
        title: Text(
          translation.text("NOTIFICATIONS_PAGE.TITLE"),
          style: TextStyle(color: Colors.black87),
        ),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.search,
//              color: Colors.black,
//            ),
//          )
//        ],
      );
    }

    Widget _body() {
      return viewModel.choices[0].list.length > 0
          ? Column(
              children: viewModel.choices[0].list
                  .map((item) => Column(
                        children: <Widget>[
                          ItemNotificationWidget(
                              notification: item,
                              listNotification: viewModel.choices[0].list),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: ThemePrimary.backgroundColor,
                          )
                        ],
                      ))
                  .toList())
          : Center(
              //height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/icon_bell.png',
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(translation.text('NOTIFICATIONS_PAGE.NO_NOTIFICATIONS'),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ],
              ),
            );
      return SingleChildScrollView(
        child: viewModel.choices[0].list.length > 0
            ? viewModel.choices[0].list
                .map((item) => Column(
                      children: <Widget>[
                        ItemNotificationWidget(
                            notification: item,
                            listNotification: viewModel.choices[0].list),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: ThemePrimary.backgroundColor,
                        )
                      ],
                    ))
                .toList()
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/icon_bell.png',
                      height: 100,
                      width: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    Text('Không có thông báo',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
      );

      return Column(
          children: viewModel.choices[0].list.length > 0
              ? viewModel.choices[0].list
                  .map(
                    (item) => Column(
                      children: <Widget>[
                        ItemNotificationWidget(
                            notification: item,
                            listNotification: viewModel.choices[0].list),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: ThemePrimary.backgroundColor,
                        )
                      ],
                    ),
                  )
                  .toList()
              : Text('No notification'));
//      return Column(
//        children: <Widget>[
//          ItemNotificationWidget(notification: item, listNotification: viewModel.choices[0].list),
//          Container(
//            width: MediaQuery.of(context).size.width,
//            height: 1,
//            color: ThemePrimary.backgroundColor,
//          )
//        ],
//      );
//      return DefaultTabController(
//        length: viewModel.choices.length,
//        child: Scaffold(
//          backgroundColor: ThemePrimary.backgroundColor,
//          appBar: new TabBar(
//            labelColor: Colors.black,
////            indicator: BoxDecoration(
////                borderRadius: BorderRadius.only(topRight:  Radius.circular(25), topLeft: Radius.circular(25)),
////                border: Border(
////                  bottom: BorderSide(
////                    color: Colors.green,
////                    width: 2.0,
////                  ),
////                ),
////            ),
//            indicator: UnderlineTabIndicator(
//                borderSide:
//                    BorderSide(width: 2, color: ThemePrimary.primaryColor),
//                insets: EdgeInsets.symmetric(horizontal: 16.0)),
//            //indicatorPadding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
////            indicator: BoxDecoration(
////              //borderRadius: ,
////              border: Border(
////                bottom: BorderSide(
////                  color: Colors.green,
////                  width: 2.0,
////                ),
////              ),
////            ),
//            controller: viewModel.tabController,
//            tabs: viewModel.choices.map((Choice choice) {
//              return Tab(
//                text: choice.title,
//              );
//            }).toList(),
//          ),
//          body: TabBarView(
//            children: viewModel.choices.map((Choice choice) {
//              return Container(
//                color: Colors.white,
//                child: ListView(
//                  children: <Widget>[
////                  SizedBox(
////                    height: 5,
////                  ),
////                    Container(
////                      width: MediaQuery.of(context).size.width,
////                      height: 0.5,
////                      color: Colors.grey,
////                    ),
//                    ...choice.list
//                        .map((item) => Column(
//                              children: <Widget>[
//                                ItemNotificationWidget(notification: item, listNotification: choice.list),
//                                Container(
//                                  width: MediaQuery.of(context).size.width,
//                                  height: 1,
//                                  color: ThemePrimary.backgroundColor,
//                                )
//                              ],
//                            ))
//                        .toList()
//                  ],
//                ),
//              );
//            }).toList(),
//          ),
//        ),
//      );
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
            body: _body(),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
