import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/ir-attachment.dart';
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
  List<String> listUrlAttach = List();
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

  launchURL(String url) async {
    const url = 'url';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> onLoad() async {
//    isLoadingListAttachContent = true;
//    this.updateState();
//    var _listAttachment = helpdeskTicket.attachmentIds
//        .map((item) => IrAttachment.fromJson(item))
//        .toList();
//    if (_listAttachment.length > 0) {
//      listAttachContent.clear();
//      int count = 0;
    for (int i = 0; i < widget.listIrAttachment.length; i++) {
      api.getAttachmentById(widget.listIrAttachment[i].id).then((irAttachment) {
//              count ++;
        if (irAttachment != null)
          setState(() {
            widget.listIrAttachment[i] = irAttachment;
          });
//                if(count == widget.listIrAttachment.length) {
//                  isLoadingListAttachContent = false;

//                }
      });
    }
  }

  @override
  void initState() {
    //    isLoadingListAttachContent = true;
//    this.updateState();
//    var _listAttachment = helpdeskTicket.attachmentIds
//        .map((item) => IrAttachment.fromJson(item))
//        .toList();
//    if (_listAttachment.length > 0) {
//      listAttachContent.clear();
//      int count = 0;
//      for (int i = 0; i < _listAttachment.length; i++) {
//            api.getAttachmentById(_listAttachment[i].id).then((irAttachment){
//              count ++;
//                if (irAttachment != null) listAttachContent.add(irAttachment);
//                if(count == _listAttachment.length) {
//                  isLoadingListAttachContent = false;
//                  this.updateState();
//                }
//              });
//      }
//    }
    onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      margin: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: ListView.builder(
          itemCount: widget.listIrAttachment.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            IrAttachment item = widget.listIrAttachment[index];
            Uint8List image;
            if (item.datas != null) image = base64.decode(item.datas);
            String extension = item.mimetype.toString().split("/").last;
//            print("Url::::" + listUrlAttach[index].split('?')[0]);
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: item.datas != null
                  ? Stack(
                      children: <Widget>[
                        extension == "png" ||
                                extension == "jpg" ||
                                extension == "jpeg" ||
                                extension == "gif" ||
                                extension == "bmp"
                            ? image != null
                                ? Container(
                                    width: 100,
                                    height: 60,
                                    margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image.memory(
                                        image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container()
                            :
                            Container(
                                width: 100,
                                height: 60,
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                        InkWell(
                          child: Container(
                            width: 100,
                            height: 60,
                          ),
                          onTap: () async {
                            String dir = await createFileFromString(
                                item.datas, item.name);
                            if (dir != null) {
                              if (isImage(extension))
                                showGeneralDialog(
                                    transitionBuilder:
                                        (context, a1, a2, widget) {
                                      return ViewImageWidget(
                                        pathImageFile: dir,
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
                                    });
                              else
                                OpenFile.open(dir);
                              print("luu thanh cong + $dir");
                            } else {
                              print("luu that bai");
                            }
                          },
                        ),
                        Positioned(
                          top: 40,
                          right: 15,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black54, shape: BoxShape.circle),
                            child: Icon(
                              Icons.file_download,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(
//                      color: Colors.green,
                      width: 100,
                      height: 60,
                      margin: EdgeInsets.fromLTRB(0, 10, 10, 30),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.blueGrey)),
                        height: 40,
                        width: 90,
                        padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                        ),
                      ),
                    ),
            );
          }),
    );
  }
}
