import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/mail-message.dart';
import 'package:ts24care/src/app/widgets/item_comment_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';

class ListMessageWidget extends StatefulWidget {
  final List<MailMessage> listMailMessage;

  const ListMessageWidget({Key key, this.listMailMessage}) : super(key: key);
  @override
  _ListMessageWidgetState createState() => _ListMessageWidgetState();
}

class _ListMessageWidgetState extends State<ListMessageWidget> {
  bool isExpand = false;
  GlobalKey _key = GlobalKey();
  Size _size = Size(0, 0);
  _getSize() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    _size = _size = renderBox.size;
    print(_size);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _getSize();
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _listShortMailMessage() {
      return widget.listMailMessage.length < 3
          ? Column(
              children: <Widget>[
                ...widget.listMailMessage.reversed.map((message) {
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
                        expand: true,
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
          : Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      key: _key,
                      child: ItemCommentWidget(
                        name: widget
                            .listMailMessage[widget.listMailMessage.length - 1]
                            .authorId[1]
                            .toString(),
                        avatarUrl: api.getImageByIdPartner(widget
                            .listMailMessage[widget.listMailMessage.length - 1]
                            .authorId[0]
                            .toString()),
                        dateTime: widget
                            .listMailMessage[widget.listMailMessage.length - 1]
                            .writeDate
                            .toString(),
                        content: widget
                            .listMailMessage[widget.listMailMessage.length - 1]
                            .body
                            .toString(),
                        listAttachId: widget
                            .listMailMessage[widget.listMailMessage.length - 1]
                            .attachmentIds
                            .map((item) => int.parse(item.toString()))
                            .toList(),
                        expand: true,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 0.5,
                      color: Colors.grey[400],
                    ),
                    (isExpand)
                        ? Container(
                            child: Column(
                              children: <Widget>[
                                ...widget.listMailMessage
                                    .sublist(
                                        1, widget.listMailMessage.length - 2)
                                    .reversed
                                    .map((message) {
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 0.5,
                                        color: Colors.grey[400],
                                      )
                                    ],
                                  );
                                })
                              ],
                            ),
                          )
                        : Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width,
                          ),
                    ItemCommentWidget(
                      name: widget.listMailMessage[0].authorId[1].toString(),
                      avatarUrl: api.getImageByIdPartner(
                          widget.listMailMessage[0].authorId[0].toString()),
                      dateTime: widget.listMailMessage[0].writeDate.toString(),
                      content: widget.listMailMessage[0].body.toString(),
                      listAttachId: widget.listMailMessage[0].attachmentIds
                          .map((item) => int.parse(item.toString()))
                          .toList(),
                      expand: true,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 0.5,
                      color: Colors.grey[400],
                    )
                  ],
                ),
                if (!isExpand)
                  Positioned(
                    left: 70,
                    top: _size.height + 70,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isExpand =! isExpand;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 15.0),
                                  blurRadius: 15.0),
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, -10.0),
                                  blurRadius: 10.0),
                            ]),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.expand_less,
                              size: 20,
                            ),
                            Icon(
                              Icons.expand_more,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            );
    }

    return _listShortMailMessage();
  }
}
