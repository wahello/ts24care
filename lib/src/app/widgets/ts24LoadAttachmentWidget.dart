import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/ir-attachment.dart';
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

  @override
  void initState() {
    int count = 0;
    widget.listIrAttachment.forEach((item) {
      api.getUrlDownloadAttachment(item.id).then((_url) {
        String url = '';
        if (_url != null) url = _url['url'];
        listUrlAttach.add(url);
        count++;
        if (count == widget.listIrAttachment.length)
          setState(() {
            print("Update State");
          });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      margin: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: listUrlAttach.length > 0
          ? ListView.builder(
              itemCount: widget.listIrAttachment.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                IrAttachment item = widget.listIrAttachment[index];
                String extension = item.mimetype.toString().split("/").last;
                print("Url::::" + listUrlAttach[index].split('?')[0]);
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Stack(
                    children: <Widget>[
                      extension == "png" ||
                              extension == "jpg" ||
                              extension == "jpeg" ||
                              extension == "gif" ||
                              extension == "bmp"
                          ? Container(
                              width: 100,
                              height: 60,
                              margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child:
//                  Image.asset(
//                    widget.listIdAttachment[index].localDirectory,
//                    height: 90,
//                    width: 40,
//                    fit: BoxFit.cover,
//                  )

                                    CachedNetworkImage(
                                  imageUrl: listUrlAttach[index].split('?')[0],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    height: MediaQuery.of(context).size.width *
                                        0.33,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: getColor(extension))),
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 30, 10),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blueGrey),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                  color: getColor(extension))),
                                          child: Icon(
                                            Icons.error_outline,
                                            color: getColor(extension),
                                          )),
                                ),
                              ),
                            )
                          :
//                      (model.id == -1)
//                              ? Container(
//                                  width: 100,
//                                  height: 60,
//                                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
//                                  child: Container(
//                                    decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.all(
//                                            Radius.circular(10)),
//                                        border: Border.all(
//                                            color: getColor(model.extension))),
//                                    height: 40,
//                                    width: 90,
//                                    padding: EdgeInsets.all(5),
//                                    child: Center(
//                                      child: SizedBox(
//                                        width: 20,
//                                        height: 20,
//                                        child: CircularProgressIndicator(
//                                          valueColor:
//                                              AlwaysStoppedAnimation<Color>(
//                                                  Colors.blueGrey),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                )
//                              :
                          Container(
                              width: 100,
                              height: 60,
                              margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border:
                                        Border.all(color: getColor(extension))),
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
                                      style:
                                          TextStyle(color: getColor(extension)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black54, shape: BoxShape.circle),
                          child: InkWell(
//                          padding: EdgeInsets.all(2),
                            onTap: () async{
//                              final taskId = await FlutterDownloader.enqueue(
//                                fileName: item.name,
//                                url: listUrlAttach[index],
//                                savedDir: '/storage/emulated/0/Download/',
//                                showNotification: true, // show download progress in status bar (for Android)
//                                openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//                              );
//                              setState(() {

//                                  widget.listIdAttachment.removeAt(index);
//                                  widget.onCallback(widget.listIdAttachment);
//                              });
                            },
                            child: Icon(
                              Icons.file_download,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
          : Container(),
    );
  }
}
