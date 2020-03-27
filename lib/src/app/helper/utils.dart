import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/services/common-service.dart';

Future<Uint8List> readFileByte(String filePath) async {
  Uri myUri = Uri.parse(filePath);
  File audioFile = new File.fromUri(myUri);
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
  DateTime dateTime =
      DateTime.parse(DateFormat().parse(time).toIso8601String());
  DateTime now = DateTime.now();
  if (dateTime.day == now.day &&
      dateTime.month == now.month &&
      dateTime.year == now.year) {
    _time = DateFormat("hh:mm").format(dateTime);
  }
  _time = DateFormat("dd/MM").format(dateTime);
  return _time;
}
