import 'package:flutter/material.dart';
import 'package:ts24care/packages/loader_search_bar/loader_search_bar.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_tickets_model.dart';
import 'package:ts24care/src/app/pages/ticket/ticket_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/item_tickets_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class TicketsPage extends StatefulWidget {
  static const String routeName = "/ticketsPage";
  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage>
    with AutomaticKeepAliveClientMixin {
  TicketPageViewModel viewModel = TicketPageViewModel();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.context = context;
    Widget _appBar() {
      return PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 110),
        child: SearchBar(
          controller: viewModel.searchBarController,
          attrs: SearchBarAttrs(
            searchBarColor: ThemePrimary.backgroundColor,
            searchBarElevation: 0.0,
            statusBarColor: ThemePrimary.backgroundColor,
          ),
          iconified: true,
          searchHint: 'Tìm kiếm...',
          onQueryChanged: viewModel.onQueryChanged,
          onQuerySubmitted: viewModel.onQuerySubmitted,
          defaultBar: AppBar(
            elevation: 0,
            backgroundColor: ThemePrimary.backgroundColor,
            leading: InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            title: Row(
              children: <Widget>[
                Text(
                  "Your unsolved tickets (3)",
                  style: TextStyle(color: Colors.black87),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black87,
                )
              ],
            ),
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Status: Open",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_downward,
                              color: ThemePrimary.primaryColor,
                            ),
                            Text(
                              "Default",
                              style:
                                  TextStyle(color: ThemePrimary.primaryColor),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
            ),
          ),
        ),
      );
    }

    Widget _listTicket(List<ItemTicketsModel> listItemTicketsModel) {
      return ListView.builder(
          itemExtent: 110,
          itemCount: listItemTicketsModel.length,
          itemBuilder: (context, index) {
            var itemTickets = listItemTicketsModel[index];
            return TS24Button(
              onTap: () {},
              margin: EdgeInsets.only(top: 5, bottom: 5),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
//                height: 90,
              child: ItemTicketsWidget(
                title: itemTickets.title,
                avatarUrl: itemTickets.avatarUrl,
                content: itemTickets.content,
                name: itemTickets.userName,
                time: itemTickets.time,
              ),
            );
          });
    }

    Widget _headerContent(String headerText, IconData iconData) {
      return Container(
//                color: Colors.white,
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              headerText,
              style: TextStyle(
                  color: Colors.grey[800],
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

    Widget _historySearchText(List<String> listHistorySearchText) {
      return ListView.builder(
          itemExtent: 56,
          itemCount: listHistorySearchText.length,
          itemBuilder: (context, index) {
            return TS24Button(
              onTap: () {
                viewModel.onTapItemTicketHistory(listHistorySearchText[index]);
              },
              alignment: Alignment.center,
              child: ListTile(
                leading: Icon(Icons.history),
                title: Text(listHistorySearchText[index]),
                trailing: Transform.rotate(
                  angle: -45,
                  child: Icon(Icons.arrow_upward),
                ),
              ),
            );
          });
    }

    Widget _content({String title, IconData iconData, Widget widget}) {
      return Column(
        children: <Widget>[
          _headerContent(title, iconData),
          Expanded(child: widget),
        ],
      );
    }

    Widget _body() {
      return Container(
        color: ThemePrimary.backgroundColor,
//        child: _listTicket(ItemTicketsModel.listItemTickets),
        child: viewModel.searchBarState == SearchBarState.active ||
                viewModel.searchBarState == SearchBarState.clear
            ? _content(
                title: "Recent",
                iconData: Icons.sort,
                widget: _historySearchText(viewModel.listHistoryFiltered))
            : viewModel.searchBarState == SearchBarState.submit
                ? _content(
                    title: viewModel.listTicketFiltered.length.toString() +
                        " Result",
                    iconData: Icons.tune,
                    widget: _listTicket(viewModel.listTicketFiltered))
                : viewModel.searchBarState == SearchBarState.cancel
                    ? _listTicket(ItemTicketsModel.listItemTickets)
                    : _listTicket(ItemTicketsModel.listItemTickets),
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
            floatingActionButton:
                viewModel.searchBarState == SearchBarState.cancel
                    ? FloatingActionButton(
                        onPressed: () {
                          viewModel.onTapCreateTicket();
                        },
                        child: Icon(Icons.add),
                        backgroundColor: ThemePrimary.primaryColor,
                      )
                    : null,
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
