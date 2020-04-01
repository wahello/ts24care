import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/models/ir-attachment.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/models/mail-message.dart';
import 'package:ts24care/src/app/pages/ticket/detail/ticket_detail_page_viewmodel.dart';
import 'package:ts24care/src/app/provider/api.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/item_comment_widget.dart';
import 'package:ts24care/src/app/widgets/list_message_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_load_attachment_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_add_attachment_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class TicketDetailPage extends StatefulWidget {
  static const String routeName = "/ticketDetailPage";
  final HelpdeskTicket args;

  const TicketDetailPage({Key key, this.args}) : super(key: key);
  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  TicketDetailViewModel viewModel = TicketDetailViewModel();
  @override
  void initState() {
    viewModel.helpdeskTicket = widget.args;
    viewModel.onLoad(widget.args.id);
    viewModel.onLoadHelpDeskCategory(widget.args.id);
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
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.args.name,
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    Widget _body() {
      Widget __info() {
        Widget ___buildMenuStatusIcon(
            {IconData iconData,
            void onSelected(CustomPopupMenu customPopupMenu)}) {
          return PopupMenuButton<CustomPopupMenu>(
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: viewModel.customPopupMenu.color,
                      border: Border.all(
                          color: viewModel.customPopupMenu.color, width: 1.0)),
                  width: 15,
                  height: 15,
                  alignment: Alignment.center,
                  child: Text(
                    getCharStatusState(viewModel.statusState),
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
            ),
//          elevation:  30.2,
            initialValue: viewModel.customPopupMenu,
            onSelected: onSelected,
            //offset: Offset(50, viewModel.selectedLanguage.id == 0 ? 50 : 100),
            itemBuilder: (BuildContext context) {
              return CustomPopupMenu.listTicketStatus
                  .map((CustomPopupMenu item) {
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
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      )
                    ],
                  ),
                );
              }).toList();
            },
          );
        }

//        Widget ___loadingAttachmentWidget() {
//          var ____list = List();
//          if (viewModel.helpdeskTicket.attachmentIds != null &&
//              viewModel.helpdeskTicket.attachmentIds.length > 0)
//            ____list = viewModel.helpdeskTicket.attachmentIds
//                .map((item) => IrAttachment.fromJson(item))
//                .toList();
//          return Container(
////            color: Colors.red,
//            width: MediaQuery.of(context).size.width,
//            height: 100,
//            margin: EdgeInsets.all(15),
//            alignment: Alignment.center,
//            child: ListView.builder(
//                itemCount: ____list.length,
//                scrollDirection: Axis.horizontal,
//                itemBuilder: (context, index) {
//                  return Padding(
//                    padding: EdgeInsets.only(right: 10),
//                    child: Container(
////                      color: Colors.green,
//                      width: 100,
//                      height: 60,
//                      margin: EdgeInsets.fromLTRB(0, 10, 10, 30),
//                      child: Container(
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10)),
//                            border: Border.all(color: Colors.blueGrey)),
//                        height: 40,
//                        width: 90,
//                        padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
//                        child: CircularProgressIndicator(
//                          valueColor:
//                              AlwaysStoppedAnimation<Color>(Colors.blueGrey),
//                        ),
//                      ),
//                    ),
//                  );
//                }),
//          );
//        }

        Widget ___listAttachment() {
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
                HtmlWidget(
                  widget.args.description,
                  webViewJs: true,
                ),
              ],
            ),
          );
        }

        Widget ___line() {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 0.5,
            color: Colors.grey[400],
          );
        }

        String avatarUrl = widget.args.userId.length > 0
            ? api.getImageByIdPartner(widget.args.userId[0].toString())
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
                      widget.args.subject,
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
                      "người gửi : " + widget.args.contactName.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.args.createDate,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[800]),
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
                                    widget.args.contactName.toString(),
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
              ___line(),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Trạng thái: ",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    if (viewModel.customPopupMenu != null)
                      ___buildMenuStatusIcon(
                          iconData: Icons.add,
                          onSelected: (customPopupMenu) {
                            viewModel.customPopupMenu = customPopupMenu;
                            viewModel.onSelectedTicketStatus(customPopupMenu);
                          })
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if (viewModel.helpDeskCategory != null)
              ___line(),
              if (viewModel.helpDeskCategory != null)
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Dịch vụ: ",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      Text(viewModel.helpDeskCategory.name)
                    ],
                  ),
                ),
              SizedBox(
                height: 5,
              ),
              ___line(),
              SizedBox(
                height: 5,
              ),
              ___description(),
              SizedBox(
                height: 5,
              ),
              ___listAttachment(),
              SizedBox(
                height: 5,
              ),
              ___line(),
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
          child: SafeArea(
            bottom: true,
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
                          hintText: "Nhập tin nhắn tại đây...",
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
                                    : Colors.black),
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

      Widget _listMessage() {
//        var listMailMessage = List();
//        if(viewModel.listModel.length > 0)
//        viewModel.listModel.forEach((message) {
//          listMailMessage.;
//        });
        return !viewModel.loading && viewModel.listMailMessage.length > 0
            ? Column(
                children: <Widget>[
                  ...viewModel.listMailMessage.reversed.map((message) {
                    List<int> _listIdAttachment = List();
                    _listIdAttachment = message.attachmentIds
                        .map((item) => int.parse(item.toString()))
                        .toList();
                    return Column(
                      children: <Widget>[
                        ItemCommentWidget(
                          name: message.authorId[1].toString(),
                          avatarUrl: api.getImageByIdPartner(
                              message.authorId[0].toString()),
                          dateTime: message.writeDate.toString(),
                          content: message.body.toString(),
                          listAttachId: _listIdAttachment,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 0.5,
                          color: Colors.grey[400],
                        )
                      ],
                    );
                  })
                ],
              )
            : Container();
      }

      return Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 100),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
              onRefresh: () async {
                viewModel.onLoad(widget.args.id);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    __info(),
//                  _listMessage(),
                    if (!viewModel.loading &&
                        viewModel.listMailMessage.length > 0)
                      ListMessageWidget(
                          listMailMessage: viewModel.listMailMessage),
                    Container(
                      height: 150,
                      color: ThemePrimary.backgroundColor,
                    )
                  ],
                ),
              ),
            ),
          ),
          _inputText()
        ],
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
}
