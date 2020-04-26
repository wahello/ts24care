import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:open_file/open_file.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/ir-attachment.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';
import 'package:ts24care/src/app/widgets/view_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TS24LoadAttachmentWidget extends StatefulWidget {
  final List<IrAttachment> listIrAttachment;
  const TS24LoadAttachmentWidget({Key key, this.listIrAttachment})
      : super(key: key);
  @override
  _TS24LoadAttachmentWidgetState createState() =>
      _TS24LoadAttachmentWidgetState();
}

class _TS24LoadAttachmentWidgetState extends State<TS24LoadAttachmentWidget> {
  List<IrAttachment> _listIrAttachment = List();
  List<IrAttachment> _listIrAttachmentCache = List();
  List<Uint8List> _listData;
  bool reloading = false;
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

  bool compareList(List<IrAttachment> listA, List<IrAttachment> listB) {
    if (listA.length != listB.length) return false;
    for (var value in listA) {
      var listItem = listB.where((item) => item.id == value.id);
      if (listItem.length == 0) return false;
    }
    for (var value in listB) {
      var listItem = listA.where((item) => item.id == value.id);
      if (listItem.length == 0) return false;
    }
    return true;
  }

  onReLoad() async {
    if (!compareList(_listIrAttachmentCache, widget.listIrAttachment)) {
      _listIrAttachment = widget.listIrAttachment;
      onLoad();
    }
  }

  onLoad() async {
    for (int i = 0; i < _listIrAttachment.length; i++) {
      if (_listIrAttachment[i].datas == null)
        api.getAttachmentById(_listIrAttachment[i].id).then((irAttachment) {
          if (irAttachment != null)
            try {
              setState(() {
                _listIrAttachment[i] = irAttachment;
              });
            } catch (e) {
              print(e);
            }
        });
    }
  }

  @override
  void initState() {
    _listIrAttachmentCache = widget.listIrAttachment;
    _listIrAttachment = widget.listIrAttachment;
    _listData = List(widget.listIrAttachment.length);
    onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onReLoad();
    return _listIrAttachment.length > 0
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            margin: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: _listIrAttachment.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  IrAttachment item = _listIrAttachment[index];
                  if (item.datas != null && _listData[index] == null)
                    _listData[index] = base64.decode(item.datas);
                  String extension = item.mimetype.toString().split("/").last;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _listData[index] != null
                        ? Stack(
                            children: <Widget>[
                              extension == "png" ||
                                      extension == "jpg" ||
                                      extension == "jpeg" ||
                                      extension == "gif" ||
                                      extension == "bmp"
                                  ? _listData[index] != null
                                      ? Container(
                                          width: 100,
                                          height: 60,
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 10, 0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Image.memory(
                                              _listData[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Container()
                                  : Container(
                                      width: 100,
                                      height: 60,
                                      margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: getColor(extension))),
                                        height: 40,
                                        width: 90,
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              getIcon(extension),
                                              color: getColor(extension),
                                            ),
                                            Text(
                                              item.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: getColor(extension)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                              Positioned(
                                top: 40,
                                right: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.file_download,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  width: 100,
                                  height: 60,
                                ),
                                onTap: () {
                                  if (isImage(extension)) {
                                    showGeneralDialog(
                                        transitionBuilder:
                                            (context, a1, a2, widget) {
                                          return ViewImageWidget(
                                            imageData: item.datas,
                                            name: item.name,
                                          );
                                        },
                                        transitionDuration:
                                            Duration(milliseconds: 10),
                                        barrierDismissible: true,
                                        barrierLabel: '',
                                        context: context,
                                        pageBuilder:
                                            (context, animation1, animation2) {
                                          return Container();
                                        }).then((result) {
                                      try {
                                        if (result != null) {
                                          ToastController.show(
                                              context: context,
                                              duration: Duration(seconds: 2),
                                              message:
                                                  "${translation.text("COMMON.DOWNLOAD_SUCCESSFUL")} : $result");
                                        }
                                      } catch (e) {}
                                    });
                                  } else {
                                    createFileFromString(item.datas, item.name)
                                        .then((dir) {
                                      if (dir != null) {
                                        // OpenFile.open(dir);
                                        print("Tải thanh cong + $dir");
                                      } else
                                        ToastController.show(
                                            context: context,
                                            duration: Duration(seconds: 2),
                                            message: translation.text(
                                                "COMMON.DOWNLOAD_FAILED"));
                                    });
                                  }
                                },
                              ),
                            ],
                          )
                        : Container(
//                      color: Colors.green,
                            width: 100,
                            height: 60,
                            margin: EdgeInsets.fromLTRB(0, 10, 10, 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.blueGrey)),
                              height: 40,
                              width: 90,
                              padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blueGrey),
                              ),
                            ),
                          ),
                  );
                }),
          )
        : Container();
  }
}
