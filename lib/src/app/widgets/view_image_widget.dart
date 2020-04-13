import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/helper/utils.dart';

class ViewImageWidget extends StatelessWidget {
  final String imageData;
  final String name;
  const ViewImageWidget({Key key, this.imageData, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Uint8List image = base64.decode(imageData);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.black54,
          child: Center(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.memory(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
//                Positioned(
//                  top: 0,
//                  right: 0,
//                  child: Container(
//                    decoration: BoxDecoration(
//                        color: Colors.black54, shape: BoxShape.circle),
//                    child: InkWell(
////                          padding: EdgeInsets.all(2),
//                      onTap: () {
//                        Navigator.pop(context);
//                      },
//                      child: Icon(
//                        Icons.close,
//                        color: Colors.white,
//                      ),
//                    ),
//                  ),
//                ),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: InkWell(
                    onTap: () {
                      createFileFromString(imageData, name).then((dir) {
                        Navigator.pop(context, dir);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(color: Colors.black54),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.file_download,
                            color: Colors.white,
                          ),
                          Text(
                            translation.text("COMMON.DOWNLOAD"),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
