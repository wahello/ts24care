import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/pages/ticket/ticket_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/item_tickets_widget.dart';
import 'package:ts24care/src/app/widgets/ts24SearchBarWidget/ts24_search_bar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

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
    Widget _listTicket(List<HelpdeskTicket> listItemTicket) {
      return ListView.builder(
          itemExtent: 110,
          itemCount: listItemTicket.length,
          itemBuilder: (context, index) {
            var itemTickets = listItemTicket[index];
            return TS24Button(
              onTap: () {
                viewModel.onTapTicket(itemTickets);
              },
              margin: EdgeInsets.only(top: 5, bottom: 5),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
//                height: 90,
              child: ItemTicketsWidget(
                title: itemTickets.subject,
                avatarUrl: itemTickets.userId.length > 0
                    ? api.getImageByIdPartner(itemTickets.userId[0].toString())
                    : null,
//                content: itemTickets.content,
                name: itemTickets.name,
                time: formatTime(itemTickets.dateLastStageUpdate),
              ),
            );
          });
    }

    Widget _content() {
      return RefreshIndicator(
        onRefresh: () async {
          viewModel.onLoad(0);
        },
        child: viewModel.listTicket.length > 0
            ? _listTicket(viewModel.listTicket)
            : SingleChildScrollView(
                child: Container(
                height: MediaQuery.of(context).size.height*0.8,
                color: ThemePrimary.backgroundColor,
                  alignment: Alignment.topCenter,
                  child: LoadingIndicator.spinner(context: context,loading: viewModel.loading),
              )),
      );
    }

    Widget _buildMenuStatusIcon(
        {void onSelected(CustomPopupMenu customPopupMenu)}) {
      return PopupMenuButton<CustomPopupMenu>(
        child: Row(
          children: <Widget>[
            Text(
              "Trạng thái: ",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              viewModel.customPopupMenu.title.toString(),
              style: TextStyle(fontSize: 18),
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
//          elevation:  30.2,
        //initialValue: viewModel.selectedLanguage,
        onSelected: onSelected,
        //offset: Offset(50, viewModel.selectedLanguage.id == 0 ? 50 : 100),
        itemBuilder: (BuildContext context) {
          return viewModel.listStatusTicket.map((CustomPopupMenu item) {
            return PopupMenuItem<CustomPopupMenu>(
              height: 50,
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
//                    Icon(item.iconData,color: ThemePrimary.primaryColor,),
                  Container(
                    decoration: BoxDecoration(
                        color: item.color,
                        border: Border.all(color: item.color, width: 1.0)),
                    width: 15,
                    height: 15,
                    alignment: Alignment.center,
                    child: Text(
//                      viewModel.getCharStatusState(item.state),
                      getCharStatusState(item.state),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item.title.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  )
                ],
              ),
            );
          }).toList();
        },
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24SearchBarWidget(
            title: Row(
              children: <Widget>[
                Text(
                  "Phiếu yêu cầu",
                  style: TextStyle(color: Colors.black87),
                ),
//                Icon(
//                  Icons.keyboard_arrow_down,
//                  color: Colors.black87,
//                )
              ],
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  viewModel.onTapCreateTicket();
                },
                icon: Icon(
                  Icons.create,
                  color: Colors.black,
                ),
              )
            ],
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
//                        Text(
//                          "Status: Open",
//                          style: TextStyle(
//                              color: Colors.grey[800],
//                              fontSize: 18,
//                              fontWeight: FontWeight.w600),
//                        ),
                        _buildMenuStatusIcon(onSelected: viewModel.onSelected),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Icon(
//                              Icons.arrow_downward,
//                              color: ThemePrimary.primaryColor,
//                            ),
//                            Text(
//                              "Mặc định",
//                              style:
//                                  TextStyle(color: ThemePrimary.primaryColor),
//                            )
//                          ],
//                        )
                      ],
                    ),
                  )
                ],
              ),
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
            ),
            backgroundColor: ThemePrimary.backgroundColor,
            primaryColor: ThemePrimary.primaryColor,
//
//            listFloatingActionButton: [
//              FloatingActionButton(
//                backgroundColor: ThemePrimary.primaryColor,
//                heroTag: 0,
//                onPressed: () {
//                  viewModel.onTapCreateTicket();
//                },
//                tooltip: 'add',
//                child: Icon(Icons.add),
//              ),
//              FloatingActionButton(
//                backgroundColor: ThemePrimary.primaryColor,
//                heroTag: 1,
//                onPressed: null,
//                tooltip: 'call',
//                child: Icon(Icons.call),
//              ),
//              FloatingActionButton(
//                backgroundColor: ThemePrimary.primaryColor,
//                heroTag: 2,
//                onPressed: (){
//                  viewModel.onTapChat();
//                },
//                tooltip: 'message',
//                child: Icon(Icons.message),
//              )
//            ],
            searchBarStateCallBack: (_) {},
            onQueryChangedCallBack: (_) {},
            onQuerySubmittedCallBack: viewModel.onQuerySubmitted,
            countResult: viewModel.listTicketFiltered.length,
            resultWidget: _listTicket(viewModel.listTicketFiltered),
            contentWidget: _content(),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
