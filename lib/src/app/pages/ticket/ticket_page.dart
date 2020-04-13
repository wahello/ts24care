import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/helpdesk-category.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/pages/ticket/ticket_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/item_tickets_widget.dart';
import 'package:ts24care/src/app/widgets/shimmer/shimmer_item_ticket.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.context = context;
    Widget _listTicket(List<HelpdeskTicket> listItemTicket,
        {bool loadMore = false}) {
      return viewModel.listTicket.length > 0
          ? Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: decorationImageBackground(),
                  ),
                ),
                SingleChildScrollView(
                  controller:
                      loadMore ? viewModel.controller : ScrollController(),
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.9),
                    child: Column(
//        itemExtent: 110,
                      children: <Widget>[
                        SizedBox(height: 5,),
                        ...listItemTicket.map((itemTickets) {
                          List<dynamic> _listCategory = itemTickets.categoryId;
                          return TS24Button(
                            onTap: () {
                              viewModel.onTapTicket(itemTickets);
                            },
                            margin: EdgeInsets.only(top: 5, bottom: 5,left: 10,right: 10),
//                        padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 110,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
//                height: 90,
                            child: ItemTicketsWidget(
                              title: itemTickets.subject,
                              avatarUrl: itemTickets.userId.length > 0
                                  ? api.getImageByIdUser(
                                      itemTickets.userId[0].toString())
                                  : null,
//                content: itemTickets.content,
                              name: itemTickets.name,
                              time:
                                  formatTimeV2(itemTickets.dateLastStageUpdate),
                              color: itemTickets.categoryId is List
                                  ? itemTickets.categoryId.length > 2 &&
                                          !(itemTickets.categoryId[2] is bool)
                                      ? parseStringToColor(
                                          itemTickets.categoryId[2].toString())
                                      : itemTickets.categoryId.length > 0
                                          ? getColorCategory(
                                              itemTickets.categoryId[1])
                                          : Colors.grey
                                  : Colors.grey,
                            ),
                          );
                        }).toList(),
                        if (viewModel.loadingMore)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      ThemePrimary.primaryColor),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  translation.text("COMMON.LOADING_DATA"),
                                  style: TextStyle(
                                      color: ThemePrimary.primaryColor),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bgd.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9),
              ),
            );
    }

    Widget _itemShimmer() {
      return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        height: 110,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ShimmerItemTicketsWidget(),
      );
    }

    Widget _content() {
      return RefreshIndicator(
          onRefresh: () async {
            viewModel.onLoad();
          },
          child: viewModel.loading
              ? Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: decorationImageBackground(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.8),
                      child: ListView(
                        children: [
                          SizedBox(height: 5,),
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
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: decorationImageBackground(),
                      ),
                    ),
                    _listTicket(viewModel.listTicket, loadMore: true)
                  ],
                ));
    }

    Widget _buildMenuStatusIcon(
        {void onSelected(CustomPopupMenu customPopupMenu)}) {
      return PopupMenuButton<CustomPopupMenu>(
        child: Row(
          children: <Widget>[
            Text(
              "${translation.text("TICKET_PAGE.STATUS")}: ",
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

    Widget __buildMenuCategory(
        {void onSelected(HelpDeskCategory helpDeskCategory)}) {
      return PopupMenuButton<HelpDeskCategory>(
        child: Row(
          children: <Widget>[
//              Container(
//                decoration: BoxDecoration(
//                    color: viewModel.customPopupMenu.color,
//                    border: Border.all(
//                        color: viewModel.customPopupMenu.color, width: 1.0)),
//                width: 15,
//                height: 15,
//                alignment: Alignment.center,
//                child: Text(
//                  getCharStatusState(viewModel.statusState),
//                  style: TextStyle(
//                      fontSize: 12,
//                      fontWeight: FontWeight.bold,
//                      color: Colors.white),
//                ),
//              ),
//              SizedBox(
//                width: 5,
//              ),
            Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65,
                ),
                child: Text(
                  viewModel.helpDeskCategory.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey[800],
            )
          ],
        ),
//          elevation:  30.2,
        //initialValue: viewModel.selectedLanguage,
        onSelected: onSelected,
        //offset: Offset(50, viewModel.selectedLanguage.id == 0 ? 50 : 100),
        itemBuilder: (BuildContext context) {
          return viewModel.listHelpDeskCategory.map((item) {
            return PopupMenuItem<HelpDeskCategory>(
              height: 50,
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
//                    Icon(item.iconData,color: ThemePrimary.primaryColor,),
//                    Container(
//                      decoration: BoxDecoration(
//                          color: item.color,
//                          border: Border.all(color: item.color, width: 1.0)),
//                      width: 15,
//                      height: 15,
//                      alignment: Alignment.center,
//                      child: Text(
//                        getCharStatusState(item.state),
//                        style: TextStyle(
//                            fontSize: 12,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.white),
//                      ),
//                    ),
//                    SizedBox(
//                      width: 10,
//                    ),
                  Expanded(
                    child: Text(
                      item.name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  )
                ],
              ),
            );
          }).toList();
        },
      );
    }

    viewModel.checkLocalChange();
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24SearchBarWidget(
            title: Row(
              children: <Widget>[
                Text(
                  translation.text("TICKET_PAGE.TITLE"),
//                  style: TextStyle(color: ThemePrimary.primaryColor),
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
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState.openEndDrawer();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.sort,
                                color: ThemePrimary.primaryColor,
                              ),
                              Text(
                                translation.text("TICKET_PAGE.SORT"),
                                style:
                                    TextStyle(color: ThemePrimary.primaryColor),
                              )
                            ],
                          ),
                        )
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
            drawer: Drawer(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      translation
                          .text("TICKET_PAGE.SORT_TICKETS")
                          .toUpperCase(),
                      style: TextStyle(
                          color: ThemePrimary.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 45,
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "${translation.text("TICKET_PAGE.CATEGORY")} :",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          __buildMenuCategory(onSelected: (helpDeskCategory) {
                            viewModel
                                .onSelectedHelpDeskCategory(helpDeskCategory);
                          }),
//                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        viewModel.changeSortDate();
                      },
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "${translation.text("TICKET_PAGE.DATE")}:",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              viewModel.isAscendingDate
                                  ? translation.text("TICKET_PAGE.ASCENDING")
                                  : translation.text("TICKET_PAGE.DECREASE"),
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              viewModel.isAscendingDate
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(),
                        TS24Button(
                          alignment: Alignment.center,
                          decoration:
                              BoxDecoration(color: ThemePrimary.primaryColor),
                          onTap: () {
                            viewModel.onTapHandleSettingSort();
                          },
                          width: 80,
                          height: 40,
                          child: Text(
                            translation.text("TICKET_PAGE.APPLY"),
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            scaffoldKey: _scaffoldKey,
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
