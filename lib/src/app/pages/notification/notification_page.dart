import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/pages/notification/notification_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
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
        leading: IconButton(icon: Icon(Icons.menu, color: Colors.black)),
        backgroundColor: ThemePrimary.backgroundColor,
        elevation: 0,
        title: Text(
          translation.text("NOTIFICATIONS_PAGE.TITLE"),
          style: TextStyle(color: Colors.black87),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      );
    }

    Widget _body() {
      return DefaultTabController(
        length: viewModel.choices.length,
        child: Scaffold(
          backgroundColor: ThemePrimary.backgroundColor,
          appBar: new TabBar(
            labelColor: Colors.black,
//            indicator: BoxDecoration(
//                borderRadius: BorderRadius.only(topRight:  Radius.circular(25), topLeft: Radius.circular(25)),
//                border: Border(
//                  bottom: BorderSide(
//                    color: Colors.green,
//                    width: 2.0,
//                  ),
//                ),
//            ),
            indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 2, color: ThemePrimary.primaryColor),
                insets: EdgeInsets.symmetric(horizontal: 16.0)),
            //indicatorPadding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
//            indicator: BoxDecoration(
//              //borderRadius: ,
//              border: Border(
//                bottom: BorderSide(
//                  color: Colors.green,
//                  width: 2.0,
//                ),
//              ),
//            ),
            controller: viewModel.tabController,
            tabs: viewModel.choices.map((Choice choice) {
              return Tab(
                text: choice.title,
              );
            }).toList(),
          ),
          body: TabBarView(
            children: viewModel.choices.map((Choice choice) {
              return Container(
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
//                  SizedBox(
//                    height: 5,
//                  ),
//                    Container(
//                      width: MediaQuery.of(context).size.width,
//                      height: 0.5,
//                      color: Colors.grey,
//                    ),
                    ...choice.list
                        .map((item) => Column(
                              children: <Widget>[
                                ItemNotificationWidget(notification: item, listNotification: choice.list),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 1,
                                  color: ThemePrimary.backgroundColor,
                                )
                              ],
                            ))
                        .toList()
                  ],
                ),
              );
//                ListView.separated(
//                  separatorBuilder: (context, index) => Padding(
//                        padding: EdgeInsets.symmetric(horizontal: 20),
//                        child: Divider(
//                          height: 0.5,
//                          color: Colors.grey,
//                        ),
//                      ),
//                  itemCount: choice.list.length,
//                  itemBuilder: (context, index) =>
//                      ItemNotificationWidget(notification: choice.list[index])
////                        children: choice.list.map((item){
////                          return ItemNotificationWidget(image: item.image, type: item.type, time: item.time, description: item.description);
////                        }).toList()
//                  );
            }).toList(),
          ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
