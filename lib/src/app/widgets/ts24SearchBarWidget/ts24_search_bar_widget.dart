import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ts24care/packages/loader_search_bar/src/SearchBar.dart';
import 'package:ts24care/packages/loader_search_bar/src/SearchBarAttrs.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24SearchBarWidget/ts24_search_bar_widget_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

import '../ts24_button_widget.dart';

class TS24SearchBarWidget extends StatefulWidget {
  final Widget leading;
  final Widget title;
  final Widget bottom;
  final List<Widget> actions;
  final List<FloatingActionButton> listFloatingActionButton;
  final Widget resultWidget;
  final Widget contentWidget;
  final Color backgroundColor;
  final Drawer drawer;
  final Color primaryColor;
  final int countResult;
  final Function onTapFloatButton;
  final OnQueryCallBack onQueryChangedCallBack;
  final OnQueryCallBack onQuerySubmittedCallBack;
  final SearchBarStateCallBack searchBarStateCallBack;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TS24SearchBarWidget(
      {Key key,
      this.leading,
      this.title,
      this.backgroundColor,
      this.onQueryChangedCallBack,
      this.onQuerySubmittedCallBack,
      this.searchBarStateCallBack,
      this.bottom,
      this.primaryColor,
      this.countResult,
      this.resultWidget,
      this.contentWidget,
      this.onTapFloatButton,
      this.actions,
      this.listFloatingActionButton,
      this.drawer,
      this.scaffoldKey})
      : super(key: key);

  @override
  _TS24SearchBarWidgetState createState() => _TS24SearchBarWidgetState();
}

class _TS24SearchBarWidgetState extends State<TS24SearchBarWidget> {
  TS24SearchBarWidgetViewModel viewModel = TS24SearchBarWidgetViewModel();

  @override
  void initState() {
    viewModel.onListen(widget.searchBarStateCallBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar() {
      return PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            widget.bottom != null ? 110 : 50),
        child: SearchBar(
          controller: viewModel.searchBarController,
          attrs: SearchBarAttrs(
            searchBarColor: widget.backgroundColor,
            searchBarElevation: 0.0,
            statusBarColor: widget.backgroundColor,
          ),
          iconified: true,
          searchHint: translation.text("SEARCH_WIDGET.HINT_SEARCH"),
          onQueryChanged: (query) {
            viewModel.onQueryChanged(query, widget.onQuerySubmittedCallBack);
            widget.onQueryChangedCallBack(query);
          },
          onQuerySubmitted: (query) {
            viewModel.onQuerySubmitted(query);
            widget.onQuerySubmittedCallBack(query);
          },
          defaultBar: AppBar(
            elevation: 0,
            backgroundColor: widget.backgroundColor,
            leading: widget.leading,
            title: widget.title,
            actions: widget.actions,
            bottom: widget.bottom != null
                ? PreferredSize(
                    child: widget.bottom,
                    preferredSize: Size(MediaQuery.of(context).size.width, 55),
                  )
                : null,
          ),
        ),
      );
    }

    Widget _historySearchText(List<String> listHistorySearchText) {
      return Container(
        color: ThemePrimary.backgroundPrimaryColor,
        child: ListView.builder(
            itemExtent: 56,
            itemCount: listHistorySearchText.length,
            itemBuilder: (context, index) {
              return TS24Button(
                onTap: () {
                  widget.onQuerySubmittedCallBack(listHistorySearchText[index]);
                  viewModel
                      .onTapItemTicketHistory(listHistorySearchText[index]);
                },
                alignment: Alignment.center,
                child: ListTile(
                  leading: Icon(
                    Icons.history,
                    color: Colors.grey[600],
                  ),
                  title: Text(
                    listHistorySearchText[index],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Transform.rotate(
                    angle: -45,
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              );
            }),
      );
    }

    Widget _headerContent(String headerText, IconData iconData) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              headerText,
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconData,
                  color: Colors.grey[600],
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget _content({String title, IconData iconData, Widget widget}) {
      return Column(
        children: <Widget>[
          LoadingIndicator.progress(
              context: context, loading: viewModel.searching),
          _headerContent(title, iconData),
          Expanded(child: widget),
        ],
      );
    }

    Widget _body() {
      return Container(
        color: widget.backgroundColor,
//        child: _listTicket(ItemTicketsModel.listItemTickets),
        child: viewModel.searchBarState == SearchBarState.active ||
                viewModel.searchBarState == SearchBarState.clear
            ? _content(
                title: translation.text('SEARCH_WIDGET.RECENT'),
                iconData: Icons.sort,
                widget: _historySearchText(viewModel.listHistoryFiltered))
            : viewModel.searchBarState == SearchBarState.submit
                ? _content(
                    title: widget.countResult.toString() +
                        " ${translation.text('SEARCH_WIDGET.RESULT')}",
                    iconData: Icons.tune,
                    widget: widget.resultWidget)
                : viewModel.searchBarState == SearchBarState.cancel
                    ? widget.contentWidget
                    : widget.contentWidget,
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Scaffold(
            key: widget.scaffoldKey,
            appBar: _appBar(),
            body: _body(),
            endDrawer: widget.drawer,
//            floatingActionButton: widget.listFloatingActionButton != null
//                ? viewModel.searchBarState == SearchBarState.cancel
//                    ? FloatButtonWidget(
//                        tooltip: "add",
//                        onPressed: () {},
//                        listFAB: widget.listFloatingActionButton,
//                        icon: Icons.menu,
//                      )
////            FloatingActionButton(
////                        onPressed: widget.onTapFloatButton,
////                        child: Icon(Icons.add),
////                        backgroundColor: widget.primaryColor,
////                      )
//                    : null
//                : null,
          );
        },
      ),
    );
  }
}
