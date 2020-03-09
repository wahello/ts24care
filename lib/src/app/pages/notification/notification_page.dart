import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/notification/notification_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class NotificationsPage extends StatefulWidget {
  static const String routeName = "/NotificationPage";
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with AutomaticKeepAliveClientMixin {
  NotificationPageViewModel viewModel = NotificationPageViewModel();
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar() {
      return TS24AppBar(
        backgroundColorStart: Colors.grey[200],
        backgroundColorEnd: Colors.grey[200],
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            appBar: _appBar(),
            body: Container(),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
