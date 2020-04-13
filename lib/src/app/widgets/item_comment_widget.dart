import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/ir-attachment.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_load_attachment_widget.dart';

class ItemCommentWidget extends StatefulWidget {
  final String avatarUrl;
  final String name;
  final String dateTime;
  final String content;
  final bool expand;
  final bool disableTap;
  final List<int> listAttachId;
  const ItemCommentWidget(
      {Key key,
      this.avatarUrl,
      this.name,
      this.dateTime,
      this.content,
      this.expand = false,
      this.disableTap = false,
      this.listAttachId})
      : super(key: key);
  @override
  _ItemCommentWidgetState createState() => _ItemCommentWidgetState();
}

class _ItemCommentWidgetState extends State<ItemCommentWidget> {
//  bool isBuildUi = false;
  bool isExpand = true;
  bool isFirst = true;
  bool isShow = true;
  bool isControlColor = false;
  List<IrAttachment> listAttachment = List();
  GlobalKey _key = GlobalKey();
  Size _size = Size(0, 0);
  _getSize() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    _size = renderBox.size;
    isExpand = widget.expand;
    widget.listAttachId.length > 0 ? isShow = false : isShow = true;
    isFirst = false;
    isControlColor = true;
  }

  getAttachment() {
//    int count = 0;
    for (int i = 0; i < widget.listAttachId.length; i++) {
      api.getAttachmentById(widget.listAttachId[i]).then((result) {
        if (result != null)
          setState(() {
            listAttachment.add(result);
          });
      });

//      count++;
//      if (count == widget.listAttachId.length) {
//        setState(() {
//          isBuildUi = true;
//        });
//      }
    }
  }

  @override
  void initState() {
    getAttachment();
//    int count = 0;
//    for (int i = 0; i < widget.listAttachId.length; i++) {
//      api.getAttachmentById(widget.listAttachId[i]).then((item) {
//        if (item != null) {
//          print(item.name);
//          listAttachment.add(item);
//          setState(() {});
//        }
////        count++;
//      });
//    }
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _getSize();
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _content(String content) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: HtmlWidget(
          content,
          webView: true,
        ),
      );
    }

    return InkWell(
      onTap: () {
        if (!widget.disableTap)
          setState(() {
            isShow = false;
            isFirst = false;
            isControlColor = false;
            isExpand = !isExpand;
          });
      },
      child: Container(
        color:
//        isFirst
//            ? ThemePrimary.backgroundColor
//            :
            isControlColor ? ThemePrimary.backgroundColor : Colors.grey[300],
        child: !isFirst
            ? AnimatedContainer(
                onEnd: () {
                  if (isFirst) {
                    isFirst = false;
//              isExpand = false;
                  }
                  setState(() {
                    isShow = true;
                    isControlColor = true;
                  });
                },
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                height: isExpand
                    ? _size.height + (listAttachment.length > 0 ? 1 : 2) + 85
                    : 85,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 85,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 0, right: 10),
                            alignment: Alignment.center,
                            width: 45,
                            height: 45,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(45.0),
                              child: widget.avatarUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: widget.avatarUrl,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.33,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.33,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/default.jpg",
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                      ),
                                    )
                                  : Image.asset(
                                      "assets/images/default.jpg",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.35,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.name.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.grey[800]),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
//                          color: Colors.grey,
                                width: MediaQuery.of(context).size.width - 100,
                                child: Text(
//                            isExpand
//                                ?
                                  widget.dateTime.toString(),
//                                :HtmlWidget(widget.content,webViewJs: true,).toStringDeep(),//HtmlUnescape().convert(widget.content.toString()) ,
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
//                  key: _key,
//                  color: Colors.green,
                        child: isExpand
                            ? isShow
                                ? Column(
                                    children: <Widget>[
                                      _content(widget.content),
                                      if (listAttachment.length > 0)
                                        Container(
                                          height: 100,
                                          child: TS24LoadAttachmentWidget(
                                            listIrAttachment: listAttachment,
                                          ),
                                        )
                                    ],
                                  )
                                : Container(
                                    color: Colors.green,
//                                height: _size.height,
                                  )
                            : Container(
                                color: Colors.red,
                              ))
                  ],
                ),
              )
            : Container(
                key: _key,
//                  color: Clors.green,
                child: Column(
                  children: <Widget>[
                    _content(widget.content),
                    if (widget.listAttachId.length > 0)
                      Container(
                        color: Colors.transparent,
                        height: 110,
                      )
                  ],
                )),
      ),
    );
  }
}
