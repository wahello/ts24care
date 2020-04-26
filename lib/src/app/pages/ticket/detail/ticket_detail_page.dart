import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/pages/ticket/detail/ticket_detail_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/list_message_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_load_attachment_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_add_attachment_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';
import 'package:html/dom.dart' as dom;

class TicketDetailPage extends StatefulWidget {
  static const String routeName = "/ticketDetailPage";
  final TicketDetailArgs args;

  const TicketDetailPage({Key key, this.args}) : super(key: key);
  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class TicketDetailArgs {
  final int id;
  final Color color;
  TicketDetailArgs({this.id, this.color});
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  TicketDetailViewModel viewModel = TicketDetailViewModel();
  GlobalKey _key = GlobalKey();
  Size _size = Size(0, 0);
  bool isGetSizeAlready = false;
  _getSize() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    _size = renderBox.size;
    isGetSizeAlready = true;
    print(_size);
  }

  @override
  void initState() {
    viewModel.onLoadHelpDeskCategory(widget.args.id);
    viewModel.onLoad(widget.args.id);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _getSize();
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar() {
      return TS24AppBar(
        backgroundColorStart: ThemePrimary.backgroundColor,
        backgroundColorEnd: ThemePrimary.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, viewModel.ticketChanged),
          icon: Icon(
            Icons.arrow_back,
            color: ThemePrimary.primaryColor,
          ),
        ),
        title: Text(viewModel.helpdeskTicket != null
            ? viewModel.helpdeskTicket.name.toString()
            : ''),
        bottom: viewModel.helpdeskTicket != null
            ? PreferredSize(
                child: Container(height: 10, color: widget.args.color),
                preferredSize: Size(MediaQuery.of(context).size.width, 10),
              )
            : null,
      );
    }

    Widget _lineThin() {
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          height: 0.5,
          color: Colors.grey[400],
        ),
      );
    }

    Widget _lineThink() {
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: 10,
          color: ThemePrimary.backgroundPrimaryColor,
        ),
      );
    }

    Widget _title(String title) {
      return Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
//                      height: 50,
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      );
    }

    Widget __info() {
      Widget ___listAttachment() {
//          viewModel.listAttachContent[0].id = 1;
        return viewModel.listAttachContent.length > 0
            ? TS24LoadAttachmentWidget(
                listIrAttachment: viewModel.listAttachContent,
              )
            : Container();
      }

      Widget ___description() {
        return Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//                Text("Description",style: TextStyle(fontSize: 16),),
//                SizedBox(height: 15,),
//                Container(height: 0.5,color: Colors.grey[400],width: MediaQuery.of(context).size.width*0.3,),
//                SizedBox(height: 15,),
              Html(
                data:viewModel.helpdeskTicket.description,
                customTextStyle: (dom.Node node, TextStyle baseStyle) {
                    return baseStyle.merge(TextStyle(height: 2));
                },
              ),
            ],
          ),
        );
      }

      String avatarUrl = viewModel.helpdeskTicket.userId.length > 0
          ? api.getImageByIdUser(viewModel.helpdeskTicket.userId[0].toString())
          : null;
      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    (viewModel.helpdeskTicket.subject == null ||
                            viewModel.helpdeskTicket.subject is bool)
                        ? ''
                        : viewModel.helpdeskTicket.subject.toString(),
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    (viewModel.helpdeskTicket.contactName == null ||
                            viewModel.helpdeskTicket.contactName is bool)
                        ? "${translation.text("TICKET_DETAIL_PAGE.FROM")} : "
                        : "${translation.text("TICKET_DETAIL_PAGE.FROM")} : " +
                            viewModel.helpdeskTicket.contactName.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        (viewModel.helpdeskTicket.createDate == null ||
                                viewModel.helpdeskTicket.createDate is bool)
                            ? ''
                            : formatTimeV2(viewModel.helpdeskTicket.createDate),
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      ),
                      if (avatarUrl != null)
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 0, right: 10),
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(45.0),
                                  child: avatarUrl != null
                                      ? Image.network(
                                          avatarUrl,
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                        )
                                      : Image.asset(
                                          "assets/images/default.jpg",
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                        ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  viewModel.helpdeskTicket.userId[1].toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            _lineThin(),
            SizedBox(
              height: 5,
            ),
//              _title(translation.text("TICKET_DETAIL_PAGE.PROPERTIES")),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${translation.text("TICKET_DETAIL_PAGE.STATUS")}: ",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  if (viewModel.customPopupMenu != null)
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: viewModel.customPopupMenu.color,
                              border: Border.all(
                                  color: viewModel.customPopupMenu.color,
                                  width: 1.0)),
                          width: 15,
                          height: 15,
                          alignment: Alignment.center,
                          child: Text(
                            getCharStatusState(viewModel.customPopupMenu.state),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(viewModel.customPopupMenu.title.toString())
                      ],
                    )
//                      ___buildMenuStatusIcon(
//                          iconData: Icons.add,
//                          onSelected: (customPopupMenu) {
//                            viewModel.customPopupMenu = customPopupMenu;
////                            viewModel.onSelectedTicketStatus(customPopupMenu);
//                          })
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
//              if (viewModel.helpDeskCategory != null) ___line(),
            if (viewModel.helpDeskCategory != null)
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${translation.text("TICKET_DETAIL_PAGE.SERVICE")}: ",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    Text(viewModel.helpDeskCategory.name)
                  ],
                ),
              ),
            SizedBox(
              height: 5,
            ),
            _lineThink(),
            SizedBox(
              height: 5,
            ),
            _title(translation.text("TICKET_DETAIL_PAGE.CONTENT")),
            ___description(),
            SizedBox(
              height: 5,
            ),
            ___listAttachment(),
            SizedBox(
              height: 5,
            ),
            _lineThin(),
          ],
        ),
      );
    }

    Widget _inputText() {
      Widget ___buildMenuIcon(
          {IconData iconData,
          void onSelected(CustomPopupMenu customPopupMenu)}) {
        return PopupMenuButton<CustomPopupMenu>(
          child: IconButton(
            icon: Icon(
              Icons.attach_file,
              color: ThemePrimary.primaryColor,
            ),
          ),
//          elevation:  30.2,
          //initialValue: viewModel.selectedLanguage,
          onSelected: onSelected,
          //offset: Offset(50, viewModel.selectedLanguage.id == 0 ? 50 : 100),
          itemBuilder: (BuildContext context) {
            return CustomPopupMenu.listMenuAttachment
                .map((CustomPopupMenu item) {
              return PopupMenuItem<CustomPopupMenu>(
                height: 50,
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      item.iconData,
                      color: ThemePrimary.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      item.title.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    )
                  ],
                ),
              );
            }).toList();
          },
        );
      }

      return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          key: _key,
          child: Column(
            children: <Widget>[
              Container(
                height: 1,
                color: Colors.grey[300],
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
//                  Container(
//                    width: MediaQuery.of(context).size.width,
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Row(
//                          children: <Widget>[
//                            Text(
//                              "Trả lời công khai",
//                              style: TextStyle(
//                                  color: ThemePrimary.primaryColor,
//                                  fontSize: 16,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            IconButton(
//                              icon: Icon(
//                                Icons.arrow_drop_down,
//                                color: ThemePrimary.primaryColor,
//                              ),
//                              onPressed: () {},
//                            )
//                          ],
//                        ),
//                        Row(
//                          children: <Widget>[
//                            Icon(
//                              Icons.add,
//                              color: ThemePrimary.primaryColor,
//                              size: 16,
//                            ),
//                            Text(
//                              "CC",
//                              style: TextStyle(
//                                  color: ThemePrimary.primaryColor,
//                                  fontSize: 16,
//                                  fontWeight: FontWeight.bold),
//                            )
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
                    TextField(
                      controller: viewModel.descriptionEditingController,
                      decoration: InputDecoration(
                        hintText: translation
                            .text("TICKET_DETAIL_PAGE.HINT_INPUT_TEXT"),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                    ),
                    if (viewModel.listAddAttachmentModel.length > 0)
                      TS24AddAttachmentWidget(
                        listIdAttachment: viewModel.listAddAttachmentModel,
                        onCallback: (_) {
                          viewModel.updateState();
                        },
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ___buildMenuIcon(
                                iconData: Icons.attach_file,
                                onSelected: (customPopupMenu) {
                                  viewModel.onSelectedAttachment(
                                      customPopupMenu.state);
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                viewModel.onSelectedCamera();
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: ThemePrimary.primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
//                          IconButton(
//                            icon: Icon(Icons.tag_faces),
//                          ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            if (viewModel.descriptionEditingController.text
                                .isNotEmpty) viewModel.onSend();
                          },
                          icon: Icon(Icons.send,
                              color: (viewModel.descriptionEditingController
                                      .text.isNotEmpty)
                                  ? ThemePrimary.primaryColor
                                  : Colors.grey[300]),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _body() {
      return Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                bottom: (viewModel.customPopupMenu != null &&
                        viewModel.customPopupMenu.state !=
                            MenuStatusState.CANCEL)
                    ? _size.height
                    : 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
              onRefresh: () async {
                viewModel.onLoad(widget.args.id);
              },
              child: Container(
//                color: ThemePrimary.backgroundPrimaryColor,
                child: SingleChildScrollView(
                  child: viewModel.loading
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: LoadingIndicator.progress(
                              context: context, loading: viewModel.loading),
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(
                                  minHeight:
                                      MediaQuery.of(context).size.height -
                                          (MediaQuery.of(context).padding.top +
                                              AppBar().preferredSize.height +
                                              10 +
                                              _size.height) -
                                          10),
                              child: Column(
                                children: <Widget>[
                                  __info(),
                                  Container(
                                    color: Colors.white,
                                    child: _title(
                                        "${translation.text("TICKET_DETAIL_PAGE.CONVERSATION")}(${viewModel.listMailMessage.length})"),
                                  ),
                                  if (!viewModel.loading &&
                                      !(viewModel.listMailMessage is bool) &&
                                      viewModel.listMailMessage.length > 0)
                                    Container(
                                      color: Colors.white,
                                      child: ListMessageWidget(
                                          listMailMessage:
                                              viewModel.listMailMessage),
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              height: 10,
                              color: ThemePrimary.backgroundPrimaryColor,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          isGetSizeAlready
              ? (viewModel.customPopupMenu != null &&
                      viewModel.customPopupMenu.state != MenuStatusState.CANCEL)
                  ? _inputText()
                  : SizedBox()
              : _inputText()
        ],
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, viewModel.ticketChanged);
              return false;
            },
            child: TS24Scaffold(
              appBar: _appBar(),
              body: _body(),
            ),
          );
        },
      ),
    );
  }
}
