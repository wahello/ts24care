import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ts24care/src/app/models/item_attachment_model.dart';

typedef AttachmentCallBack = void Function(List<ItemAddAttachmentModel> list);

class TS24AddAttachmentWidget extends StatefulWidget {
  final List<ItemAddAttachmentModel> listIdAttachment;
  final AttachmentCallBack onCallback;
  const TS24AddAttachmentWidget(
      {Key key, this.listIdAttachment, this.onCallback})
      : super(key: key);
  @override
  _TS24AddAttachmentWidgetState createState() =>
      _TS24AddAttachmentWidgetState();
}

class _TS24AddAttachmentWidgetState extends State<TS24AddAttachmentWidget> {
  Color getColor(String extension) {
    return extension == "doc" || extension == "docx"
        ? Colors.blue
        : extension == "xls" || extension == "xlsx"
            ? Colors.green
            : extension == "ppt" || extension == "pptx"
                ? Colors.deepOrange[800]
                : extension == "pdf"
                    ? Colors.red
                    : extension == "xml" ? Colors.brown : Colors.blueGrey;
  }

  IconData getIcon(String extension) {
    return extension == "doc" || extension == "docx"
        ? FontAwesomeIcons.fileWord
        : extension == "xls" || extension == "xlsx"
            ? FontAwesomeIcons.fileExcel
            : extension == "ppt" || extension == "pptx"
                ? FontAwesomeIcons.filePowerpoint
                : extension == "pdf"
                    ? FontAwesomeIcons.filePdf
                    : extension == "xml"
                        ? FontAwesomeIcons.fileCode
                        : FontAwesomeIcons.file;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 65,
//        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: ListView.builder(
//                padding: EdgeInsets.only(left: 5,right: 5),
//                itemExtent: 80,

            scrollDirection: Axis.horizontal,
            itemCount: widget.listIdAttachment.length,
            itemBuilder: (context, index) {
              ItemAddAttachmentModel model = widget.listIdAttachment[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Stack(
                  children: <Widget>[
                    model.extension == "png" ||
                            model.extension == "jpg" ||
                            model.extension == "jpeg" ||
                            model.extension == "gif" ||
                            model.extension == "bmp"
                        ? Container(
                            width: 100,
                            height: 60,
                            margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Image.file(
                                File.fromUri(Uri.parse(widget
                                    .listIdAttachment[index]
                                    .localDirectory)), //widget.listIdAttachment[index].localDirectory,
                                height: 90,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : (model.id == -1)
                            ? Container(
                                width: 100,
                                height: 60,
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: getColor(model.extension))),
                                  height: 40,
                                  width: 90,
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: 100,
                                height: 60,
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: getColor(model.extension))),
                                  height: 40,
                                  width: 90,
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        getIcon(model.extension),
                                        color: getColor(model.extension),
                                      ),
                                      Text(
                                        model.fileName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: getColor(model.extension)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                    if (model.id != -1)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black54, shape: BoxShape.circle),
                          child: InkWell(
//                          padding: EdgeInsets.all(2),
                            onTap: () {
                              setState(() {
                                widget.listIdAttachment.removeAt(index);
                                widget.onCallback(widget.listIdAttachment);
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              );
            }));
  }
}
