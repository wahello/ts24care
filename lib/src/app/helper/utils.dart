import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/models/ts24_product_category.dart';
import 'package:ts24care/src/app/services/common-service.dart';
import 'package:flutter/material.dart' as meterial;

Future<Uint8List> readFileByte(String filePath) async {
  Uri myUri = Uri.parse(filePath);
  File audioFile = new File.fromUri(myUri); //File.fromUri(Uri.parse(path))
  Uint8List bytes;
  await audioFile.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value);
    print('reading of bytes is completed');
  }).catchError((onError) {
    print(
        'Exception Error while reading audio from path:' + onError.toString());
  });
  return bytes;
}

bool compareText(String text1, String text2) {
  return Common.sanitizing(text1)
      .toLowerCase()
      .contains(Common.sanitizing(text2).toLowerCase());
}

String getUrlImage(String css) {
  String url;
  Map parse = jsonDecode(css);
  String tempUrl = parse["background-image"];
  if (!tempUrl.contains("none")) {
    url = domainApi + tempUrl.substring(4, tempUrl.length - 2);
    print(url);
    var _indexCut = url.indexOf("?access_token");
    if (_indexCut != -1) url = url.substring(0, _indexCut);
  }
  return url;
}

String addDomainHtml(String html) {
  var document = parse(html);
  List<Element> b = document.getElementsByTagName("img");
  b.forEach((item) {
    var url = item.attributes["src"].toString();
    if (!url.contains("http")) {
      url = domainApi + url;
      item.attributes["src"] = url;
    }
  });
  return document.outerHtml;
}

String formatTime(String time) {
  String _time = "";
  DateTime dateTime = DateTime.parse(
      DateFormat("dd/MM/yyyy hh:mm:ss").parse(time).toIso8601String());
  DateTime now = DateTime.now();
  if (dateTime.day == now.day &&
      dateTime.month == now.month &&
      dateTime.year == now.year) {
    _time = DateFormat("hh:mm").format(dateTime);
  }
  if (dateTime.year != now.year)
    _time = DateFormat("dd/MM/yyyy").format(dateTime);
  else
    _time = DateFormat("dd/MM").format(dateTime);
  return _time;
}

String formatTimeV2(String time) {
  String _time = "";
  DateTime dateTime = DateTime.parse(
      DateFormat("dd/MM/yyyy hh:mm:ss").parse(time).toIso8601String());
  _time = DateFormat("dd/MM/yyyy  hh:mm").format(dateTime);
  return _time;
}

String getCharStatusState(MenuStatusState state) {
  String _char = 'N';
  switch (state) {
    case MenuStatusState.NEW:
      _char = 'N';
      break;
    case MenuStatusState.IN_PROGRESS:
      _char = 'I';
      break;
    case MenuStatusState.CANCEL:
      _char = 'C';
      break;
    case MenuStatusState.SOLVED:
      _char = 'S';
      break;
    case MenuStatusState.ALL:
      _char = 'A';
      break;
  }
  return _char;
}

String getFileNameFromPath(String path) {
  return path.split("/").last;
}

String getExtensionFromPath(String path) {
  return path.split(".").last;
}

String getNameTicketStatus(int id) {
  String name = "New";
  switch (id) {
    case 1:
      name = "New";
      break;
    case 2:
      name = "InProgress";
      break;
    case 3:
      name = "Solved";
      break;
    case 5:
      name = "Cancel";
      break;
  }
  return name;
}

bool isImage(String extension) {
  return extension == "png" ||
      extension == "jpg" ||
      extension == "jpeg" ||
      extension == "gif" ||
      extension == "bmp";
}

Future<String> createFileFromString(
    String data, String nameAndExtension) async {
  final encodedStr = data;
  Uint8List bytes = base64.decode(encodedStr);
//  String dir = (await getApplicationDocumentsDirectory()).path;
//  if(isImage(extension))
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File("$dir/" + nameAndExtension);
  await file.writeAsBytes(bytes);
  return file.path;
}

meterial.Color getColorCategory(String categoryName) {
  TS24ProductCategory result;
  var category = TS24ProductCategory.list
      .where((item) => item.name.toLowerCase() == categoryName.toLowerCase());
  if (category.length > 0) {
    result = category.first;
    return result.color;
  }
  return meterial.Colors.white;
}

meterial.Color parseStringToColor(String string){
  String _strColor = string.replaceFirst("#", "0xFF");
  int _iColor = int.parse(_strColor);
  return meterial.Color(_iColor);
}
