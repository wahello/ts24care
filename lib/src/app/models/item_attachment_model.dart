import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class ItemAddAttachmentModel{
  int id;
  String localDirectory;
  String fileName;
  Uint8List data;
  String extension;
  ItemAddAttachmentModel({@required this.id,this.localDirectory,this.data,this.fileName,this.extension});
}