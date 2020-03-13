import 'dart:io';
import 'dart:typed_data';

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
bool compareText(String text1, String text2){
  return Common.sanitizing(text1).toLowerCase().contains(Common.sanitizing(text2).toLowerCase());
}